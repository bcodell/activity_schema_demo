{{ config(materialized='table') }}

{{ dbt_activity_schema.build_dataset(
    activity_stream='customer_activity_stream',
    primary_activity='created_account',
    primary_activity_attributes=['customer_first_name', 'customer_last_name'],
    aggregations=['first_order', 'most_recent_order', 'number_of_orders', 'customer_lifetime_value']
)}}