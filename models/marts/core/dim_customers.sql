select
        customer_id,
        customer_name, 
        email,
        country,
        age,
        signup_date,
        marketing_opt_in
from {{ ref('stg_customers') }}