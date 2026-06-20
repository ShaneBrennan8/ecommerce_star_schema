with source as (
    select * from {{ source('bq_raw', 'raw_products') }}
)

select
    cast(product_id as string) as product_id,
    cast(name as string) as product_name, 
    cast(category as string) as category,
    cast(price_usd as numeric) as price,
    cast(cost_usd as numeric) as cost_usd,
    cast(margin_usd as numeric) as margin_usd
    --cast(available_stock as int64) as available_stock, leaving as placeholder 
from source