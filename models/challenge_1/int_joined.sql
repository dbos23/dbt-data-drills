with bookings as (
    select *
    from {{ ref('stg_bookings') }}
),

customers as (
    select *
    from {{ ref('stg_customers') }}
),

flights as (
    select *
    from {{ ref('stg_flights') }}
),

joined as (
    select
        bookings.*,
        flights.flight_date,
        flights.mileage,
        customers.customer_id,
        customers.customer_name,
        case
            when rank() over(partition by booking_id order by flight_date asc) = 1
            then booking_price
        end as loyalty_spend
    from bookings
        left join flights
            on bookings.flight_id = flights.flight_id
        left join customers
            on bookings.frequent_flyer_id = customers.frequent_flyer_id
)

select *
from joined