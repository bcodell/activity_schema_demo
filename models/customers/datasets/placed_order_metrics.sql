{{ config(
   materialized='table'
)}}
 
{{ dbt_activity_schema.build_dataset(
   activity_stream='customer_activity_stream',
   primary_activity='placed_order',
   primary_activity_attributes=['order_status'],
   aggregations=['first_order_placed_at', 'cumulative_amount_paid']
)}}
