-- MySQL Script generated by MySQL Workbench
-- mar 09 feb 2016 16:02:19 CET
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema s4t-myarduino
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `s4t-myarduino` ;

-- -----------------------------------------------------
-- Schema s4t-myarduino
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `s4t-myarduino` DEFAULT CHARACTER SET latin1 ;
USE `s4t-myarduino` ;

-- -----------------------------------------------------
-- Table `s4t-myarduino`.`board_codes`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `s4t-myarduino`.`board_codes` ;

CREATE TABLE IF NOT EXISTS `s4t-myarduino`.`board_codes` (
  `code` VARCHAR(25) NOT NULL,
  `creation_date` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`code`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `s4t-myarduino`.`user_groups`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `s4t-myarduino`.`user_groups` ;

CREATE TABLE IF NOT EXISTS `s4t-myarduino`.`user_groups` (
  `id` INT(8) NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(50) NULL DEFAULT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
AUTO_INCREMENT = 2
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `s4t-myarduino`.`users`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `s4t-myarduino`.`users` ;

CREATE TABLE IF NOT EXISTS `s4t-myarduino`.`users` (
  `id` INT(8) NOT NULL AUTO_INCREMENT,
  `username` VARCHAR(50) NULL DEFAULT NULL,
  `password` VARCHAR(25) NULL DEFAULT NULL,
  `group_id` INT(8) NOT NULL,
  `email` VARCHAR(100) NOT NULL,
  `active` TINYINT(1) NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  INDEX `group_id` (`group_id` ASC),
  CONSTRAINT `users_ibfk_1`
    FOREIGN KEY (`group_id`)
    REFERENCES `s4t-myarduino`.`user_groups` (`id`)
    ON DELETE RESTRICT
    ON UPDATE RESTRICT)
ENGINE = InnoDB
AUTO_INCREMENT = 2
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `s4t-myarduino`.`board_imports`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `s4t-myarduino`.`board_imports` ;

CREATE TABLE IF NOT EXISTS `s4t-myarduino`.`board_imports` (
  `id` INT(8) NOT NULL AUTO_INCREMENT,
  `idate` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `user_id` INT(8) NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `user_id` (`user_id` ASC),
  CONSTRAINT `board_imports_ibfk_1`
    FOREIGN KEY (`user_id`)
    REFERENCES `s4t-myarduino`.`users` (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `s4t-myarduino`.`board_types`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `s4t-myarduino`.`board_types` ;

CREATE TABLE IF NOT EXISTS `s4t-myarduino`.`board_types` (
  `id` INT(8) NOT NULL AUTO_INCREMENT,
  `sku` VARCHAR(15) NOT NULL,
  `image` VARCHAR(250) NULL DEFAULT NULL,
  `electric_schema` VARCHAR(250) NULL DEFAULT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
AUTO_INCREMENT = 2
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `s4t-myarduino`.`boards`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `s4t-myarduino`.`boards` ;

CREATE TABLE IF NOT EXISTS `s4t-myarduino`.`boards` (
  `id` INT(8) NOT NULL AUTO_INCREMENT,
  `type_id` INT(8) NOT NULL,
  `name` VARCHAR(200) NULL DEFAULT NULL,
  `description` TEXT NULL DEFAULT NULL,
  `language` VARCHAR(5) NULL DEFAULT NULL,
  `store_url` VARCHAR(200) NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  INDEX `type_id` (`type_id` ASC),
  CONSTRAINT `boards_ibfk_1`
    FOREIGN KEY (`type_id`)
    REFERENCES `s4t-myarduino`.`board_types` (`id`)
    ON DELETE RESTRICT
    ON UPDATE RESTRICT)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `s4t-myarduino`.`boards_connected`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `s4t-myarduino`.`boards_connected` ;

CREATE TABLE IF NOT EXISTS `s4t-myarduino`.`boards_connected` (
  `board_code` VARCHAR(25) NOT NULL,
  `session_id` VARCHAR(250) NULL DEFAULT NULL,
  `status` VARCHAR(15) NULL DEFAULT NULL,
  `altitude` VARCHAR(45) NULL DEFAULT NULL,
  `longitude` VARCHAR(45) NULL DEFAULT NULL,
  `latitude` VARCHAR(45) NULL DEFAULT NULL,
  PRIMARY KEY (`board_code`),
  INDEX `fk_boards_connected_board_codes1_idx` (`board_code` ASC),
  UNIQUE INDEX `board_codes_code_UNIQUE` (`board_code` ASC),
  CONSTRAINT `fk_boards_connected_board_codes1`
    FOREIGN KEY (`board_code`)
    REFERENCES `s4t-myarduino`.`board_codes` (`code`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `s4t-myarduino`.`measures`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `s4t-myarduino`.`measures` ;

CREATE TABLE IF NOT EXISTS `s4t-myarduino`.`measures` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(20) NOT NULL,
  `read_plugin` VARCHAR(20) NOT NULL,
  `elaborate_plugin` VARCHAR(20) NULL DEFAULT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
AUTO_INCREMENT = 9
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `s4t-myarduino`.`measures_injected`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `s4t-myarduino`.`measures_injected` ;

CREATE TABLE IF NOT EXISTS `s4t-myarduino`.`measures_injected` (
  `board_id` INT(11) NOT NULL,
  `measure_id` INT(11) NOT NULL,
  `pin` VARCHAR(20) NOT NULL,
  `period` DOUBLE NULL DEFAULT NULL,
  `state` VARCHAR(20) NULL DEFAULT NULL)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `s4t-myarduino`.`plugins`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `s4t-myarduino`.`plugins` ;

CREATE TABLE IF NOT EXISTS `s4t-myarduino`.`plugins` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(20) NOT NULL,
  `category` VARCHAR(20) NOT NULL,
  `jsonschema` LONGTEXT NOT NULL,
  `code` LONGTEXT NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `name_UNIQUE` (`name` ASC))
ENGINE = InnoDB
AUTO_INCREMENT = 10
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `s4t-myarduino`.`plugins_injected`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `s4t-myarduino`.`plugins_injected` ;

CREATE TABLE IF NOT EXISTS `s4t-myarduino`.`plugins_injected` (
  `board_id` VARCHAR(25) NOT NULL,
  `plugin_id` INT(11) NOT NULL,
  `state` VARCHAR(20) NOT NULL,
  `latest_change` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  INDEX `fk_plugins_injected_plugins1_idx` (`plugin_id` ASC),
  PRIMARY KEY (`board_id`, `plugin_id`),
  INDEX `fk_plugins_injected_board_codes1_idx` (`board_id` ASC),
  CONSTRAINT `fk_plugins_injected_plugins1`
    FOREIGN KEY (`plugin_id`)
    REFERENCES `s4t-myarduino`.`plugins` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_plugins_injected_board_codes1`
    FOREIGN KEY (`board_id`)
    REFERENCES `s4t-myarduino`.`board_codes` (`code`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `s4t-myarduino`.`reverse_cloud_services`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `s4t-myarduino`.`reverse_cloud_services` ;

CREATE TABLE IF NOT EXISTS `s4t-myarduino`.`reverse_cloud_services` (
  `board_id` INT(8) NOT NULL,
  `service` VARCHAR(50) NOT NULL,
  `public_ip` VARCHAR(16) NOT NULL,
  `public_port` VARCHAR(5) NOT NULL,
  PRIMARY KEY (`board_id`, `service`))
ENGINE = MEMORY
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `s4t-myarduino`.`user_boards`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `s4t-myarduino`.`user_boards` ;

CREATE TABLE IF NOT EXISTS `s4t-myarduino`.`user_boards` (
  `id` INT(8) NOT NULL AUTO_INCREMENT,
  `user_id` INT(8) NOT NULL,
  `board_type` INT(8) NOT NULL,
  `board_code` VARCHAR(25) NOT NULL,
  `cloud_enabled` TINYINT(1) NULL DEFAULT 0,
  `net_enabled` TINYINT(1) NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  INDEX `user_id` (`user_id` ASC),
  INDEX `board_type` (`board_type` ASC),
  INDEX `board_code` (`board_code` ASC),
  CONSTRAINT `user_boards_ibfk_1`
    FOREIGN KEY (`user_id`)
    REFERENCES `s4t-myarduino`.`users` (`id`),
  CONSTRAINT `user_boards_ibfk_2`
    FOREIGN KEY (`board_type`)
    REFERENCES `s4t-myarduino`.`board_types` (`id`)
    ON DELETE RESTRICT
    ON UPDATE RESTRICT,
  CONSTRAINT `user_boards_ibfk_3`
    FOREIGN KEY (`board_code`)
    REFERENCES `s4t-myarduino`.`board_codes` (`code`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
AUTO_INCREMENT = 18
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `s4t-myarduino`.`user_profiles`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `s4t-myarduino`.`user_profiles` ;

CREATE TABLE IF NOT EXISTS `s4t-myarduino`.`user_profiles` (
  `id` INT(8) NOT NULL AUTO_INCREMENT,
  `user_id` INT(8) NOT NULL,
  `name` VARCHAR(50) NULL DEFAULT NULL,
  `surname` VARCHAR(50) NULL DEFAULT NULL,
  `avatar` VARCHAR(200) NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  INDEX `user_id` (`user_id` ASC),
  CONSTRAINT `user_profiles_ibfk_1`
    FOREIGN KEY (`user_id`)
    REFERENCES `s4t-myarduino`.`users` (`id`)
    ON DELETE RESTRICT
    ON UPDATE RESTRICT)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `s4t-myarduino`.`userprojects`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `s4t-myarduino`.`userprojects` ;

CREATE TABLE IF NOT EXISTS `s4t-myarduino`.`userprojects` (
  `id` INT(8) NOT NULL AUTO_INCREMENT,
  `user_id` INT(8) NOT NULL,
  `title` VARCHAR(100) NOT NULL,
  `description` TEXT NULL DEFAULT NULL,
  `creation_date` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `status` VARCHAR(15) NULL DEFAULT 'private',
  PRIMARY KEY (`id`),
  INDEX `user_id` (`user_id` ASC),
  CONSTRAINT `userprojects_ibfk_1`
    FOREIGN KEY (`user_id`)
    REFERENCES `s4t-myarduino`.`users` (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `s4t-myarduino`.`userproject_comments`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `s4t-myarduino`.`userproject_comments` ;

CREATE TABLE IF NOT EXISTS `s4t-myarduino`.`userproject_comments` (
  `id` INT(8) NOT NULL AUTO_INCREMENT,
  `project_id` INT(8) NOT NULL,
  `user_id` INT(8) NOT NULL,
  `content` TEXT NOT NULL,
  `creation_date` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `status` VARCHAR(15) NULL DEFAULT 'public',
  PRIMARY KEY (`id`),
  INDEX `project_id` (`project_id` ASC),
  INDEX `user_id` (`user_id` ASC),
  CONSTRAINT `userproject_comments_ibfk_1`
    FOREIGN KEY (`project_id`)
    REFERENCES `s4t-myarduino`.`userprojects` (`id`),
  CONSTRAINT `userproject_comments_ibfk_2`
    FOREIGN KEY (`user_id`)
    REFERENCES `s4t-myarduino`.`users` (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `s4t-myarduino`.`userproject_likes`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `s4t-myarduino`.`userproject_likes` ;

CREATE TABLE IF NOT EXISTS `s4t-myarduino`.`userproject_likes` (
  `project_id` INT(8) NOT NULL,
  `user_id` INT(8) NOT NULL,
  INDEX `project_id` (`project_id` ASC),
  INDEX `user_id` (`user_id` ASC),
  CONSTRAINT `userproject_likes_ibfk_1`
    FOREIGN KEY (`project_id`)
    REFERENCES `s4t-myarduino`.`userprojects` (`id`),
  CONSTRAINT `userproject_likes_ibfk_2`
    FOREIGN KEY (`user_id`)
    REFERENCES `s4t-myarduino`.`users` (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `s4t-myarduino`.`vlans`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `s4t-myarduino`.`vlans` ;

CREATE TABLE IF NOT EXISTS `s4t-myarduino`.`vlans` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `vlan_name` VARCHAR(45) NOT NULL,
  `vlan_ip` VARCHAR(45) NOT NULL,
  `vlan_mask` VARCHAR(45) NOT NULL,
  `net_uuid` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `s4t-myarduino`.`socat_connections`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `s4t-myarduino`.`socat_connections` ;

CREATE TABLE IF NOT EXISTS `s4t-myarduino`.`socat_connections` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `id_board` VARCHAR(25) NOT NULL,
  `port` INT(6) NOT NULL,
  `ip_board` VARCHAR(45) NOT NULL,
  `ip_server` VARCHAR(45) NOT NULL,
  `status` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`, `id_board`),
  INDEX `fk_socat_connections_board_codes1_idx` (`id_board` ASC),
  UNIQUE INDEX `id_board_UNIQUE` (`id_board` ASC),
  CONSTRAINT `fk_socat_connections_board_codes1`
    FOREIGN KEY (`id_board`)
    REFERENCES `s4t-myarduino`.`board_codes` (`code`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `s4t-myarduino`.`vlans_connection`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `s4t-myarduino`.`vlans_connection` ;

CREATE TABLE IF NOT EXISTS `s4t-myarduino`.`vlans_connection` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `id_vlan` INT NOT NULL,
  `id_socat_connection` INT NOT NULL,
  `ip_vlan` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_vlans_connection_vlans1_idx` (`id_vlan` ASC),
  INDEX `fk_vlans_connection_socat_connections1_idx` (`id_socat_connection` ASC),
  CONSTRAINT `fk_vlans_connection_vlans1`
    FOREIGN KEY (`id_vlan`)
    REFERENCES `s4t-myarduino`.`vlans` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_vlans_connection_socat_connections1`
    FOREIGN KEY (`id_socat_connection`)
    REFERENCES `s4t-myarduino`.`socat_connections` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `s4t-myarduino`.`sensors`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `s4t-myarduino`.`sensors` ;

CREATE TABLE IF NOT EXISTS `s4t-myarduino`.`sensors` (
  `id` INT NOT NULL,
  `type` VARCHAR(45) NOT NULL,
  `unit` VARCHAR(45) NOT NULL,
  `fabric_name` VARCHAR(45) NULL,
  `model` VARCHAR(45) NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `s4t-myarduino`.`sensors_on_board`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `s4t-myarduino`.`sensors_on_board` ;

CREATE TABLE IF NOT EXISTS `s4t-myarduino`.`sensors_on_board` (
  `id_sensor` INT NOT NULL,
  `id_board` VARCHAR(25) NOT NULL,
  INDEX `fk_sensors_on_board_board_codes1_idx` (`id_board` ASC),
  PRIMARY KEY (`id_sensor`, `id_board`),
  CONSTRAINT `fk_sensors_on_board_sensors1`
    FOREIGN KEY (`id_sensor`)
    REFERENCES `s4t-myarduino`.`sensors` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_sensors_on_board_board_codes1`
    FOREIGN KEY (`id_board`)
    REFERENCES `s4t-myarduino`.`board_codes` (`code`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `s4t-myarduino`.`plugin_sensors`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `s4t-myarduino`.`plugin_sensors` ;

CREATE TABLE IF NOT EXISTS `s4t-myarduino`.`plugin_sensors` (
  `plugins_id` INT(11) NOT NULL,
  `sensors_id` INT NOT NULL,
  INDEX `fk_plugin_sensors_plugins1_idx` (`plugins_id` ASC),
  INDEX `fk_plugin_sensors_sensors1_idx` (`sensors_id` ASC),
  PRIMARY KEY (`plugins_id`, `sensors_id`),
  CONSTRAINT `fk_plugin_sensors_plugins1`
    FOREIGN KEY (`plugins_id`)
    REFERENCES `s4t-myarduino`.`plugins` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_plugin_sensors_sensors1`
    FOREIGN KEY (`sensors_id`)
    REFERENCES `s4t-myarduino`.`sensors` (`id`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `s4t-myarduino`.`free_addresses`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `s4t-myarduino`.`free_addresses` ;

CREATE TABLE IF NOT EXISTS `s4t-myarduino`.`free_addresses` (
  `vlans_id` INT NOT NULL,
  `ip` VARCHAR(45) NOT NULL,
  `insert_date` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  INDEX `fk_free_addresses_vlans1_idx` (`vlans_id` ASC),
  PRIMARY KEY (`vlans_id`, `ip`),
  CONSTRAINT `fk_free_addresses_vlans1`
    FOREIGN KEY (`vlans_id`)
    REFERENCES `s4t-myarduino`.`vlans` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

-- -----------------------------------------------------
-- Data for table `s4t-myarduino`.`user_groups`
-- -----------------------------------------------------
START TRANSACTION;
USE `s4t-myarduino`;
INSERT INTO `s4t-myarduino`.`user_groups` (`id`, `name`) VALUES (1, 'admin');

COMMIT;


-- -----------------------------------------------------
-- Data for table `s4t-myarduino`.`users`
-- -----------------------------------------------------
START TRANSACTION;
USE `s4t-myarduino`;
INSERT INTO `s4t-myarduino`.`users` (`id`, `username`, `password`, `group_id`, `email`, `active`) VALUES (1, 'admin', 'admin', 1, 'smartme@unime.it ', 0);

COMMIT;


-- -----------------------------------------------------
-- Data for table `s4t-myarduino`.`board_types`
-- -----------------------------------------------------
START TRANSACTION;
USE `s4t-myarduino`;
INSERT INTO `s4t-myarduino`.`board_types` (`id`, `sku`, `image`, `electric_schema`) VALUES (1, '0000000', 'NULL', 'NULL');

COMMIT;


-- -----------------------------------------------------
-- Data for table `s4t-myarduino`.`sensors`
-- -----------------------------------------------------
START TRANSACTION;
USE `s4t-myarduino`;
INSERT INTO `s4t-myarduino`.`sensors` (`id`, `type`, `unit`, `fabric_name`, `model`) VALUES (1, 'temperature', '°C', 'Thermistor', 'TinkerKit');
INSERT INTO `s4t-myarduino`.`sensors` (`id`, `type`, `unit`, `fabric_name`, `model`) VALUES (2, 'brightness', 'lux', 'LDR', 'TinkerKit');
INSERT INTO `s4t-myarduino`.`sensors` (`id`, `type`, `unit`, `fabric_name`, `model`) VALUES (3, 'humidity', '%', 'HIH-4030', 'Honeywell');
INSERT INTO `s4t-myarduino`.`sensors` (`id`, `type`, `unit`, `fabric_name`, `model`) VALUES (4, 'sound_detect', 'db', 'HY-038', 'Keyes');
INSERT INTO `s4t-myarduino`.`sensors` (`id`, `type`, `unit`, `fabric_name`, `model`) VALUES (5, 'gas', 'ppm', 'MQ9', 'Grove');
INSERT INTO `s4t-myarduino`.`sensors` (`id`, `type`, `unit`, `fabric_name`, `model`) VALUES (6, 'barometer', 'hPa', 'mpl3115', 'TinkerKit');

COMMIT;

