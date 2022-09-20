USE minions;

CREATE TABLE people(
    id INT AUTO_INCREMENT PRIMARY KEY,
    `name` VARCHAR(200) NOT NULL,
    `picture` BLOB,
    height DECIMAL(10,2),
    weight DECIMAL (10,2),
    gender CHAR(1) NOT NULL,
   birthdate DATE NOT NULL,
   	biography TEXT
);

INSERT INTO people ( `name`,gender, birthdate ) 
VALUES ( "Diana Angelova", "f", "1982-08-06"),
( "Marya Angelova", "f", "2000-03-03"),
( "Stoyan Angelova", "m", "1982-08-06"),
( "Petra Angelova", "f", "1992-08-06"),
( "Sonya Angelova", "f", "2006-08-06");