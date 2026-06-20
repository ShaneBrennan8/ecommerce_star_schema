
  
    

    create or replace table `evocative-depot-427007-m8`.`online_ecommerce_star_schema_marts`.`dim_customers`
      
    
    

    OPTIONS()
    as (
      select
        customer_id,
        customer_name, 
        email,
        signup_date,
        country,
        age,
        signup_date,
        marketing_opt_in
from `evocative-depot-427007-m8`.`online_ecommerce_star_schema_staging`.`stg_customers`
    );
  