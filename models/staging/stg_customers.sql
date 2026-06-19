with source as (
    select * from {{ source('bq_raw', 'raw_customers') }}
)

select
    cast(customer_id as string) as customer_id,
    cast(name as string) as customer_name, -- Mapped from name
    cast(email as string) as email,
    cast(signup_date as timestamp) as signup_date,
    cast(country as string) as country
from source 

--temp comment just so I can push
--and another
