with raw_bookings as (
    select *
    from {{ source('challenge_1', 'bookings') }}
),

raw_bookings_flattened as (
    select
        booking_id,
        flatten.value::int as flight_id,
        booking_price,
        frequent_flyer_id
    from raw_bookings,
        lateral flatten(input => try_parse_json(flight_ids)) as flatten
)

select *
from raw_bookings_flattened