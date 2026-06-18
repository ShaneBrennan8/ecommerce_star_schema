with source as (
    select * from {{ source('bq_raw', 'raw_orders') }}
)
select
    cast(order_id as string) as order_id,
    cast(customer_id as string) as customer_id,
    cast(order_date as timestamp) as order_date,
    cast(order_status as string) as order_status,
    cast(total_amount as numeric) as total_amount
from source