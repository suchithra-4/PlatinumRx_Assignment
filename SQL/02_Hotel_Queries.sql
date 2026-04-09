SELECT room_no
FROM bookings
ORDER BY booking_date DESC
LIMIT 1;


--> query 2 Q2: Billing in Nov 2021
SELECT b.booking_id, SUM(bc.quantity * i.rate) AS total_bill
FROM bookings b
JOIN booking_commercials bc ON b.booking_id = bc.booking_id
JOIN items i ON bc.item_id = i.item_id
WHERE strftime('%m', b.booking_date) = '11'
AND strftime('%Y', b.booking_date) = '2021'
GROUP BY b.booking_id;


-->query 3 Q3: Bills > 1000
SELECT b.booking_id, SUM(bc.quantity * i.rate) AS total_bill
FROM bookings b
JOIN booking_commercials bc ON b.booking_id = bc.booking_id
JOIN items i ON bc.item_id = i.item_id
GROUP BY b.booking_id
HAVING total_bill > 1000;

--> query 4 Q4: Most/Least ordered item per month
SELECT *
FROM (
    SELECT 
        strftime('%m', b.booking_date) AS month,
        i.item_name,
        SUM(bc.quantity) AS total_qty,
        
        RANK() OVER (
            PARTITION BY strftime('%m', b.booking_date)
            ORDER BY SUM(bc.quantity) DESC
        ) AS rnk_desc,

        RANK() OVER (
            PARTITION BY strftime('%m', b.booking_date)
            ORDER BY SUM(bc.quantity)
        ) AS rnk_asc

    FROM bookings b
    JOIN booking_commercials bc ON b.booking_id = bc.booking_id
    JOIN items i ON bc.item_id = i.item_id
    
    GROUP BY month, i.item_name
)
WHERE rnk_desc = 1 OR rnk_asc = 1;

--> query 4 Q5: 2nd Highest Bill

SELECT *
FROM (
    SELECT 
        b.booking_id,
        SUM(bc.quantity * i.rate) AS total_bill,
        RANK() OVER (ORDER BY SUM(bc.quantity * i.rate) DESC) AS rnk
    FROM bookings b
    JOIN booking_commercials bc ON b.booking_id = bc.booking_id
    JOIN items i ON bc.item_id = i.item_id
    GROUP BY b.booking_id
) t
WHERE rnk = 2;