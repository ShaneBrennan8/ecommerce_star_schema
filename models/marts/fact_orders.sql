{{
    config(
        materialized='table',
        unique_key='order_item_id'
    )
}}

with orders as (
    select * from {{ ref('stg_orders') }}
),

order_items as (
    select * from {{ ref('stg_order_items') }}
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

{% if is_incremental() %}
  -- This filter will balance performance down the line when converted to incremental
  where o.order_date > (select max(order_date) from {{ this }})
{% endif %}


--##Note: To shift from full table replacement to append-only in the future, 
--##simply change materialized='table' to materialized='incremental' and add incremental_strategy='append' to the config block.