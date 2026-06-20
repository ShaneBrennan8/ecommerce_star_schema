with source as (
    select * from {{ source('bq_raw', 'raw_customers') }}
)

select
    cast(customer_id as string) as customer_id,
    cast(name as string) as customer_name, -- Mapped from name
    cast(email as string) as email,
    cast(country as string) as country,
    cast(age as int64) as age,
    cast(signup_date as date) as signup_date,
    cast(marketing_opt_in as bool) as marketing_opt_in
from source 

--temp comment just so I can push
--and another
