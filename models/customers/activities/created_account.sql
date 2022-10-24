{{ config(
    materialized='activity',
    activity_stream='customer_activity_stream',
    attributes={
        'customer_first_name': {'data_type': type_string()},
        'customer_last_name': {'data_type': type_string()},
        'customer_full_name': {'data_type': type_string()}
    }
)}}

with customers as (
    select
        customer_id
        , customer_created_at as activity_at
        , customer_first_name
        , customer_last_name
        , customer_first_name || ' ' || customer_last_name as customer_full_name
    from {{ ref('stg_customers') }}
)
{{ dbt_activity_schema.build_activity(cte='customers') }}
