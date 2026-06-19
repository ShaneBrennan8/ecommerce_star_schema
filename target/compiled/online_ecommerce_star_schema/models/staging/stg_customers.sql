with source as (
    select * from `evocative-depot-427007-m8`.`online_ecommerce_star_schema`.`raw_customers`
)

select
    cast(customer_id as string) as customer_id,
    cast(name as string) as customer_name, -- Mapped from name
    cast(email as string) as email,
    cast(signup_date as timestamp) as signup_date,
    cast(country as string) as country
from source 

--temp comment just so I can push