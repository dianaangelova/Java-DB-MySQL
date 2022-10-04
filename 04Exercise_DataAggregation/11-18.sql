-- 11. Average Interest

SELECT 
    deposit_group, is_deposit_expired, AVG(deposit_interest)
FROM
    wizzard_deposits
WHERE
    deposit_start_date > '1985-01-01'
GROUP BY deposit_group , is_deposit_expired
ORDER BY deposit_group DESC , is_deposit_expired;

-- 12. Employees Minimum Salaries

use soft_uni;

SELECT 
    department_id, MIN(salary)
FROM
    employees
WHERE
    department_id IN (2 , 5, 7)
        AND hire_date > '2000-01-01'
GROUP BY department_id;

-- 13. Employees Average Salaries

CREATE TABLE employees_high_salary AS (SELECT * FROM
    employees
WHERE
    salary > 30000);
    
DELETE FROM employees_high_salary 
WHERE
    manager_id = 42;
    
UPDATE employees_high_salary 
SET 
    salary = salary + 5000
WHERE
    department_id = 1;
    
SELECT 
    department_id, AVG(salary)
FROM
    employees_high_salary
GROUP BY department_id
ORDER BY department_id;

-- 14. Employees Maximum Salaries

SELECT 
    department_id, MAX(salary) max_salary
FROM
    employees   
GROUP BY department_id
HAVING  max_salary NOT BETWEEN 30000 AND 70000
ORDER BY department_id;

-- 15. Employees Count Salaries

SELECT 
    COUNT(salary)
FROM
    employees
WHERE
    manager_id IS NULL;
    

-- 16. 3rd Highest Salary

SELECT 
    *
FROM
    (SELECT 
        department_id,
            (SELECT DISTINCT
                    salary
                FROM
                    employees t2
                WHERE
                    t2.department_id = t1.department_id
                ORDER BY salary DESC
                LIMIT 2 , 1) 'third_highest_salary'
    FROM
        employees t1
    GROUP BY department_id
    ORDER BY department_id) t3
WHERE
    t3.third_highest_salary IS NOT NULL;

-- 17. Salary Challenge


SELECT 
    first_name, last_name, department_id
FROM
    employees,
    (SELECT 
        department_id avg_department, AVG(salary) avg_salary
    FROM
        employees
    GROUP BY department_id) avg_salary
WHERE
    department_id = avg_department
        AND salary > avg_salary
ORDER BY department_id , employee_id
LIMIT 10;


-- 18. Departments Total Salaries

SELECT 
    department_id, SUM(salary)
FROM
    employees
GROUP BY department_id
ORDER BY department_id;

