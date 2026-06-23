
  
    

    create or replace table `evocative-depot-427007-m8`.`online_ecommerce_star_schema_marts`.`fact_orders`
      
    
    

    OPTIONS()
    as (
      

with orders as (
    select * from `evocative-depot-427007-m8`.`online_ecommerce_star_schema_staging`.`stg_orders`
),

order_items as (
    select * from `evocative-depot-427007-m8`.`online_ecommerce_star_schema_staging`.`stg_order_items`
),

products as (
    select * from `evocative-depot-427007-m8`.`online_ecommerce_star_schema_staging`.`stg_products`
)

select
    -- 1. Primary Key (Deterministic Surrogate Key via Hashing)
    to_hex(md5(concat(oi.order_id, '_', oi.product_id))) as order_item_key,
    
    -- 2. Foreign Keys / Star Schema Dimensions
    oi.order_id,
    o.customer_id,
    oi.product_id,
    
    -- 3. Temporal Attributes
    o.order_datetime,
    cast(o.order_datetime as date) as order_date,
    
    -- 4. Operational & Marketing Attributes (Degenerate Dimensions)
    o.payment_method,
    o.order_country,
    o.device_type,
    o.source as marketing_acquisition_source,
    
    -- 5. Financial Facts / Calculations
    oi.quantity,
    oi.unit_price_usd,
    p.cost_usd as unit_cost_usd,
    
    -- Gross line revenue before discounts
    oi.line_total_usd as gross_revenue_usd,
    
    -- Dynamic discount impact applied per line item
    round((oi.line_total_usd * (o.discount_pct / 100.0)), 2) as discount_amount_usd,
    
    -- Net revenue realized by the business
    round(oi.line_total_usd - (oi.line_total_usd * (o.discount_pct / 100.0)), 2) as net_revenue_usd,
    
    -- Cost of Goods Sold (COGS)
    round((oi.quantity * p.cost_usd), 2) as total_cogs_usd,
    
    -- Realized net margin profit dollars
    round(
        (oi.line_total_usd - (oi.line_total_usd * (o.discount_pct / 100.0))) - (oi.quantity * p.cost_usd), 
        2
    ) as net_profit_usd

from order_items oi
inner join orders o on oi.order_id = o.order_id
left join products p on oi.product_id = p.product_id


    );
  