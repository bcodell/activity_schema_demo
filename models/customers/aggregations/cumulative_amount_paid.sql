{{ config(
    materialized='aggregation',
    activity_name='made_payment',
    attribute='payment_amount',
    aggfunc='sum',
    after_timestamp=none,
    before_timestamp='current',
    backup_value=0
)}}

{{ dbt_activity_schema.build_aggregation(ref('customer_activity_stream')) }}
