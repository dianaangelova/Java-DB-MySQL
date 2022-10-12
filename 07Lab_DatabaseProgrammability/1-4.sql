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

DELIMITER $$

create procedure usp_raise_salary_by_id(id INT)
begin
declare count_by_id INT;
start transaction;
SET count_by_id:= (select count(*) from employees WHERE employee_id = id);
IF (count_by_id <1) THEN ROLLBACK;
ELSE UPDATE employees SET     salary = salary + salary * 5 / 100  WHERE     employee_id = id;
COMMIT;
END IF;
end$$

DELIMITER ;

-- 4. Triggered

CREATE TABLE deleted_employees (
    employee_id INT PRIMARY KEY AUTO_INCREMENT,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    middle_name VARCHAR(50),
    job_title VARCHAR(50),
    department_id INT,
    salary DECIMAL
);

DELIMITER $$

CREATE TRIGGER tr_deleted_employees
AFTER DELETE
ON employees
FOR EACH ROW
BEGIN
		INSERT INTO deleted_employees(first_name,last_name,middle_name,job_title,department_id,salary)
        VALUES (OLD.first_name,OLD.last_name,OLD.middle_name,OLD.job_title,OLD.department_id,OLD.salary);
END$$
