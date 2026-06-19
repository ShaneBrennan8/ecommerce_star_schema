with source as (
    select * from {{ source('bq_raw', 'raw_order_items') }}
)

select
    generate_uuid() as order_item_id, -- Generates a clean key if missing
    cast(order_id as string) as order_id,
    cast(product_id as string) as product_id,
    cast(quantity as int64) as quantity,
    cast(price as numeric) as price
from source