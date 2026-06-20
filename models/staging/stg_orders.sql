with source as (
    select * from {{ source('bq_raw', 'raw_orders') }}
)

select
    cast(order_id as string) as order_id,
    cast(customer_id as string) as customer_id,
    cast(order_time as datetime) as order_datetime, 
    payment_method,
    discount_pct,
    cast(subtotal_usd as numeric) as subtotal_usd,
    cast(total_usd as numeric) as total_amount_usd,
    cast(country as string) as order_country,
    device as device_type,
    source
from source