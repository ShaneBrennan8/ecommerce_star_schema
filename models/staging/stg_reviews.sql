with source as (
    select * from {{ source('bq_raw', 'raw_reviews') }}
)

select
    cast(review_id as string) as review_id,
    cast(product_id as string) as product_id,
    cast(user_id as string) as customer_id, -- Mapped from user_id
    cast(rating as int64) as rating,
    cast(review_text as string) as review_text,
    cast(review_date as timestamp) as review_date
from source