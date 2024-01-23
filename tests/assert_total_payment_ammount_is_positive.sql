select
    order_id,
    sum(total_amount) as total_amount
from {{ ref('int_payment_type_ammount_per_order') }}
group by 1
having total_amount < 0