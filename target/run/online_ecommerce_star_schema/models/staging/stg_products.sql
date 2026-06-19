

  create or replace view `evocative-depot-427007-m8`.`online_ecommerce_star_schema`.`stg_products`
  OPTIONS()
  as with source as (
    select * from `evocative-depot-427007-m8`.`online_ecommerce_star_schema`.`raw_products`
)

select
    cast(product_id as string) as product_id,
    cast(name as string) as product_name, -- Mapped from name
    cast(category as string) as category,
    cast(price as numeric) as price,
    cast(stock_quantity as int64) as stock_quantity
from source;

