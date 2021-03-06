-- MySQL Script generated by MySQL Workbench
-- Tue Mar 14 13:57:22 2017
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema inventory
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema inventory
-- -----------------------------------------------------
-- CREATE SCHEMA IF NOT EXISTS `inventory` DEFAULT CHARACTER SET utf8 ;
USE `inventory` ;

-- -----------------------------------------------------
-- Table `inventory`.`Permission`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `inventory`.`Permission` (
  `PermissionID` INT NOT NULL AUTO_INCREMENT,
  `Role` VARCHAR(45) NULL DEFAULT 'GUEST',
  `PermissionLevel` INT NOT NULL DEFAULT 0,
  PRIMARY KEY (`PermissionID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `inventory`.`Users`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `inventory`.`Users` (
  `UserID` INT NOT NULL AUTO_INCREMENT,
  `FirstName` VARCHAR(45) NULL,
  `LastName` VARCHAR(45) NULL,
  `NickName` VARCHAR(45) NULL,
  `PermissionID` INT NULL,
  `isDisable` BIT(1) NOT NULL,
  `UserName` VARCHAR(45) NOT NULL,
  `Password` VARCHAR(100) NOT NULL,
  PRIMARY KEY (`UserID`),
  INDEX `idPermission_idx` (`PermissionID` ASC),
  CONSTRAINT `idPermission`
    FOREIGN KEY (`PermissionID`)
    REFERENCES `inventory`.`Permission` (`PermissionID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `inventory`.`PCUsers`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `inventory`.`PCUsers` (
  `PCUserID` INT NOT NULL COMMENT '	',
  `FirstName` VARCHAR(45) NOT NULL COMMENT '	',
  `LastName` VARCHAR(45) NOT NULL,
  `NickName` VARCHAR(45) NOT NULL COMMENT '		',
  `ProfileImage` BLOB NULL,
  `RegisteredDate` VARCHAR(45) NOT NULL,
  `Updated` VARCHAR(45) NOT NULL,
  `idUser` INT NOT NULL,
  `TransactionDate` DATETIME NULL,
  PRIMARY KEY (`PCUserID`),
  INDEX `idUser_idx` (`idUser` ASC),
  CONSTRAINT `idUser`
    FOREIGN KEY (`idUser`)
    REFERENCES `inventory`.`Users` (`UserID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `inventory`.`ProductUnit`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `inventory`.`ProductUnit` (
  `ProductUnitID` INT NOT NULL AUTO_INCREMENT COMMENT '- Bottle\n- Box\n- Pack\n\nขวด\nกล่อง\nแพค',
  `ProductUnit` VARCHAR(45) NULL,
  PRIMARY KEY (`ProductUnitID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `inventory`.`Products`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `inventory`.`Products` (
  `ProductID` INT NOT NULL AUTO_INCREMENT,
  `ProductName` VARCHAR(45) NOT NULL COMMENT '	',
  `ProductImage` BLOB NULL,
  `Price` DOUBLE NOT NULL DEFAULT 0,
  `Commission` DOUBLE NOT NULL DEFAULT 0,
  `Updated` DATETIME NULL,
  `ProductUnit` INT NULL,
  `canRedeem` BIT(1) NULL COMMENT 'Redeemable = 1\nNo Redeem = 0\n',
  PRIMARY KEY (`ProductID`),
  INDEX `ProductUnit_idx` (`ProductUnit` ASC),
  CONSTRAINT `ProductUnit`
    FOREIGN KEY (`ProductUnit`)
    REFERENCES `inventory`.`ProductUnit` (`ProductUnitID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `inventory`.`Stores`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `inventory`.`Stores` (
  `StoreID` INT NOT NULL COMMENT '			',
  `StoreName` VARCHAR(45) NOT NULL,
  `Address` VARCHAR(45) NOT NULL,
  `Province` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`StoreID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `inventory`.`PCUserInStore`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `inventory`.`PCUserInStore` (
  `PCUserID` INT NULL,
  `StoreID` INT NULL,
  INDEX `idPCUser_idx` (`PCUserID` ASC),
  INDEX `idStore_idx` (`StoreID` ASC),
  CONSTRAINT `idPCUser`
    FOREIGN KEY (`PCUserID`)
    REFERENCES `inventory`.`PCUsers` (`PCUserID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `idStore`
    FOREIGN KEY (`StoreID`)
    REFERENCES `inventory`.`Stores` (`StoreID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `inventory`.`Sold`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `inventory`.`Sold` (
  `idSold` INT NOT NULL,
  `idProduct` INT NULL,
  `Amount` VARCHAR(45) NULL,
  PRIMARY KEY (`idSold`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `inventory`.`TransactionType`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `inventory`.`TransactionType` (
  `TransactionTypeID` INT NOT NULL AUTO_INCREMENT COMMENT '- Purchase\n- Sold\n- Withdraw',
  `TransactionType` VARCHAR(45) NULL,
  PRIMARY KEY (`TransactionTypeID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `inventory`.`Transactions`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `inventory`.`Transactions` (
  `TransactionID` INT NOT NULL,
  `TransactionType` INT NOT NULL,
  `ProductID` INT NOT NULL,
  `PCUserID` INT NOT NULL,
  `Amount` INT NOT NULL DEFAULT 0,
  `Date` DATETIME NOT NULL,
  PRIMARY KEY (`TransactionID`),
  INDEX `Product_idx` (`ProductID` ASC),
  INDEX `TransactionType_idx` (`TransactionType` ASC),
  INDEX `PCUser_idx` (`PCUserID` ASC),
  CONSTRAINT `Product`
    FOREIGN KEY (`ProductID`)
    REFERENCES `inventory`.`Products` (`ProductID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `TransactionType`
    FOREIGN KEY (`TransactionType`)
    REFERENCES `inventory`.`TransactionType` (`TransactionTypeID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `PCUser`
    FOREIGN KEY (`PCUserID`)
    REFERENCES `inventory`.`PCUsers` (`PCUserID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `inventory`.`IssueType`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `inventory`.`IssueType` (
  `IssueTypeID` INT NOT NULL AUTO_INCREMENT,
  `Issue` VARCHAR(45) NULL COMMENT '- Purchase\n- Inventory\n- Sell\n- Technical\n- Others',
  PRIMARY KEY (`IssueTypeID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `inventory`.`IssueStatus`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `inventory`.`IssueStatus` (
  `IssueStatusID` INT NOT NULL AUTO_INCREMENT,
  `IssueType` VARCHAR(45) NULL COMMENT '- Open\n- Pending\n\n- Close with Fixed\n- Close ignore\n',
  PRIMARY KEY (`IssueStatusID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `inventory`.`Issue`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `inventory`.`Issue` (
  `IssueID` INT NOT NULL,
  `IssueType` INT NULL,
  `Description` TEXT(1000) NULL,
  `IssueStatusID` INT NULL,
  PRIMARY KEY (`IssueID`),
  INDEX `IssueType_idx` (`IssueType` ASC),
  INDEX `IssueStatus_idx` (`IssueStatusID` ASC),
  CONSTRAINT `IssueType`
    FOREIGN KEY (`IssueType`)
    REFERENCES `inventory`.`IssueType` (`IssueTypeID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `IssueStatus`
    FOREIGN KEY (`IssueStatusID`)
    REFERENCES `inventory`.`IssueStatus` (`IssueStatusID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `inventory`.`StoreIssues`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `inventory`.`StoreIssues` (
  `StoreID` INT NULL,
  `IssueID` INT NULL,
  INDEX `Issue_idx` (`IssueID` ASC),
  CONSTRAINT `Store`
    FOREIGN KEY (`StoreID`)
    REFERENCES `inventory`.`Stores` (`StoreID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `Issue`
    FOREIGN KEY (`IssueID`)
    REFERENCES `inventory`.`Issue` (`IssueID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `inventory`.`LeaveType`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `inventory`.`LeaveType` (
  `LeaveTypeID` INT NOT NULL COMMENT '- Sick Leave\n- Business Leave\n- Other Leave',
  `LeaveType` VARCHAR(45) NULL,
  PRIMARY KEY (`LeaveTypeID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `inventory`.`Leave`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `inventory`.`Leave` (
  `LeaveID` INT NOT NULL,
  `LeaveTypeID` INT NOT NULL,
  `FromDate` DATETIME NULL,
  `ToDate` DATETIME NULL,
  `LeaveAmount` DOUBLE NOT NULL DEFAULT 0,
  `PCUserID` INT NOT NULL,
  `Reason` TEXT(1000) NOT NULL,
  PRIMARY KEY (`LeaveID`),
  INDEX `LeaveType_idx` (`LeaveTypeID` ASC),
  INDEX `PCUser_idx` (`PCUserID` ASC),
  CONSTRAINT `LeaveType`
    FOREIGN KEY (`LeaveTypeID`)
    REFERENCES `inventory`.`LeaveType` (`LeaveTypeID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `PCUser`
    FOREIGN KEY (`PCUserID`)
    REFERENCES `inventory`.`PCUsers` (`PCUserID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `inventory`.`ci_sessions`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `inventory`.`ci_sessions` (
  `id` VARCHAR(128) NOT NULL,
  `ip_address` VARCHAR(45) NOT NULL,
  `timestamp` BIGINT(45) NOT NULL,
  `data` TEXT(1000) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
