{%- set payment_types= get_payment_types() -%}
 
with 

payments as (

   select * from {{ ref('stg_stripe_order_payments') }}

),
 
pivot_and_aggregate_payments_to_order_grain as (
   
   select
      order_id,     
      {% for payment_type in payment_types -%}
 
         sum(
            case
               when payment_type = '{{ payment_type }}' and
                    status = 'success' 
               then amount 
               else 0 
            end
         ) as {{ payment_type }}_amount,

      {%- endfor %}
      sum(case when status = 'success' then amount end) as total_amount

   from payments

   group by 1

)
 
select * from pivot_and_aggregate_payments_to_order_grain