-- 1. Departments Info

SELECT 
    department_id, COUNT(id)
FROM
    employees
GROUP BY department_id;


-- 2. Average Salary

SELECT 
    department_id, ROUND(AVG(salary), 2)
FROM
    employees
GROUP BY department_id;

-- 3. Minimum Salary

SELECT 
    department_id, MIN(salary) 'Min Salary'
FROM
    employees
GROUP BY department_id
HAVING MIN(salary) > 800;

-- 4. Appetizers Count

SELECT 
    COUNT(*)
FROM
    products
WHERE
    category_id = 2 AND price > 8;
    
-- 5. Menu Prices

SELECT 
    category_id,
    ROUND(AVG(price), 2) AS 'Average Price',
    MIN(price) AS 'Cheapest Product',
    MAX(price) AS 'Most Expensive Product'
FROM
    products
GROUP BY category_id;
