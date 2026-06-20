with source as (
    select * from {{ source('bq_raw', 'raw_sessions') }}
)

select
    cast(session_id as string) as session_id,
    cast(customer_id as string) as customer_id,
    cast(start_time as datetime) as session_start_timestamp, -- Mapped from session_start
   -- cast(end_time as timestamp) as session_end_timestamp,     -- Mapped from session_end
    cast(device as string) as device_type,
    cast(source as string) as traffic_source,
    cast(country as string) as country
from source