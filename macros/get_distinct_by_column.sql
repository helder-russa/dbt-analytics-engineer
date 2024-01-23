{# Generic macro to given a column name and table, outputs
the distinct fields of the given column name #}
{% macro get_column_values(column_name, relation) %}

{% set relation_query %}
    select distinct
    {{ column_name }}
    from {{ relation }}
    order by 1
{% endset %}

{% set results = run_query(relation_query) %}

{% if execute %}
{# Return the first column #}
{% set results_list = results.columns[0].values() %}
{% else %}
{% set results_list = [] %}
{% endif %}

{{ return(results_list) }}

{% endmacro %}

{# Macro to get the distinct payment_types #}
{% macro get_payment_types() %}

{{ return(get_column_values('payment_type', ref('stg_stripe_order_payments'))) }}

{% endmacro %}

{# Macro to get the distinct payment_methods #}
{% macro get_payment_methods() %}

{{ return(get_column_values('payment_method', ref('stg_stripe_order_payments'))) }}

{% endmacro %}