
  
    

    create or replace table `evocative-depot-427007-m8`.`online_ecommerce_star_schema_marts`.`fact_orders`
      
    
    

    OPTIONS()
    as (
      

with orders as (
    select * from `evocative-depot-427007-m8`.`online_ecommerce_star_schema_staging`.`stg_orders`
),

order_items as (
    select * from `evocative-depot-427007-m8`.`online_ecommerce_star_schema_staging`.`stg_order_items`
)

select
    oi.order_item_id,
    o.order_id,
    o.customer_id,
    oi.product_id,
    o.order_date,
    o.order_status,
    oi.quantity,
    oi.price,
    (oi.quantity * oi.price) as extended_price_amount
from order_items oi
join orders o on oi.order_id = o.order_id




--##Note: To shift from full table replacement to append-only in the future, 
--##simply change materialized='table' to materialized='incremental' and add incremental_strategy='append' to the config block.
    );
  