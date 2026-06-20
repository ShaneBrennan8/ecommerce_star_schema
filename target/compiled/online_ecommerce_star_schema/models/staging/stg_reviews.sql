with source as (
    select * from `evocative-depot-427007-m8`.`online_ecommerce_star_schema_raw`.`raw_reviews`
)

select
    cast(review_id as string) as review_id,
    cast(order_id as string) as order_id,
    cast(product_id as string) as product_id,
    cast(rating as int64) as rating,
    cast(review_text as string) as review_text,
    cast(review_time as date) as review_date
from source