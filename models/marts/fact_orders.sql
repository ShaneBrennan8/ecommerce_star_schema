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
    o.order_id,
    o.customer_id,
    oi.product_id,
    o.order_datetime,
    oi.unit_price_usd,
    (oi.quantity * oi.unit_price_usd) as extended_price_amount
from order_items oi
join orders o on oi.order_id = o.order_id

{% if is_incremental() %}
  -- This filter will balance performance down the line when converted to incremental
  where o.order_date > (select max(order_date) from {{ this }})
{% endif %}


--##Note: To shift from full table replacement to append-only in the future, 
--##simply change materialized='table' to materialized='incremental' and add incremental_strategy='append' to the config block.