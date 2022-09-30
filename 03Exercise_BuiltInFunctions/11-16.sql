-- 11. Mix of Peak and River Names

use geography;

SELECT 
    peak_name,
    river_name,
    LOWER(CONCAT(LEFT(peak_name, LENGTH(peak_name) - 1),
                    river_name)) AS mix
FROM
    peaks,
    rivers
WHERE
    RIGHT(peak_name, 1) = LEFT(river_name, 1)
    order by mix;
    
-- 12. Games From 2011 and 2012 Year

use diablo;

SELECT 
    name, DATE_FORMAT(start, '%Y-%m-%d')
FROM
    games
WHERE
    YEAR(start) >= 2011
        AND YEAR(start) <= 2012
ORDER BY start , name
LIMIT 50;

-- 13. User Email Providers

SELECT 
    user_name,
    SUBSTR(email,
        POSITION('@' IN email) + 1) AS 'email provider'
FROM
    users
ORDER BY SUBSTR(email,
    POSITION('@' IN email) + 1) , user_name;
    
    
-- 14. Get Users with IP Address Like Pattern

SELECT 
    user_name,
    ip_address
FROM
    users
    where ip_address like '___.1%.%.___'
ORDER BY user_name;
    
-- 15. Show All Games with Duration

SELECT 
    name,
    CASE
        WHEN (HOUR(start) >= 0 AND HOUR(start) < 12) THEN 'Morning'
        WHEN (HOUR(start) >= 12 AND HOUR(start) < 18) THEN 'Afternoon'
        WHEN (HOUR(start) >= 18 AND HOUR(start) < 24) THEN 'Evening'
    END AS 'Part of the Day',
    CASE
        WHEN duration <= 3 THEN 'Extra Short'
        WHEN duration > 3 AND duration <= 6 THEN 'Short'
        WHEN duration > 6 AND duration <= 10 THEN 'Long'
        else 'Extra Long'
    END AS duration
FROM
    games;


-- 16. Orders Table


use orders;

SELECT 
    product_name,
    order_date,
    DATE_ADD(order_date, INTERVAL 3 DAY) AS 'pay_due',
    DATE_ADD(order_date, INTERVAL 1 MONTH) AS 'deliver_due'
FROM
    orders;
