select 
    id as payment_id,
    orderid as order_id,
    paymentmethod as payment_method,
    case
        when paymentmethod in ('stripe', 'paypal', 'credit_card', 'gift_card') then 'credit'
        else 'cash'
    end as payment_type,
    status,
    amount as amount,
    case
        when status = 'success' then true
        else false
    end as is_completed_payment,
    created as created_date
from {{ source('stripe', 'payment') }}