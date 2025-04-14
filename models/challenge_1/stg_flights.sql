with raw_flights as (
    select *
    from {{ source('challenge_1', 'flights') }}
)

select *
from raw_flights