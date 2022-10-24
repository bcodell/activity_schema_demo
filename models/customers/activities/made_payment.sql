{{ config(
    materialized='activity',
    activity_stream='customer_activity_stream',
    attributes={
        'payment_amount': {'data_type': type_int()},
        'payment_method': {'data_type': type_string()},
        'payment_failed': {'data_type': 'bool'}
    }
)}}

with payments as (
    select
        o.customer_id
        , p.payment_created_at as activity_at
        , p.payment_amount
        , p.payment_method
        , p.payment_amount = 0 as payment_failed
    from {{ ref('stg_payments') }} p
    inner join {{ ref('stg_orders') }} o
        on p.order_id = o.order_id
)
{{ dbt_activity_schema.build_activity(cte='payments') }}
