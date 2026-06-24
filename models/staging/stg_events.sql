with source as (
    select * from {{ source('bq_raw', 'raw_events') }}
)

select
    cast(event_id as string) as event_id,
    cast(session_id as string) as session_id,
    cast(event_type as string) as event_type,
    
    -- UPSTREAM FIX: Safely handle both true timestamps and rogue string formats
   ----format_timestamp('%Y-%m-%d %H:%M:%S UTC', timestamp) as event_timestamp,
   cast(timestamp as timestamp) as event_timestamp,

    product_id, 
    qty,
    cart_size,
    payment,
    discount_pct,
    amount_usd

from source