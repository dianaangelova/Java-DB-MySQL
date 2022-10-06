-- 1. Mountains and Peaks
use camp;

CREATE TABLE mountains (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL
);

CREATE TABLE peaks (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    mountain_id INT NOT NULL
);

ALTER TABLE peaks
ADD FOREIGN KEY (mountain_id) REFERENCES mountains(id);

-- 2. Trip Organization

SELECT 
    driver_id,
    vehicle_type,
    CONCAT(first_name, ' ', last_name) AS driver_name
FROM
    vehicles,
    campers
WHERE
    vehicles.driver_id = campers.id;
    
-- 3. SoftUni Hiking

SELECT 
    starting_point,
    end_point,
    leader_id,
    CONCAT(first_name, ' ', last_name) AS leader_name
FROM
    campers,
    routes
WHERE
    routes.leader_id = campers.id;


-- 4. Delete Mountains

CREATE TABLE mountains (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL
);

CREATE TABLE peaks (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    mountain_id INT NOT NULL,
    CONSTRAINT fk_mountain_peaks FOREIGN KEY (mountain_id)
        REFERENCES mountains (id)
        ON DELETE CASCADE
);