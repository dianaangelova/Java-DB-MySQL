CREATE DATABASE car_rental;

USE car_rental;

CREATE TABLE categories (
    id INT AUTO_INCREMENT NOT NULL PRIMARY KEY,
    category VARCHAR(255) NOT NULL,
    daily_rate DOUBLE,
    weekly_rate DOUBLE,
    monthly_rate DOUBLE,
    weekend_rate DOUBLE
);

INSERT INTO  categories (category) VALUES ("Cat1"), ("Cat2"),("Cat3");

CREATE TABLE cars (
    id INT AUTO_INCREMENT NOT NULL PRIMARY KEY,
    plate_number VARCHAR(255) NOT NULL,
    make VARCHAR (255),
    model VARCHAR (255),
    car_year YEAR,
    category_id INT NOT NULL, 
    doors INT, 
    picture BLOB, 
    car_condition VARCHAR(255), 
    available VARCHAR(255)
);

INSERT INTO  cars (plate_number, category_id) VALUES ("Plate1",3), ("PLate2",2),("Plate3",1);

CREATE TABLE employees (
    id INT AUTO_INCREMENT NOT NULL PRIMARY KEY,
    first_name VARCHAR(255) NOT NULL,
    last_name VARCHAR (255) NOT NULL,
    title VARCHAR (255),
    notes VARCHAR(255)
);

INSERT INTO  employees (first_name, last_name) VALUES ("Diana","Angelova"), ("Chocho","Chochov"),("Pesho","Ivanov");

CREATE TABLE customers (
    id INT AUTO_INCREMENT NOT NULL PRIMARY KEY,
    driver_licence_number VARCHAR(255) NOT NULL,
    full_name VARCHAR (255) NOT NULL,
    address VARCHAR (255),
    city VARCHAR(255),
    zip_code VARCHAR(255),
    notes VARCHAR(255)
);

INSERT INTO  customers (driver_licence_number, full_name) VALUES ("Licence1","Diana Angelova"), ("Licence2","Sonya Angelova"), ("Licence3","Petra Angelova");

CREATE TABLE rental_orders (
    id INT AUTO_INCREMENT NOT NULL PRIMARY KEY,
    employee_id INT NOT NULL,
    customer_id INT NOT NULL,
    car_id INT NOT NULL,
    car_condition VARCHAR (255),
	 tank_level INT, 
     kilometrage_start INT, 
     kilometrage_end INT, 
     total_kilometrage INT, 
     start_date DATE, 
     end_date DATE, 
     total_days INT, 
     rate_applied DOUBLE, 
     tax_rate DOUBLE, 
     order_status VARCHAR(255), 
     notes VARCHAR(255)
);

INSERT INTO  rental_orders (employee_id, customer_id, car_id) VALUES (1,1,1), (3,2,2), (2,3,3);
