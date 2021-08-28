-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema aula03
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema aula03
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `aula03` DEFAULT CHARACTER SET utf8 ;
USE `aula03` ;

-- -----------------------------------------------------
-- Table `aula03`.`tipos_produto`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `aula03`.`tipos_produto` (
  `codigo` INT NOT NULL AUTO_INCREMENT,
  `descricao` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`codigo`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `aula03`.`produto`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `aula03`.`produto` (
  `codigo` INT NOT NULL AUTO_INCREMENT,
  `descricao` VARCHAR(45) NOT NULL,
  `preco` DECIMAL(8,2) NOT NULL,
  `codigo_do_tipo` INT NOT NULL,
  PRIMARY KEY (`codigo`),
  INDEX `codigo_tipo_produto'_idx` (`codigo_do_tipo` ASC) VISIBLE,
  CONSTRAINT `codigo_tipo_produto'`
    FOREIGN KEY (`codigo_do_tipo`)
    REFERENCES `aula03`.`tipos_produto` (`codigo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
