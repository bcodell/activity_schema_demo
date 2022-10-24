{{ config(
    materialized='activity_stream',
    materialization_strategy='incremental'
)}}

{%- set activities = [
    ref('created_account'),
    ref('placed_order'),
    ref('made_payment')
]-%}

{{ dbt_activity_schema.build_activity_stream(activities) }}
