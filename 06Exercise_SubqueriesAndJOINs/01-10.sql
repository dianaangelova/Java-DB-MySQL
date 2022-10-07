-- 01. Employee Address

use soft_uni;

SELECT 
    employee_id, job_title, employees.address_id, address_text
FROM
    employees,
    addresses
WHERE
    employees.address_id = addresses.address_id
ORDER BY employees.address_id
LIMIT 5;

-- 02. Addresses with Towns

SELECT 
    first_name, last_name, name AS town_name, address_text
FROM
    employees,
    towns,
    addresses
WHERE
    employees.address_id = addresses.address_id
        AND towns.town_id = addresses.town_id
ORDER BY first_name , last_name
LIMIT 5;

-- 03. Sales Employee

SELECT 
    employee_id, first_name, last_name, name AS department_name
FROM
    employees,
    departments
WHERE
    employees.department_id = departments.department_id
        AND departments.name = 'Sales'
ORDER BY employees.employee_id DESC
;

-- 04. Employee Departments

SELECT 
    employee_id, first_name, salary, name AS department_name
FROM
    employees,
    departments
WHERE
    employees.department_id = departments.department_id
        AND employees.salary > 15000
ORDER BY departments.department_id DESC
LIMIT 5;

 --  05. Employees Without Project
 
 SELECT 
    employee_id, first_name
FROM
    employees
WHERE
    employees.employee_id NOT IN (SELECT DISTINCT
            employee_id
        FROM
            employees_projects)
ORDER BY employees.employee_id DESC
LIMIT 3;

-- 06. Employees Hired After

SELECT 
    first_name, last_name, hire_date, name AS dept_name
FROM
    employees,
    departments
WHERE
    employees.department_id = departments.department_id
        AND employees.hire_date > '1999-01-01'
        AND departments.name IN ('Sales' , 'Finance')
ORDER BY hire_date;

-- 07. Employees with Project

SELECT 
    employee_project_id.employee_id,
    employee_project_id.first_name,
    projects.name AS project_name
FROM
    projects,
    (SELECT 
        employees.employee_id,
            employees.first_name,
            employees_projects.project_id
    FROM
        employees, employees_projects
    WHERE
        employees.employee_id = employees_projects.employee_id) employee_project_id
WHERE
    employee_project_id.project_id = projects.project_id
        AND DATE(projects.start_date) > '2002-08-13'
        AND projects.end_date IS NULL
ORDER BY employee_project_id.first_name , projects.name
LIMIT 5;

-- 08. Employee 24

SELECT 
    e.employee_id,
    e.first_name,
    CASE
        WHEN YEAR(p.start_date) >= '2005' THEN p.name = NULL
        ELSE p.name
    END AS project_name
FROM
    employees AS e
        JOIN
    employees_projects AS ep USING (employee_id)
        JOIN
    projects AS p USING (project_id)
WHERE
    e.employee_id = 24
ORDER BY e.first_name , p.name
;

-- 09. Employee Manager

SELECT 
    e.employee_id, e.first_name, e.manager_id, m.first_name
FROM
    employees e,
    (SELECT 
        first_name, employee_id
    FROM
        employees) m
WHERE
    e.manager_id = m.employee_id
        AND e.manager_id IN (7 , 3)
ORDER BY e.first_name;
    
    
-- 10. Employee Summary

SELECT 
    e.employee_id,
    CONCAT(e.first_name, ' ', e.last_name) AS employee_name,
    manager_name,
    d.name AS department_name
FROM
    employees e,
    (SELECT 
        CONCAT(first_name, ' ', last_name) AS manager_name,
            employee_id
    FROM
        employees) m,
    departments d
WHERE
    e.manager_id = m.employee_id
        AND d.department_id = e.department_id
        AND e.manager_id IS NOT NULL
ORDER BY e.employee_id
LIMIT 5;
