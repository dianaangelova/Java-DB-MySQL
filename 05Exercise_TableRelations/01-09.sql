-- 01. One-To-One Relationship

CREATE TABLE passports (
    passport_id INT AUTO_INCREMENT PRIMARY KEY,
    passport_number VARCHAR(50) NOT NULL
);

CREATE TABLE people (
    person_id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(100) NOT NULL,
    salary decimal (10,2) NOT NULL,
    passport_id INT UNIQUE NOT NULL,
    CONSTRAINT fk_passort_people FOREIGN KEY (passport_id)
        REFERENCES passports (passport_id)
);

insert into passports (passport_id, passport_number) VALUES (101, 'N34FG21B'), (102, 'K65LO4R7'), (103, 'ZE657QP2');

insert into people (person_id, first_name, salary, passport_id) values (1, 'Roberto', '43300.00', 102),(2, 'Tom', '56100.00', 103),(3, 'Yana', '60200.00', 101);

-- 02. One-To-Many Relationship

CREATE TABLE manufacturers (
    manufacturer_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    established_on DATE
);

insert into manufacturers (manufacturer_id, name, established_on) VALUES (1, 'BMW', '1916-03-01'), (2, 'Tesla','2003-01-01'), (3, 'Lada', '1966-05-01');


CREATE TABLE models (
    model_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    manufacturer_id INT NOT NULL,
    CONSTRAINT fk_manifacturer_models FOREIGN KEY (manufacturer_id)
        REFERENCES manufacturers (manufacturer_id)
);

insert into models (model_id, name, manufacturer_id)
 VALUES (101, 'X1', 1), 
(102, 'i6', 1),  
(103, 'Model S', 2), 
(104, 'Model X', 2), 
(105, 'Model 3', 2), 
(106, 'Nova', 3);

-- 03. Many-To-Many Relationship


CREATE TABLE students (
    student_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(50) NOT NULL
);

insert into students (student_id, name) VALUES (1, 'Mila'), (2, 'Toni'), (3, 'Ron');


CREATE TABLE exams (
    exam_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(50) NOT NULL
);

insert into exams (exam_id, name) VALUES (101, 'Spring MVC'), (102, 'Neo4j'), (103, 'Oracle 11g');


CREATE TABLE students_exams (
    student_id INT not null,
    exam_id INT not null, 
    PRIMARY KEY (student_id, exam_id),
    FOREIGN KEY (student_id)
    REFERENCES students (student_id),
        FOREIGN KEY (exam_id)
    REFERENCES exams (exam_id)
);

insert into students_exams (student_id, exam_id) 
VALUES (1, 101),
(1, 102),
(2, 101),
(3, 103),
(2, 102),
(2, 103);


-- 04. Self-Referencing


CREATE TABLE teachers (
    teacher_id INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(50) NOT NULL,
    manager_id INT NULL,
    FOREIGN KEY (manager_id)
        REFERENCES teachers (teacher_id)
);


insert into teachers (teacher_id, name)
 VALUES (101, 'John'), 
 (102, 'Maya'),
 (103, 'Silvia'),
 (104, 'Ted'),
 (105, 'Mark'),
 (106, 'Greta');
 
 UPDATE teachers 
SET 
    manager_id = 106
WHERE
    teacher_id = 102 OR teacher_id = 103;
    
    
     UPDATE teachers 
SET 
    manager_id = 105
WHERE
    teacher_id = 104;


 UPDATE teachers 
SET 
    manager_id = 101
WHERE
    teacher_id = 105 OR teacher_id = 106;
    
-- 05. Online Store Database

create database online_store;

use online_store;

CREATE TABLE item_types (
    item_type_id INT(11) NOT NULL AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(50) NOT NULL
);


CREATE TABLE items (
    item_id INT(11) NOT NULL AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    item_type_id INT(11),
    FOREIGN KEY (item_type_id)
        REFERENCES item_types (item_type_id)
);

CREATE TABLE order_items (
    order_id INT(11) NOT NULL,
    item_id INT(11) NOT NULL,
    PRIMARY KEY (order_id, item_id)
);


CREATE TABLE cities (
    city_id INT(11) NOT NULL AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(50) NOT NULL
);

CREATE TABLE customers (
    customer_id INT(11) NOT NULL AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    birthday DATE,
    city_id INT(11),
    FOREIGN KEY (city_id)
        REFERENCES cities (city_id)
);

CREATE TABLE orders (
    order_id INT(11) NOT NULL AUTO_INCREMENT PRIMARY KEY,
    customer_id INT(11) NOT NULL
    
    );



