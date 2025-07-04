-- Query for Objective 2.1: INNER JOIN Bookings and Users
SELECT
    B.booking_id,
    B.start_date,
    B.end_date,
    B.total_price,
    B.status,
    U.first_name,
    U.last_name,
    U.email
FROM
    Bookings AS B
INNER JOIN
    Users AS U ON B.user_id = U.user_id;

-- Query for Objective 2.2: LEFT JOIN Properties and Reviews
SELECT
    P.property_id,
    P.name AS property_name,
    P.location,
    R.rating,
    R.comment
FROM
    Properties AS P
LEFT JOIN
    Reviews AS R ON P.property_id = R.property_id;

-- Query for Objective 2.3: FULL OUTER JOIN Users and Bookings (using LEFT JOIN + UNION ALL workaround)
SELECT
    U.user_id,
    U.first_name,
    U.last_name,
    B.booking_id,
    B.start_date,
    B.status
FROM
    Users AS U
LEFT JOIN
    Bookings AS B ON U.user_id = B.user_id

UNION ALL

SELECT
    U.user_id, -- Will be NULL for unmatched bookings
    U.first_name, -- Will be NULL for unmatched bookings
    U.last_name, -- Will be NULL for unmatched bookings
    B.booking_id,
    B.start_date,
    B.status
FROM
    Bookings AS B
LEFT JOIN
    Users AS U ON B.user_id = U.user_id
WHERE
    U.user_id IS NULL; -- Ensures we only select unmatched bookings from the second LEFT JOIN
