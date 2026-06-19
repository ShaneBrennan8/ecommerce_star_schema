with source as (
    select * from {{ source('bq_raw', 'raw_orders') }}
)

select
    cast(order_id as string) as order_id,
    cast(customer_id as string) as customer_id,
    cast(order_time as timestamp) as order_date, -- Mapped from order_time
    cast(order_status as string) as order_status,
    cast(total_amount as numeric) as total_amount
from source