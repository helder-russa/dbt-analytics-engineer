{# Macro that considering the target name, limits the amount of data queried #}
{% macro limit_dataset_if_not_deploy_env(column_name, nbr_months_of_data) %}
-- limit the amount of data queried if not in deploy environment.
{% if target.name != 'deploy' %}
where {{ column_name }} > DATE_SUB(CURRENT_DATE(), INTERVAL {{ nbr_months_of_data }} MONTH)
{% endif %}
{% endmacro %}