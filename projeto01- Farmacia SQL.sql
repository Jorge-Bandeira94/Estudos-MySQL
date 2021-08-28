-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema Projeto01
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema Projeto01
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `Projeto01` DEFAULT CHARACTER SET utf8 ;
USE `Projeto01` ;

-- -----------------------------------------------------
-- Table `Projeto01`.`tipos_produto`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Projeto01`.`tipos_produto` (
  `idtipos_produto` INT NOT NULL AUTO_INCREMENT,
  `tipo` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idtipos_produto`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Projeto01`.`fabricante`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Projeto01`.`fabricante` (
  `idfabricante` INT NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idfabricante`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Projeto01`.`produtos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Projeto01`.`produtos` (
  `idprodutos` INT NOT NULL AUTO_INCREMENT,
  `designacao` VARCHAR(45) NOT NULL,
  `id_fabricante` INT NOT NULL,
  `composicao` VARCHAR(45) NOT NULL,
  `id_tipo` INT NOT NULL,
  `preco` DECIMAL(8,2) NOT NULL,
  `nome` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idprodutos`),
  INDEX `id_fabricante_FK1_idx` (`id_fabricante` ASC) VISIBLE,
  INDEX `id_tipo_fk1_idx` (`id_tipo` ASC) VISIBLE,
  CONSTRAINT `id_fabricante_FK1`
    FOREIGN KEY (`id_fabricante`)
    REFERENCES `Projeto01`.`fabricante` (`idfabricante`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `id_tipo_fk1`
    FOREIGN KEY (`id_tipo`)
    REFERENCES `Projeto01`.`tipos_produto` (`idtipos_produto`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Projeto01`.`clientes`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Projeto01`.`clientes` (
  `idclientes` INT NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(45) NOT NULL,
  `endereco` VARCHAR(45) NOT NULL,
  `telefone` VARCHAR(45) NOT NULL,
  `cep` VARCHAR(45) NOT NULL,
  `cpf` INT NOT NULL,
  `localidade` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idclientes`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Projeto01`.`compra`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Projeto01`.`compra` (
  `idcompras` INT NOT NULL,
  `data` DATETIME NOT NULL,
  `id_cliente` INT NOT NULL,
  PRIMARY KEY (`idcompras`),
  INDEX `id_cliente_fk1_idx` (`id_cliente` ASC) VISIBLE,
  CONSTRAINT `id_cliente_fk1`
    FOREIGN KEY (`id_cliente`)
    REFERENCES `Projeto01`.`clientes` (`idclientes`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Projeto01`.`produtos_compra`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Projeto01`.`produtos_compra` (
  `idprodutos_compra` INT NOT NULL AUTO_INCREMENT,
  `id_produto` INT NOT NULL,
  `id_compra` INT NOT NULL,
  `quantidade` INT NOT NULL,
  PRIMARY KEY (`idprodutos_compra`),
  INDEX `id_produto_fk2_idx` (`id_produto` ASC) VISIBLE,
  INDEX `id_compras_fk2_idx` (`id_compra` ASC) VISIBLE,
  CONSTRAINT `id_produto_fk2`
    FOREIGN KEY (`id_produto`)
    REFERENCES `Projeto01`.`produtos` (`idprodutos`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `id_compras_fk2`
    FOREIGN KEY (`id_compra`)
    REFERENCES `Projeto01`.`compra` (`idcompras`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Projeto01`.`medico`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Projeto01`.`medico` (
  `idmedico` INT NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(45) NOT NULL,
  `crm` INT NOT NULL,
  PRIMARY KEY (`idmedico`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Projeto01`.`receitas_medica`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Projeto01`.`receitas_medica` (
  `idreceitas_medica` INT NOT NULL AUTO_INCREMENT,
  `id_produtos_compra` INT NOT NULL,
  `id_medico` INT NOT NULL,
  `receitas_medica` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idreceitas_medica`),
  INDEX `id_produtos_copra_fk3_idx` (`id_produtos_compra` ASC) VISIBLE,
  INDEX `id_medico_fk1_idx` (`id_medico` ASC) VISIBLE,
  CONSTRAINT `id_produtos_copra_fk3`
    FOREIGN KEY (`id_produtos_compra`)
    REFERENCES `Projeto01`.`produtos_compra` (`idprodutos_compra`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `id_medico_fk1`
    FOREIGN KEY (`id_medico`)
    REFERENCES `Projeto01`.`medico` (`idmedico`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
