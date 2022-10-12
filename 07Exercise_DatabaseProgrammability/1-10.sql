-- 01. Employees with Salary Above 35000

DELIMITER $$

create procedure usp_get_employees_salary_above_35000()
begin
select first_name, last_name from employees where salary > 35000
order by first_name, last_name, employee_id;
end $$

DELIMITER ;

-- 02. Employees with Salary Above Number

DELIMITER $$

create procedure usp_get_employees_salary_above(salary_to_compare DECIMAL(10,4))
begin
select first_name, last_name from employees where salary >= salary_to_compare
order by first_name, last_name, employee_id;
end $$

DELIMITER ;

call usp_get_employees_salary_above(48100);

-- 03. Town Names Starting With

DELIMITER $$
create procedure usp_get_towns_starting_with(string_to_compare VARCHAR(50))
begin
select name from towns where name like concat(string_to_compare, '%')
order by name;
end $$

DELIMITER ;

call usp_get_towns_starting_with('b');

-- 04. Employees from Town

DELIMITER $$
create procedure usp_get_employees_from_town(town_name VARCHAR(50))
begin
select first_name,last_name from employees join addresses on employees.address_id = addresses.address_id
join towns on addresses.town_id = towns.town_id
where towns.name = town_name
order by first_name,last_name, employee_id;
end $$

DELIMITER ;

-- 05. Salary Level Function

DELIMITER $$
CREATE FUNCTION ufn_get_salary_level (salary DECIMAL(19,4))
RETURNS VARCHAR(20)
DETERMINISTIC
BEGIN
   DECLARE salary_level VARCHAR(20);
	IF salary<30000 then set salary_level := 'Low';
	ELSEIF salary<=50000 then set salary_level := 'Average';
	ELSE set salary_level := 'High';
	END IF;
   RETURN salary_level;
END$$

-- 06. Employees by Salary Level

DELIMITER $$
create procedure usp_get_employees_by_salary_level(salary_level VARCHAR(20))
begin
select first_name,last_name from employees where ufn_get_salary_level(salary)=salary_level
order by first_name desc,last_name desc;
end $$

-- 07. Define Function

DELIMITER $$
CREATE FUNCTION ufn_is_word_comprised(set_of_letters varchar(50), word varchar(50))
RETURNS BINARY
DETERMINISTIC
BEGIN
   DECLARE salary_level VARCHAR(20);
	IF salary<30000 then set salary_level := 'Low';
	ELSEIF salary<=50000 then set salary_level := 'Average';
	ELSE set salary_level := 'High';
	END IF;
   RETURN salary_level;
END$$