

  create or replace view `evocative-depot-427007-m8`.`online_ecommerce_star_schema_staging`.`stg_customers`
  OPTIONS()
  as with source as (
    select * from `evocative-depot-427007-m8`.`online_ecommerce_star_schema_raw`.`raw_customers`
)

select
    cast(customer_id as string) as customer_id,
    cast(name as string) as customer_name, 
    cast(email as string) as email,
    cast(country as string) as country,
    cast(age as int64) as age,
    cast(signup_date as date) as signup_date,
    cast(marketing_opt_in as bool) as marketing_opt_in
from source;

