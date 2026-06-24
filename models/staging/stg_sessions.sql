with raw_source as ( -- had to rename this to avoid confusion with the source() function
    select * from {{ source('bq_raw', 'raw_sessions') }}
)

select
    cast(session_id as string) as session_id,
    cast(customer_id as string) as customer_id,
    cast(start_time as timestamp) as session_start_timestamp,
    cast(device as string) as device_type,
    cast(source as string) as traffic_source, 
    cast(country as string) as country
from raw_source  