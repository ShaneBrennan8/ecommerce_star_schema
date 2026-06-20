with source as (
    select * from `evocative-depot-427007-m8`.`online_ecommerce_star_schema_raw`.`raw_order_items`
)

select
    cast(order_id as string) as order_id,
    generate_uuid() as order_id_secondary, -- Generates a clean key if missing
    cast(product_id as string) as product_id,
    unit_price_usd,
    cast(quantity as int64) as quantity,
    cast(line_total_usd as float64) as line_total_usd

from source