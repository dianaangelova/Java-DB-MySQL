-- 1. Departments Info

SELECT 
    department_id, COUNT(id)
FROM
    employees
GROUP BY department_id;


-- 2. Average Salary

SELECT 
    department_id, round(AVG(salary), 2)
FROM
    employees
GROUP BY department_id;

-- 3. Minimum Salary

