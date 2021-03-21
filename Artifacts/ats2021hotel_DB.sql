DROP SCHEMA IF EXISTS `ats2021hotel`;
CREATE SCHEMA `ats2021hotel` /*!40100 DEFAULT CHARACTER SET latin1 */;
USE `ats2021hotel`;
-- MySQL dump 10.13  Distrib 8.0.22, for Win64 (x86_64)
--
-- Host: localhost    Database: ats2021hotel
-- ------------------------------------------------------
-- Server version	5.7.32-log

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `employees`
--

DROP TABLE IF EXISTS `employees`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `employees` (
  `Id` int(11) NOT NULL AUTO_INCREMENT,
  `FirstName` varchar(50) NOT NULL,
  `LastName` varchar(50) NOT NULL,
  `SIN` varchar(11) NOT NULL,
  `HourlyRate` decimal(10,0) NOT NULL,
  `IsDeleted` bit(1) NOT NULL,
  `CreatedAt` datetime NOT NULL,
  `UpdatedAt` datetime DEFAULT NULL,
  `DeletedAt` datetime DEFAULT NULL,
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `employees`
--

LOCK TABLES `employees` WRITE;
/*!40000 ALTER TABLE `employees` DISABLE KEYS */;
INSERT INTO `employees` VALUES (1,'Sam','Smith','111-222-333',30,_binary '\0','2021-03-19 22:05:19',NULL,NULL),(2,'Jennifer','Wilson','444-555-666',40,_binary '\0','2021-03-19 22:05:19',NULL,NULL);
/*!40000 ALTER TABLE `employees` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `employees_tasks`
--

DROP TABLE IF EXISTS `employees_tasks`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `employees_tasks` (
  `EmployeeId` int(11) NOT NULL,
  `TaskId` int(11) NOT NULL,
  PRIMARY KEY (`EmployeeId`,`TaskId`),
  KEY `TaskId_idx` (`TaskId`),
  CONSTRAINT `EmployeeId` FOREIGN KEY (`EmployeeId`) REFERENCES `employees` (`Id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `TaskId` FOREIGN KEY (`TaskId`) REFERENCES `tasks` (`Id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `employees_tasks`
--

LOCK TABLES `employees_tasks` WRITE;
/*!40000 ALTER TABLE `employees_tasks` DISABLE KEYS */;
/*!40000 ALTER TABLE `employees_tasks` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `job_tasks`
--

DROP TABLE IF EXISTS `job_tasks`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `job_tasks` (
  `TaskId` int(11) NOT NULL,
  `JobId` int(11) NOT NULL,
  `OperatingCost` decimal(10,0) NOT NULL,
  `OperatingRevenue` decimal(10,0) NOT NULL,
  PRIMARY KEY (`TaskId`,`JobId`),
  KEY `JobId_JobTask_FK_idx` (`JobId`),
  CONSTRAINT `JobId_JobTask_FK` FOREIGN KEY (`JobId`) REFERENCES `jobs` (`Id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `TaskId_jobTask_FK` FOREIGN KEY (`TaskId`) REFERENCES `tasks` (`Id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `job_tasks`
--

LOCK TABLES `job_tasks` WRITE;
/*!40000 ALTER TABLE `job_tasks` DISABLE KEYS */;
/*!40000 ALTER TABLE `job_tasks` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `jobs`
--

DROP TABLE IF EXISTS `jobs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `jobs` (
  `Id` int(11) NOT NULL AUTO_INCREMENT,
  `TeamId` int(11) NOT NULL,
  `Description` varchar(255) NOT NULL,
  `ClientName` varchar(255) NOT NULL,
  `Start` datetime NOT NULL,
  `End` datetime NOT NULL,
  PRIMARY KEY (`Id`),
  KEY `team_idfk_idx` (`TeamId`),
  KEY `job_team_idfk_idx` (`TeamId`),
  CONSTRAINT `job_team_idfk` FOREIGN KEY (`TeamId`) REFERENCES `teams` (`Id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `jobs`
--

LOCK TABLES `jobs` WRITE;
/*!40000 ALTER TABLE `jobs` DISABLE KEYS */;
/*!40000 ALTER TABLE `jobs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tasks`
--

DROP TABLE IF EXISTS `tasks`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tasks` (
  `Id` int(11) NOT NULL AUTO_INCREMENT,
  `Name` varchar(255) NOT NULL,
  `Description` varchar(255) NOT NULL,
  `Duration` int(11) NOT NULL,
  `CreatedAt` datetime NOT NULL,
  `UpdatedAt` datetime DEFAULT NULL,
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tasks`
--

LOCK TABLES `tasks` WRITE;
/*!40000 ALTER TABLE `tasks` DISABLE KEYS */;
INSERT INTO `tasks` VALUES (1,'Network Design','Network design is a category of systems design that deals with data transport mechanisms',30,'2021-03-16 19:48:54',NULL),(2,'Network security','Network security is a broad term that covers a multitude of technologies, devices and processes.',60,'2021-03-17 15:38:48',NULL),(3,'Router Configuration','Configure client\'s router to make their network complete.',30,'2021-03-17 15:44:13',NULL),(7,'','tests',30,'2021-03-18 20:53:35',NULL);
/*!40000 ALTER TABLE `tasks` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `team_members`
--

DROP TABLE IF EXISTS `team_members`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `team_members` (
  `EmployeeId` int(11) NOT NULL,
  `TeamId` int(11) NOT NULL,
  PRIMARY KEY (`EmployeeId`,`TeamId`),
  KEY `team_idfk_idx` (`TeamId`),
  CONSTRAINT `emp_idfk` FOREIGN KEY (`EmployeeId`) REFERENCES `employees` (`Id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `team_idfk` FOREIGN KEY (`TeamId`) REFERENCES `teams` (`Id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `team_members`
--

LOCK TABLES `team_members` WRITE;
/*!40000 ALTER TABLE `team_members` DISABLE KEYS */;
/*!40000 ALTER TABLE `team_members` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `teams`
--

DROP TABLE IF EXISTS `teams`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `teams` (
  `Id` int(11) NOT NULL AUTO_INCREMENT,
  `Name` varchar(255) NOT NULL,
  `IsOnCall` bit(1) NOT NULL,
  `IsDeleted` bit(1) NOT NULL,
  `CreatedAt` datetime NOT NULL,
  `UpdatedAt` datetime DEFAULT NULL,
  `DeletedAt` datetime DEFAULT NULL,
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `teams`
--

LOCK TABLES `teams` WRITE;
/*!40000 ALTER TABLE `teams` DISABLE KEYS */;
/*!40000 ALTER TABLE `teams` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping routines for database 'ats2021hotel'
--
/*!50003 DROP PROCEDURE IF EXISTS `InsertEmployee` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`dev`@`%` PROCEDURE `InsertEmployee`(
  IN FirstName_param VARCHAR(50),
  IN LastName_param VARCHAR(50),
  IN SIN_param VARCHAR(11),
  IN HourlyRate_param DECIMAL(10,0),
  OUT Id_out INT
)
BEGIN
	INSERT INTO employees(FirstName, LastName, SIN, HourlyRate, IsDeleted, CreatedAt)
		VALUES(FirstName_param, LastName_param, SIN_param, HourlyRate_param, 0, CURRENT_TIMESTAMP());
		
    SET Id_out = LAST_INSERT_ID();
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `InsertTask` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO' */ ;
DELIMITER ;;
CREATE DEFINER=`dev`@`%` PROCEDURE `InsertTask`(
IN Name_param NVARCHAR(255),
IN Description_param NVARCHAR(255),
IN Duration_param INT,
OUT Id_out INT
)
BEGIN

	INSERT INTO tasks(Name, Description, Duration, CreatedAt)
    VALUES(Name_param, Description_param, Duration_param, CURRENT_TIMESTAMP());
    
    SET Id_out = LAST_INSERT_ID();

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `InsertTeam` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`dev`@`%` PROCEDURE `InsertTeam`(
IN Name_param NVARCHAR(255),
IN IsOnCall_param BIT,
IN Employee1_param INT,
IN Employee2_param INT,
OUT Id_out INT
)
BEGIN
	DECLARE exit handler FOR SQLEXCEPTION, SQLWARNING
	  BEGIN
		ROLLBACK;
		RESIGNAL;
	  END;

	START TRANSACTION; 
		INSERT INTO teams(Name, IsOnCall, IsDeleted, CreatedAt)
		VALUES(Name_param, IsOnCall_param, 0, CURRENT_TIMESTAMP());
		
		SET Id_out = LAST_INSERT_ID();
		
		INSERT INTO team_members(EmployeeId, TeamId)
		VALUES
			(Employee1_param, Id_out),
			(Employee2_param, Id_out);
	COMMIT;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `RetrieveAllEmployeeById` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`dev`@`%` PROCEDURE `RetrieveAllEmployeeById`(
	IN Id_param INT
)
BEGIN

	SELECT (Id, FirstName, LastName, SIN, HourlyRate, IsDeleted, CreatedAt, UpdatedAt, DeletedAt)
    FROM employees
    WHERE (Id_param IS NULL OR id = Id_param)
    ORDER BY CreatedAt;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `RetrieveAllEmployees` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`dev`@`%` PROCEDURE `RetrieveAllEmployees`()
BEGIN

	SELECT (Id, FirstName, LastName, SIN, HourlyRate, IsDeleted, CreatedAt, UpdatedAt, DeletedAt)
    FROM employees
    ORDER BY CreatedAt;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `RetrieveTasks` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`dev`@`%` PROCEDURE `RetrieveTasks`(
	IN Id_param INT
)
BEGIN
	
    SELECT Id, Name, Description, Duration FROM Tasks
    WHERE (Id_param IS NULL OR Id = Id_param)
    ORDER BY CreatedAt;
    
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2021-03-19 22:40:22
