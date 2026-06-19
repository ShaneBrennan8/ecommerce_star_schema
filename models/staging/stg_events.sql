with source as (
    select * from {{ source('bq_raw', 'raw_events') }}
)

select
    cast(event_id as string) as event_id,
    cast(session_id as string) as session_id,
    cast(user_id as string) as customer_id, -- Mapped from user_id
    cast(event_type as string) as event_type,
    cast(event_timestamp as timestamp) as event_timestamp,
    cast(page_url as string) as page_url
from source