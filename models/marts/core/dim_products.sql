select
    product_id,
    product_name,
    category,
    price,
    cost_usd,
    margin_usd
from {{ ref('stg_products') }}