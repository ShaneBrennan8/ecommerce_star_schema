

  create or replace view `evocative-depot-427007-m8`.`online_ecommerce_star_schema`.`stg_sessions`
  OPTIONS()
  as with source as (
    select * from `evocative-depot-427007-m8`.`online_ecommerce_star_schema`.`raw_sessions`
)

select
    cast(session_id as string) as session_id,
    cast(customer_id as string) as customer_id,
    cast(session_start as timestamp) as session_start_timestamp, -- Mapped from session_start
    cast(session_end as timestamp) as session_end_timestamp,     -- Mapped from session_end
    cast(device_type as string) as device_type,
    cast(traffic_source as string) as traffic_source
from source;

