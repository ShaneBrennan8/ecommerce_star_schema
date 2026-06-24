{{
    config(
        materialized='table',
        unique_key='session_key'
    )
}}

with events as (
    select * from {{ ref('stg_events') }}
),

sessions as (
    select * from {{ ref('stg_sessions') }}
),

-- Aggregate raw user event interactions down to the session grain
session_event_aggregation as (
    select
        session_id,
        
        -- Core timeline boundaries based on click logs
        min(event_timestamp) as activity_started_at,
        max(event_timestamp) as activity_ended_at,
        
        -- Interaction volume metrics
        count(event_id) as total_interactions,
        count(case when event_type = 'page_view' then event_id end) as page_view_count,
        
        -- Dynamic e-commerce conversion funnel flags (Boolean markers)
        max(case when event_type = 'product_view' then 1 else 0 end) as flag_viewed_product,
        max(case when event_type = 'add_to_cart' then 1 else 0 end) as flag_added_to_cart,
        max(case when event_type = 'checkout' then 1 else 0 end) as flag_initiated_checkout,
        max(case when event_type = 'purchase' then 1 else 0 end) as flag_completed_purchase,
        
        -- Isolate financial purchase values directly from the event payload stream
        max(case when event_type = 'purchase' then amount_usd else 0.0 end) as total_session_purchase_amount_usd
        
    from events
    group by 1
)

select
    -- 1. Unique Surrogate Primary Key
    to_hex(md5(s.session_id)) as session_key,
    s.session_id,
    
    -- 2. Star Schema Dimension References (Pulled from stg_sessions)
    coalesce(s.customer_id, 'anonymous_guest') as customer_id,
    cast(s.session_start_timestamp as date) as session_date,
    
    -- 3. Contextual Attributes / Degenerate Dimensions (Pulled from stg_sessions)
    s.device_type,
    s.traffic_source,
    s.country,
    
    -- 4. Temporal Session Durations
    s.session_start_timestamp as session_started_at,
    sea.activity_ended_at,
    timestamp_diff(cast (sea.activity_ended_at as timestamp), cast(s.session_start_timestamp as timestamp), second) as session_duration_seconds,
    
    -- 5. Behavior Volume Facts
    coalesce(sea.total_interactions, 0) as total_interactions,
    coalesce(sea.page_view_count, 0) as page_view_count,
    
    -- 6. Funnel Boolean Outputs
    cast(coalesce(sea.flag_viewed_product, 0) as boolean) as has_viewed_product,
    cast(coalesce(sea.flag_added_to_cart, 0) as boolean) as has_added_to_cart,
    cast(coalesce(sea.flag_initiated_checkout, 0) as boolean) as has_initiated_checkout,
    cast(coalesce(sea.flag_completed_purchase, 0) as boolean) as is_converted_purchase,
    
    -- 7. Revenue Metrics
    coalesce(sea.total_session_purchase_amount_usd, 0.0) as total_session_purchase_amount_usd,
    
    -- 8. Advanced Drop-off & Engagement Flags
    case 
        when sea.flag_added_to_cart = 1 and sea.flag_completed_purchase = 0 then true 
        else false 
    end as is_abandoned_cart,
    
    case
        when sea.total_interactions = 1 or sea.total_interactions is null then true
        else false
    end as is_bounced_session

from sessions s
left join session_event_aggregation sea on s.session_id = sea.session_id