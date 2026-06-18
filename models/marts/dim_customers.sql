select
    customer_id,
    customer_name,
    customer_email,
    customer_city,
    customer_state
from {{ ref('stg_customers') }}