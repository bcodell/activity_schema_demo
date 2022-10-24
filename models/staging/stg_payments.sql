select
    id as payment_id
    , created_at as payment_created_at
    , order_id
    , payment_method
    , amount as payment_amount
from {{ ref('raw_payments') }}