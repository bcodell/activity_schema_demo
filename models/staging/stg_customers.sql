select
    id as customer_id
    , created_at as customer_created_at
    , first_name as customer_first_name
    , last_name as customer_last_name
from {{ ref('raw_customers') }}