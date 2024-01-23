with fct_orders as (
    select * from {{ ref('fct_orders')}}
),

dim_customers as  (
    select * from {{ ref('dim_customers' )}}
),

total_amount_per_customer_on_orders_complete as (
    select
        cust.customer_id,
        cust.first_name,
        SUM(total_amount) as global_paid_amount
    from fct_orders as ord
    left join dim_customers as cust ON ord.customer_id = cust.customer_id
    where ord.is_order_completed = 1
    group by cust.customer_id, first_name
),

customer_range_per_paid_ammount as (
    select * from {{ ref('customer_range_per_paid_ammount' )}}

)

select
        tac.customer_id,
        tac.first_name,
        tac.global_paid_amount,
        crp.classification
from total_amount_per_customer_on_orders_complete as tac
left join customer_range_per_paid_ammount as crp on tac.global_paid_amount >= crp.min_range and tac.global_paid_amount <= crp.max_range
