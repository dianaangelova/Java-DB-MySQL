create database fsd;
use fsd;

 -- 01 Create tables
 
create table skills_data(
id INT(11) AUTO_INCREMENT PRIMARY KEY,
dribbling INT(11) DEFAULT 0,
pace INT(11) DEFAULT 0,
passing INT(11) DEFAULT 0,
shooting INT(11) DEFAULT 0,
speed INT(11) DEFAULT 0,
strength INT(11) DEFAULT 0
);


create table countries(
id INT(11) AUTO_INCREMENT PRIMARY KEY,
name VARCHAR(45) NOT NULL
);

create table towns(
id INT(11) AUTO_INCREMENT PRIMARY KEY,
name VARCHAR(45) NOT NULL,
country_id INT(11) NOT NULL,
	CONSTRAINT fk_countries_towns FOREIGN KEY (country_id)
        REFERENCES countries (id)
);

create table stadiums(
id INT(11) AUTO_INCREMENT PRIMARY KEY,
name VARCHAR(45) NOT NULL,
capacity INT(11) NOT NULL,
town_id INT(11) NOT NULL,
	CONSTRAINT fk_stadiums_towns FOREIGN KEY (town_id)
        REFERENCES towns (id)
);

create table teams(
id INT(11) AUTO_INCREMENT PRIMARY KEY,
name VARCHAR(45) NOT NULL,
established DATE NOT NULL,
fan_base BIGINT(20) NOT NULL DEFAULT 0,
stadium_id INT(11) NOT NULL,
	CONSTRAINT fk_teams_stadiums FOREIGN KEY (stadium_id)
        REFERENCES stadiums (id)
);

create table players(
id INT(11) AUTO_INCREMENT PRIMARY KEY,
first_name VARCHAR(10) NOT NULL,
last_name VARCHAR(20) NOT NULL,
age INT(11) NOT NULL DEFAULT 0,
position CHAR(1) NOT NULL,
salary DECIMAL(10,2) NOT NULL DEFAULT 0,
hire_date DATETIME,
skills_data_id INT(11) NOT NULL,
team_id INT(11),
    CONSTRAINT fk_skills_players FOREIGN KEY (skills_data_id)
        REFERENCES skills_data (id),
	CONSTRAINT fk_teams_players FOREIGN KEY (team_id)
        REFERENCES teams (id)
);

create table coaches(
id INT(11) AUTO_INCREMENT PRIMARY KEY,
first_name VARCHAR(10) NOT NULL,
last_name VARCHAR(20) NOT NULL,
salary DECIMAL(10,2) NOT NULL DEFAULT 0,
coach_level INT(11) NOT NULL DEFAULT 0
);

create table players_coaches(
player_id INT(11) NOT NULL,
coach_id INT(11) NOT NULL,
PRIMARY KEY(player_id, coach_id),
    CONSTRAINT fk_players FOREIGN KEY (player_id)
        REFERENCES players (id),
    CONSTRAINT fk_coaches FOREIGN KEY (coach_id)
        REFERENCES coaches (id)
);

 -- 02 Insert 
 
 insert into coaches (first_name, last_name, salary, coach_level) (select first_name, last_name, salary*2, LENGTH(first_name) from players where players.age>=45);
 
 -- 03. Update
 
 update coaches join (
 select distinct coaches.id as id from coaches join players_coaches
 on coaches.id = players_coaches.coach_id and coaches.first_name like 'a%') coach_ids 
 on coaches.id= coach_ids.id
 set coaches.coach_level = coaches.coach_level+1;
 
-- 04. Delete

DELETE FROM players 
WHERE
    players.id IN (SELECT 
        a.*
    FROM
        (SELECT 
            players.id
        FROM
            players
        JOIN coaches ON players.first_name = coaches.first_name
            AND players.last_name = coaches.last_name) a
            
               );
               
-- in Judge

DELETE FROM players 
WHERE
    age >= 45;
    
--   05. Players

select first_name, age, salary from players order by salary desc;

-- 06. Young offense players without contract

SELECT 
    players.id,
    CONCAT(first_name, ' ', last_name) AS full_name,
    age,
    position,
    hire_date
FROM
    players join skills_data on players.skills_data_id=skills_data.id
WHERE
    age < 23 AND position = 'A'
        AND hire_date IS NULL and skills_data.strength>50
ORDER BY salary , age;


-- 07. Detail info for all teams

select teams.name as team_name,
established,
fan_base,
(select count(players.id)  from players where players.team_id = teams.id) players_count
from teams 
order by players_count desc, fan_base desc;

-- 08. The fastest player by towns

select Max(skills_data.speed) max_speed, towns.name town_name
from towns left join stadiums on stadiums.town_id = towns.id
left join teams on stadiums.id = teams.stadium_id
left join players on players.team_id=teams.id
left join skills_data on players.skills_data_id = skills_data.id
where teams.name != 'Devify'
group by town_name
order by max_speed desc, towns.name;

-- 09. Total salaries and players by country

select countries.name,
count(players.id) total_count_of_players,
sum(players.salary) total_sum_of_salaries
from countries left join towns on countries.id = towns.country_id
left join stadiums on stadiums.town_id = towns.id
left join teams on stadiums.id = teams.stadium_id
left join players on players.team_id=teams.id
group by countries.name
order by total_count_of_players desc, countries.name ;

-- 10. Find all players that play on stadium

DELIMITER $$
CREATE FUNCTION udf_stadium_players_count (stadium_name VARCHAR(30))
RETURNS INT
DETERMINISTIC
BEGIN
   DECLARE count_players INT;
set count_players:= (select count(players.id)
from towns left join stadiums on stadiums.town_id = towns.id
left join teams on stadiums.id = teams.stadium_id
left join players on players.team_id=teams.id
where stadiums.name = stadium_name);
   RETURN count_players;
END$$

-- 11. Find good playmaker by teams

DELIMITER $$

create procedure udp_find_playmaker(min_dribble_points INT, team_name VARCHAR(45))
begin

select concat(players.first_name, ' ', players.last_name) as full_name, players.age, players.salary, skills_data.dribbling, skills_data.speed, teams.name as team_name
from towns left join stadiums on stadiums.town_id = towns.id
left join teams on stadiums.id = teams.stadium_id
left join players on players.team_id=teams.id
left join skills_data on players.skills_data_id = skills_data.id
where teams.name = team_name and skills_data.dribbling> min_dribble_points
order by skills_data.speed desc
limit 1;

end $$

DELIMITER ;