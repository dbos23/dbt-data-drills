with joined as (
    select *
    from {{ ref('int_joined') }}
),

aggregated as (
    select
        frequent_flyer_id,
        customer_id,
        sum(mileage) AS total_mileage,
        count(flight_id) AS total_flights,
        year(date(flight_date, 'dd/mm/yyyy')) AS year_of_flight,
        sum(loyalty_spend) AS total_loyalty_spend
    from joined
    group by all
)

select *
from aggregated