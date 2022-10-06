-- 1. Managers

SELECT 
    departments.manager_id, 
    CONCAT_WS(' ', first_name, last_name) full_name,
    departments.department_id, 
    name as department_name
FROM
    employees,
    departments
WHERE
    departments.manager_id = employees.employee_id
ORDER BY employees.employee_id
LIMIT 5;

-- 2. Towns and Addresses

SELECT 
    towns.town_id, name, address_text
FROM
    towns,
    addresses
WHERE
    towns.town_id = addresses.town_id
        AND (name = 'San Francisco'
        OR name = 'Sofia'
        OR name = 'Carnation')
ORDER BY towns.town_id , addresses.address_id;

-- 3. Employees Without Managers

SELECT 
    employee_id, first_name, last_name, department_id, salary
FROM
    employees
WHERE
    manager_id IS NULL;
    
-- 4. High Salary

SELECT 
    COUNT(employee_id)
FROM
    employees empl,
    (SELECT 
        AVG(salary) average_salary
    FROM
        employees) avg_salary
WHERE
    empl.salary > average_salary;