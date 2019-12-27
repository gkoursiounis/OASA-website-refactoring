SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema oasa
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `oasa` DEFAULT CHARACTER SET utf8 ;
USE `oasa` ;

-- -----------------------------------------------------
-- Table `oasa`.`user_category`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `oasa`.`user_category` (
  `iduser_category` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`iduser_category`),
  UNIQUE INDEX `name_UNIQUE` (`name` ASC),
  UNIQUE INDEX `idcategory_UNIQUE` (`iduser_category` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `oasa`.`user`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `oasa`.`user` (
  `iduser` INT NOT NULL AUTO_INCREMENT,
  `username` VARCHAR(45) NOT NULL,
  `first_name` VARCHAR(45) NOT NULL,
  `last_name` VARCHAR(45) NOT NULL,
  `email` VARCHAR(45) NOT NULL,
  `dob` DATE NOT NULL,
  `phone` INT(13) NOT NULL,
  `password` VARCHAR(256) NOT NULL,
  `iduser_category` INT NOT NULL,
  PRIMARY KEY (`iduser`),
  UNIQUE INDEX `iduser_UNIQUE` (`iduser` ASC) VISIBLE,
  INDEX `fk_user_user_category1_idx` (`iduser_category` ASC) VISIBLE,
  CONSTRAINT `fk_user_user_category1`
    FOREIGN KEY (`iduser_category`)
    REFERENCES `oasa`.`user_category` (`iduser_category`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `oasa`.`ticket_category`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `oasa`.`ticket_category` (
  `idticket_category` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  `price` DECIMAL NOT NULL,
  `iduser` INT NOT NULL,
  `iduser_category` INT NOT NULL,
  PRIMARY KEY (`idticket_category`),
  UNIQUE INDEX `idticket_category_UNIQUE` (`idticket_category` ASC) VISIBLE,
  INDEX `fk_ticket_category_user_category1_idx` (`iduser_category` ASC) VISIBLE,
  CONSTRAINT `fk_ticket_category_user_category1`
    FOREIGN KEY (`iduser_category`)
    REFERENCES `oasa`.`user_category` (`iduser_category`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;



-- -----------------------------------------------------
-- Table `oasa`.`ticket`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `oasa`.`ticket` (
  `idticket` INT NOT NULL AUTO_INCREMENT,
  `quantity` INT NOT NULL,
  `date` DATE NOT NULL,
  `iduser` INT NOT NULL,
  `idticket_category` INT NOT NULL,
  PRIMARY KEY (`idticket`),
  UNIQUE INDEX `idticket_UNIQUE` (`idticket` ASC) VISIBLE,
  INDEX `fk_ticket_ticket_category1_idx` (`idticket_category` ASC) VISIBLE,
  CONSTRAINT `fk_ticket_user1`
    FOREIGN KEY (`iduser`)
    REFERENCES `oasa`.`user` (`iduser`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_ticket_ticket_category1`
    FOREIGN KEY (`idticket_category`)
    REFERENCES `oasa`.`ticket_category` (`idticket_category`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `oasa`.`transport`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `oasa`.`transport` (
  `idtransport` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idtransport`),
  UNIQUE INDEX `idtransport_UNIQUE` (`idtransport` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `oasa`.`line`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `oasa`.`line` (
  `idline` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  `idtransport` INT NOT NULL,
  PRIMARY KEY (`idline`),
  UNIQUE INDEX `idline_UNIQUE` (`idline` ASC) VISIBLE,
  INDEX `fk_line_transport1_idx` (`idtransport` ASC) VISIBLE,
  CONSTRAINT `fk_line_transport1`
    FOREIGN KEY (`idtransport`)
    REFERENCES `oasa`.`transport` (`idtransport`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;



-- -----------------------------------------------------
-- Table `oasa`.`station`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `oasa`.`station` (
  `idstation` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  `latitude` DECIMAL NOT NULL,
  `longitude` DECIMAL NOT NULL,
  PRIMARY KEY (`idstation`),
  UNIQUE INDEX `idstation_UNIQUE` (`idstation` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `oasa`.`line_has_station`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `oasa`.`line_has_station` (
  `idline` INT NOT NULL,
  `idstation` INT NOT NULL,
  PRIMARY KEY (`idline`, `idstation`),
  INDEX `fk_line_has_station_station1_idx` (`idstation` ASC) VISIBLE,
  INDEX `fk_line_has_station_line1_idx` (`idline` ASC) VISIBLE,
  CONSTRAINT `fk_line_has_station_line1`
    FOREIGN KEY (`idline`)
    REFERENCES `oasa`.`line` (`idline`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_line_has_station_station1`
    FOREIGN KEY (`idstation`)
    REFERENCES `oasa`.`station` (`idstation`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;



SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;