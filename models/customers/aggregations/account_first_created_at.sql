{{ config(
    materialized='aggregation',
    activity_name='created_account',
    attribute='activity_at',
    aggfunc='min',
    after_timestamp=none,
    before_timestamp=none
)}}

{{ dbt_activity_schema.build_aggregation(ref('customer_activity_stream')) }}
