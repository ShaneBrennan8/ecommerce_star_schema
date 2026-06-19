
  
    

    create or replace table `evocative-depot-427007-m8`.`online_ecommerce_star_schema`.`dim_customers`
      
    
    

    OPTIONS()
    as (
      select
    customer_id,
    customer_name,
    customer_email,
    customer_city,
    customer_state
from `evocative-depot-427007-m8`.`online_ecommerce_star_schema`.`stg_customers`
    );
  