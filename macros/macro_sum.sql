{% macro sum(x, y) -%} 
    select {{ x + y }}
{%- endmacro %}