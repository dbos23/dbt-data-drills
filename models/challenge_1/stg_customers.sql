with raw_customers as (
    select *
    from {{ source('challenge_1', 'customers') }}
)

select *
from raw_customers