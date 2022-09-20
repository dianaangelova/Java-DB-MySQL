USE `minions`;

ALTER TABLE `minions`
ADD COLUMN `town_id` INT;

ALTER TABLE `minions`
ADD CONSTRAINT `fk__town_id`
FOREIGN KEY (`town_id`) REFERENCES `towns` (`id`);