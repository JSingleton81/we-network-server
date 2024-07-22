CREATE DATABASE we_network;

USE we_network;

CREATE TABLE `we_network`.`users` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `user_name` VARCHAR(45) NOT NULL,
  `email` VARCHAR(100) NOT NULL,
  `password` VARCHAR(100) NOT NULL,
  `first_name` VARCHAR(45) NOT NULL,
  `last_name` VARCHAR(45) NOT NULL,
  `city` VARCHAR(45) NULL,
  `street` VARCHAR(100) NULL,
  `zip` VARCHAR(10) NULL,
  `state` VARCHAR(2) NULL,
  `business` TINYINT(1) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `user_name_UNIQUE` (`user_name` ASC) VISIBLE,
  UNIQUE INDEX `email_UNIQUE` (`email` ASC) VISIBLE);
  
  CREATE TABLE `we_network`.`business` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `user_id` INT NOT NULL,
  `business_name` VARCHAR(45) NOT NULL,
  `business_email` VARCHAR(45) NULL,
  `business_website` VARCHAR(100) NULL,
  `business_phone_number` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `user_id_fk_idx` (`user_id` ASC) VISIBLE,
  CONSTRAINT `user_id_fk`
    FOREIGN KEY (`user_id`)
    REFERENCES `we_network`.`users` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE);
    
    CREATE TABLE `we_network`.`business_address` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `business_id` INT NOT NULL,
  `city` VARCHAR(45) NOT NULL,
  `state` VARCHAR(2) NOT NULL,
  `street` VARCHAR(100) NULL,
  `zip` VARCHAR(45) NULL,
  PRIMARY KEY (`id`),
  INDEX `business_id_fk_idx` (`business_id` ASC) VISIBLE,
  CONSTRAINT `business_id_fk`
    FOREIGN KEY (`business_id`)
    REFERENCES `we_network`.`business` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);
    
    ALTER TABLE `we_network`.`business_address` 
DROP FOREIGN KEY `business_id_fk`;
ALTER TABLE `we_network`.`business_address` 
ADD CONSTRAINT `business_id_fk`
  FOREIGN KEY (`business_id`)
  REFERENCES `we_network`.`business` (`id`)
  ON DELETE CASCADE
  ON UPDATE CASCADE;

    
    CREATE TABLE `we_network`.`business_specials` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `business_id` INT NOT NULL,
  `description` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `business_id_fk_idx` (`business_id` ASC) VISIBLE,
  CONSTRAINT `business_specials_id_fk`
    FOREIGN KEY (`business_id`)
    REFERENCES `we_network`.`business` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE);
    
    CREATE TABLE `we_network`.`business_category` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `category` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `category_UNIQUE` (`category` ASC) VISIBLE);
  
  CREATE TABLE `we_network`.`business_type` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `business_id` INT NOT NULL,
  `category_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `business_category_fk_idx` (`category_id` ASC) VISIBLE,
  INDEX `business_type_fk_idx` (`business_id` ASC) VISIBLE,
  CONSTRAINT `business_category_fk`
    FOREIGN KEY (`category_id`)
    REFERENCES `we_network`.`business_category` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `business_type_fk`
    FOREIGN KEY (`business_id`)
    REFERENCES `we_network`.`business` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE);
    
    CREATE TABLE `we_network`.`business_messages` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `receiver_business_id` INT NOT NULL,
  `sender_business_id` INT NOT NULL,
  `message` VARCHAR(500) NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `receiver_id_fk_idx` (`receiver_business_id` ASC) VISIBLE,
  INDEX `sender_id_fk_idx` (`sender_business_id` ASC) VISIBLE,
  CONSTRAINT `receiver_id_fk`
    FOREIGN KEY (`receiver_business_id`)
    REFERENCES `we_network`.`users` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `sender_id_fk`
    FOREIGN KEY (`sender_business_id`)
    REFERENCES `we_network`.`users` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE);