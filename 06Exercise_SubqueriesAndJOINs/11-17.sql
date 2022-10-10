-- 11. Min Average Salary

SELECT 
    AVG(salary) as min_average_salary
FROM
    employees
    group by department_id
    order by min_average_salary
    limit 1;
    
-- 12. Highest Peaks in Bulgaria

use geography;

SELECT 
    c.country_code, m.mountain_range, p.peak_name, p.elevation
FROM
    peaks p,
    mountains_countries c,
    mountains m
WHERE
    p.mountain_id = c.mountain_id
        AND p.mountain_id = m.id
        AND country_code = 'BG'
        AND p.elevation > 2835
ORDER BY p.elevation DESC;

-- 13. Count Mountain Ranges

SELECT 
    c.country_code, COUNT(m.mountain_range) AS mountain_range
FROM
    mountains_countries c,
    mountains m
WHERE
    c.mountain_id = m.id
        AND country_code IN ('BG' , 'RU', 'US')
GROUP BY c.country_code
ORDER BY mountain_range DESC;

-- 14. Countries with Rivers

