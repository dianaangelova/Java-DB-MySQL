-- 1. Count Employees by Town

DELIMITER $$

CREATE FUNCTION ufn_count_employees_by_town(town_name VARCHAR(20))
RETURNS INT
DETERMINISTIC
BEGIN
   DECLARE count_towns INT;
   SET count_towns := (SELECT 
    COUNT(employees.employee_id)
	FROM
    employees
        JOIN
    addresses ON employees.address_id = addresses.address_id
        JOIN
    towns ON addresses.town_id = towns.town_id
	WHERE
    towns.name = town_name
    );
   RETURN count_towns;
END $$

DELIMITER ;

-- 2. Employees Promotion

DELIMITER $$

create procedure usp_raise_salaries(department_name VARCHAR(50))
begin
update employees set salary = salary+salary*5/100
where employees.department_id in (select department_id from departments where name = department_name);
end $$

DELIMITER ;

call usp_raise_salaries(NULL);

-- 3. Employees Promotion By ID

