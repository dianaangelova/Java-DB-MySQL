USE minions;

CREATE TABLE minions (
    id INT AUTO_INCREMENT PRIMARY KEY,
    `name` VARCHAR(100),
    age INT
);

CREATE TABLE towns (
    town_id INT AUTO_INCREMENT PRIMARY KEY,
    `name` VARCHAR(100)
);