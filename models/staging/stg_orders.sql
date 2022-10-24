select
    id as order_id
    , user_id as customer_id
    , cast(order_date as timestamp) as order_created_at
    , status as order_status
from {{ ref('raw_orders') }}
