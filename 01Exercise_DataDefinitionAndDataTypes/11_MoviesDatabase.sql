CREATE DATABASE movies;

CREATE TABLE directors(
id INT AUTO_INCREMENT NOT NULL PRIMARY KEY,
director_name VARCHAR(255) NOT NULL,
notes VARCHAR(255)
);

CREATE TABLE genres(
id INT AUTO_INCREMENT NOT NULL PRIMARY KEY,
genre_name VARCHAR(255) NOT NULL,
notes VARCHAR(255)
);

CREATE TABLE categories(
id INT AUTO_INCREMENT NOT NULL PRIMARY KEY,
category_name VARCHAR(255) NOT NULL,
notes VARCHAR(255)
);

CREATE TABLE movies(
id INT AUTO_INCREMENT NOT NULL PRIMARY KEY,
title VARCHAR(255) NOT NULL,
director_id INT NOT NULL,
copyright_year YEAR,
length INT,
genre_id INT NOT NULL,
category_id INT NOT NULL,
rating VARCHAR(255),
notes VARCHAR(255)
);

INSERT INTO directors (director_name, notes)
VALUES ("Diana", "Notes for director Diana"),
("Chocho", "Notes for director Chocho"),
("Sonya", "Notes for director Sonya"),
("Koko", "Notes for director Koko"),
("Pesho", "Notes for director Pesho");

INSERT INTO genres (genre_name, notes)
VALUES ("Music", "Notes for director music"),
("Triler", "Notes for director triler"),
("Action", "Notes for director action"),
("Drama", "Notes for director drama"),
("Soap opera", "Notes for director soap opera");

INSERT INTO categories (category_name)
VALUES ("Category 1"),
("Category 2"),
("Category 3"),
("Category 4"),
("Category 5");

INSERT INTO movies (title, director_id, genre_id, category_id)
VALUES ("Title 1", 1, 1, 1),
 ("Title 2", 2, 2, 2),
  ("Title 3", 3, 3, 3),
   ("Title 4", 4, 4, 4),
    ("Title 5", 5, 5, 5);