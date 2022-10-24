{{ config(
    materialized='activity',
    activity_stream='customer_activity_stream',
    attributes={
        'order_status': {'data_type': type_string()}
    }
)}}

with orders as (
    select
        customer_id
        , order_created_at as activity_at
        , order_status
    from {{ ref('stg_orders') }}
)
{{ dbt_activity_schema.build_activity(cte='orders') }}
