with source as (
    select * from `evocative-depot-427007-m8`.`online_ecommerce_star_schema`.`raw_events`
)

select
    cast(event_id as string) as event_id,
    cast(session_id as string) as session_id,
    cast(user_id as string) as customer_id, -- Mapped from user_id
    cast(event_type as string) as event_type,
    cast(event_timestamp as timestamp) as event_timestamp,
    cast(page_url as string) as page_url
from source