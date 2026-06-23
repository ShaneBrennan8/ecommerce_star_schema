
  
    

    create or replace table `evocative-depot-427007-m8`.`online_ecommerce_star_schema_marts`.`dim_products`
      
    
    

    OPTIONS()
    as (
      select
    product_id,
    product_name,
    category,
    price,
    cost_usd,
    margin_usd
from `evocative-depot-427007-m8`.`online_ecommerce_star_schema_staging`.`stg_products`
    );
  