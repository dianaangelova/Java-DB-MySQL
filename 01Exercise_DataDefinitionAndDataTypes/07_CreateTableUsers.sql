USE minions;

CREATE TABLE users(
id INT AUTO_INCREMENT PRIMARY KEY,
`username` VARCHAR(30) NOT NULL,
`password` VARCHAR(26) NOT NULL,
profile_picture BLOB,
last_login_time TIME,
is_deleted BOOLEAN
);

INSERT INTO users (username, `password`) VALUES ("diana", "diana"), 
("petra", "petra"), 
("sophia", "sophia"), 
("peter", "peter"), 
("koko", "koko");