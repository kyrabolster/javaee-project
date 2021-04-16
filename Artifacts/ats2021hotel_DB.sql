DROP SCHEMA IF EXISTS `ats2021hotel`;
CREATE SCHEMA `ats2021hotel`;
USE `ats2021hotel`;


--
-- Table structure for table `employees`
--

DROP TABLE IF EXISTS `employees`;

CREATE TABLE `employees` (
  `Id` int(11) NOT NULL AUTO_INCREMENT,
  `FirstName` varchar(50) NOT NULL,
  `LastName` varchar(50) NOT NULL,
  `SIN` varchar(11) NOT NULL,
  `HourlyRate` decimal(13,2) NOT NULL,
  `IsDeleted` bit(1) NOT NULL,
  `CreatedAt` datetime NOT NULL,
  `UpdatedAt` datetime DEFAULT NULL,
  `DeletedAt` datetime DEFAULT NULL,
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `employees`
--

LOCK TABLES `employees` WRITE;
INSERT INTO `employees` VALUES (1,'Sam','Smith','111-222-333',50.00,_binary '\0','2021-03-19 22:05:19',NULL,NULL),(2,'Jennifer','Wilson','444-555-666',100.00,_binary '\0','2021-03-19 22:05:19',NULL,NULL),(3,'Christine','Sipes','123-456-789',25.00,_binary '\0','2021-03-20 17:50:23',NULL,NULL),(4,'Mackenzie','Hettinger','987-654-321',40.00,_binary '\0','2021-03-20 17:50:23',NULL,NULL),(5,'Sam','Smith','111-222-333',30.00,_binary '\0','2021-03-21 15:32:07',NULL,NULL),(6,'Jonathan','Pryor','123-456-789',60.00,_binary '\0','2021-03-23 17:55:13',NULL,NULL),(7,'Frank','Simpkins','987-654-321',40.00,_binary '','2021-03-23 17:55:13',NULL,'2021-04-07 10:00:02'),(8,'Dina','Gregory','123-456-789',50.00,_binary '\0','2021-03-23 17:55:13',NULL,NULL),(9,'Maria','Bright','987-654-321',40.00,_binary '','2021-03-23 17:55:13',NULL,'2021-04-06 14:59:11'),(10,'Angela','Joseph','123-456-789',50.00,_binary '\0','2021-03-23 17:55:13',NULL,NULL),(11,'Robert','Perez','987-654-321',45.00,_binary '\0','2021-03-23 17:55:13',NULL,NULL),(12,'Frederick','Delgado','123-456-789',55.00,_binary '\0','2021-03-23 17:55:13',NULL,NULL),(15,'Theodore','Daniel','234-123-512',50.00,_binary '\0','2021-04-08 09:38:36',NULL,NULL),(16,'Margaret','Calder','288-123-213',75.00,_binary '\0','2021-04-08 09:38:59',NULL,NULL);
UNLOCK TABLES;

--
-- Table structure for table `employees_tasks`
--

DROP TABLE IF EXISTS `employees_tasks`;

CREATE TABLE `employees_tasks` (
  `EmployeeId` int(11) NOT NULL,
  `TaskId` int(11) NOT NULL,
  PRIMARY KEY (`EmployeeId`,`TaskId`),
  KEY `TaskId_idx` (`TaskId`),
  CONSTRAINT `EmployeeId` FOREIGN KEY (`EmployeeId`) REFERENCES `employees` (`Id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `TaskId` FOREIGN KEY (`TaskId`) REFERENCES `tasks` (`Id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


--
-- Dumping data for table `employees_tasks`
--

LOCK TABLES `employees_tasks` WRITE;

INSERT INTO `employees_tasks` VALUES (1,1),(10,1),(1,2),(2,2),(3,2),(7,2),(2,3),(7,4),(6,6),(15,6),(12,7),(16,7),(10,8),(12,9);

UNLOCK TABLES;

--
-- Table structure for table `job_tasks`
--

DROP TABLE IF EXISTS `job_tasks`;

CREATE TABLE `job_tasks` (
  `TaskId` int(11) NOT NULL,
  `JobId` int(11) NOT NULL,
  `OperatingCost` decimal(13,2) NOT NULL,
  `OperatingRevenue` decimal(13,2) NOT NULL,
  PRIMARY KEY (`TaskId`,`JobId`),
  KEY `JobId_JobTask_FK_idx` (`JobId`),
  CONSTRAINT `JobId_JobTask_FK` FOREIGN KEY (`JobId`) REFERENCES `jobs` (`Id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `TaskId_jobTask_FK` FOREIGN KEY (`TaskId`) REFERENCES `tasks` (`Id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


--
-- Dumping data for table `job_tasks`
--

LOCK TABLES `job_tasks` WRITE;

INSERT INTO `job_tasks` VALUES (1,1,100.00,300.00),(1,2,100.00,300.00),(1,3,100.00,300.00),(1,6,50.00,150.00),(1,7,50.00,150.00),(1,8,50.00,150.00),(1,9,50.00,150.00),(1,11,50.00,150.00),(1,13,50.00,150.00),(2,1,250.00,750.00),(2,13,60.00,180.00),(2,28,37.50,112.50),(2,29,37.50,112.50),(2,30,37.50,112.50),(3,3,150.00,450.00),(3,5,50.00,150.00),(3,12,30.00,120.00),(3,14,50.00,150.00),(3,15,50.00,150.00),(4,2,80.00,240.00),(4,12,55.00,220.00),(5,12,60.00,240.00),(6,4,120.00,480.00),(7,4,82.50,330.00);

UNLOCK TABLES;

--
-- Table structure for table `jobs`
--

DROP TABLE IF EXISTS `jobs`;

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
) ENGINE=InnoDB AUTO_INCREMENT=33 DEFAULT CHARSET=latin1;


--
-- Dumping data for table `jobs`
--

LOCK TABLES `jobs` WRITE;

INSERT INTO `jobs` VALUES (1,1,'The client wants networking setting','Peal','2021-03-04 10:00:00','2021-03-04 11:30:00'),(2,2,'Switch configuration needs','Desert','2021-02-09 10:30:00','2021-02-09 11:30:00'),(3,1,'Router setting','Creative Company','2021-01-09 14:00:00','2021-01-09 16:00:00'),(4,3,'Emergency call','Freshbooks','2021-04-10 00:30:00','2021-04-10 01:30:00'),(5,1,'Need job done with quality and care, please!','Sophie Peredur','2021-05-15 15:50:00','2021-05-15 17:20:00'),(6,1,'No specific requirements','Sara Maria','2020-08-09 10:30:00','2020-08-09 11:30:00'),(7,2,'No requirements','Daria Aila','2020-04-09 10:30:00','2020-04-09 11:30:00'),(8,2,'No requirements','Pali Artur','2020-02-09 10:30:00','2020-02-09 11:30:00'),(9,2,'No requirements','Leland Beck','2021-05-01 15:56:00','2021-05-01 16:56:00'),(11,1,'No requirements','Kristina Appleby','2020-11-09 10:30:00','2020-11-09 11:30:00'),(12,3,'No requirements','Maria','2020-08-11 10:30:00','2020-08-11 12:30:00'),(13,2,'No requirements','Greg Inc','2020-04-02 10:30:00','2020-04-02 12:30:00'),(14,1,'No requirements','Denis','2021-04-16 16:10:00','2021-04-16 16:40:00'),(15,1,'No requirements','William','2020-07-02 10:30:00','2020-07-02 11:00:00'),(28,4,'No requirements','Good Company','2021-04-23 13:00:00','2021-04-23 14:30:00'),(29,4,'No requirements','Good Company','2021-04-23 13:00:00','2021-04-23 14:30:00'),(30,4,'No requirements','Sarah','2021-04-24 13:33:00','2021-04-24 15:03:00');

UNLOCK TABLES;

--
-- Table structure for table `tasks`
--

DROP TABLE IF EXISTS `tasks`;

CREATE TABLE `tasks` (
  `Id` int(11) NOT NULL AUTO_INCREMENT,
  `Name` varchar(255) NOT NULL,
  `Description` varchar(255) NOT NULL,
  `Duration` int(11) NOT NULL,
  `CreatedAt` datetime NOT NULL,
  `UpdatedAt` datetime DEFAULT NULL,
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=latin1;


--
-- Dumping data for table `tasks`
--

LOCK TABLES `tasks` WRITE;

INSERT INTO `tasks` VALUES (1,'Network Design','Network design is a category of systems design that deals with data transport mechanisms',60,'2021-03-16 19:48:54',NULL),(2,'Network security','Network security is a broad term that covers a multitude of technologies, devices and processes.',90,'2021-03-17 15:38:48',NULL),(3,'Router Configuration','Configure client\'s router to make their network complete.',30,'2021-03-17 15:44:13',NULL),(4,'Switch Configuration','To prepare a switch for remote management access, the switch must be configured with an IP address and a subnet mask.',60,'2021-03-23 17:45:29',NULL),(5,'Server Build and Repair','Server Build and Repair',60,'2021-03-23 17:47:49',NULL),(6,'Server OS Installations','Installation Server operating system',60,'2021-03-23 17:48:29',NULL),(7,'Server OS Support','Server Operating System Support',30,'2021-03-23 17:49:16',NULL),(8,'DevOps','DevOps is the combination of cultural philosophies, practices, and tools that increases an organization\'s ability to deliver applications and services at high velocity',120,'2021-03-23 17:50:32',NULL),(9,'Desktop and Mobile hardware build and repair','Desktop and Mobile hardware build and repair',75,'2021-03-23 17:51:46',NULL);

UNLOCK TABLES;

--
-- Table structure for table `team_members`
--

DROP TABLE IF EXISTS `team_members`;

CREATE TABLE `team_members` (
  `EmployeeId` int(11) NOT NULL,
  `TeamId` int(11) NOT NULL,
  PRIMARY KEY (`EmployeeId`,`TeamId`),
  KEY `team_idfk_idx` (`TeamId`),
  CONSTRAINT `emp_idfk` FOREIGN KEY (`EmployeeId`) REFERENCES `employees` (`Id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `team_idfk` FOREIGN KEY (`TeamId`) REFERENCES `teams` (`Id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


--
-- Dumping data for table `team_members`
--

LOCK TABLES `team_members` WRITE;

INSERT INTO `team_members` VALUES (1,1),(2,1),(7,2),(10,2),(6,3),(12,3),(3,4),(9,4),(4,5),(8,5);

UNLOCK TABLES;

--
-- Table structure for table `teams`
--

DROP TABLE IF EXISTS `teams`;

CREATE TABLE `teams` (
  `Id` int(11) NOT NULL AUTO_INCREMENT,
  `Name` varchar(255) NOT NULL,
  `IsOnCall` bit(1) NOT NULL,
  `IsDeleted` bit(1) NOT NULL,
  `CreatedAt` datetime NOT NULL,
  `UpdatedAt` datetime DEFAULT NULL,
  `DeletedAt` datetime DEFAULT NULL,
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=latin1;


--
-- Dumping data for table `teams`
--

LOCK TABLES `teams` WRITE;

INSERT INTO `teams` VALUES (1,'First',_binary '\0',_binary '\0','2021-03-20 22:19:41',NULL,NULL),(2,'Blue',_binary '\0',_binary '\0','2021-03-23 17:56:39',NULL,NULL),(3,'Giants',_binary '',_binary '\0','2021-03-23 17:58:01','2021-04-16 15:26:53',NULL),(4,'Green',_binary '\0',_binary '\0','2021-04-06 08:56:27','2021-04-16 15:26:43',NULL),(5,'Purple',_binary '\0',_binary '','2021-04-07 21:35:45','2021-04-07 21:37:00','2021-04-07 21:41:00');

UNLOCK TABLES;

--
-- Dumping routines for database 'ats2021hotel'
--

DELIMITER ;;
CREATE PROCEDURE `AddEmployeeSkill`(
IN Employee_id_param INT,
IN Task_id_param INT
)
BEGIN
	INSERT INTO employees_tasks
		(EmployeeId, TaskId)
	VALUES 
		(Employee_id_param, Task_id_param);
END ;;
DELIMITER ;

DELIMITER ;;
CREATE PROCEDURE `DeleteEmployee`(
IN Id_param INT
)
BEGIN
	IF EXISTS (SELECT employeeId FROM team_members WHERE employeeId = Id_param) THEN
			UPDATE employees 
				SET isDeleted = 1, deletedAt = CURRENT_TIMESTAMP()
			WHERE Id = Id_param;
		ELSE    
			DELETE FROM employees_tasks WHERE EmployeeId = Id_param;
			DELETE FROM employees WHERE Id = Id_param;
		END IF;
END ;;
DELIMITER ;

DELIMITER ;;
CREATE PROCEDURE `DeleteJob`(
	IN Id_param INT
)
BEGIN
	DELETE FROM job_tasks WHERE JobId = Id_param;
	DELETE FROM jobs WHERE id = Id_param;
END ;;
DELIMITER ;

DELIMITER ;;
CREATE PROCEDURE `DeleteTask`(
IN Id_param INT
)
BEGIN
	IF NOT EXISTS (
		SELECT taskId FROM employees_tasks WHERE TaskId = Id_param
			UNION ALL
		SELECT taskId FROM job_tasks WHERE TaskId = Id_param) 
	THEN
			DELETE FROM tasks WHERE id = Id_param;
	END IF;
END ;;
DELIMITER ;

DELIMITER ;;
CREATE PROCEDURE `DeleteTeam`(
IN Id_param INT
)
BEGIN
	IF EXISTS (SELECT teamId FROM jobs WHERE teamId = Id_param) THEN
			UPDATE teams 
				SET isDeleted = 1, deletedAt = CURRENT_TIMESTAMP()
			WHERE Id = Id_param;
		ELSE    
			DELETE FROM team_members WHERE teamId = Id_param;
			DELETE FROM teams WHERE Id = Id_param;
		END IF;
END ;;
DELIMITER ;

DELIMITER ;;
CREATE DEFINER=`dev`@`localhost` PROCEDURE `GetNumJobsForDay`()
BEGIN
     SELECT COUNT(Id) FROM jobs WHERE DATE(start) = CURDATE(); 
END ;;
DELIMITER ;

DELIMITER ;;
CREATE PROCEDURE `GetTasksNotAssignedToEmployee`(IN Employee_Id_param INT)
BEGIN
	SELECT tasks.* FROM tasks 
	WHERE tasks.id NOT IN (
		SELECT taskId FROM employees_tasks
			INNER JOIN employees
				ON employees.id = employees_tasks.EmployeeId
		WHERE employees.id = Employee_Id_param
    );
END ;;
DELIMITER ;

DELIMITER ;;
CREATE PROCEDURE `InsertEmergencyJob`(
IN TeamId_param INT,
IN ClientName_param NVARCHAR(255),
IN Description_param NVARCHAR(255),
IN Start_param datetime,
IN Tasks_id_array VARCHAR(1000),
IN IsOnSite boolean,
IN Duration_param INT,
OUT Id_out INT)
BEGIN
DECLARE EndTime datetime;
	# variables for insert task_jobs
    DECLARE tasks_id_array_local VARCHAR(1000);
    DECLARE start_pos SMALLINT;
    DECLARE comma_pos SMALLINT;
    DECLARE current_taskId VARCHAR(1000);
    DECLARE end_loop TINYINT;
    DECLARE TaskIndex INT;
    DECLARE AssignedMember INT; # Employee ID
    DECLARE Rate DECIMAL; # Employee hourly rate
    DECLARE OperatingCost_param DECIMAL(13,2);
    DECLARE OperatingRevenue_param DECIMAL(13,2);
    DECLARE DurationPerTask DECIMAL(13,2);
	DECLARE exit handler FOR SQLEXCEPTION, SQLWARNING
	  BEGIN
		ROLLBACK;
		RESIGNAL;
	  END;

	START TRANSACTION; 
        # if the job is on site, add 30 minutes for start and end time
        IF IsOnSite = true THEN
			SET Start_param = subtime(Start_param, '00:30:00');
		END IF;
        
        SET EndTime = addtime(Start_param, SEC_TO_TIME(Duration_param * 60));
        
		INSERT INTO jobs(TeamId, Description, ClientName, Start, End)
		VALUES(TeamId_param, Description_param, ClientName_param, Start_param, EndTime);
		
        # set job id
		SET Id_out = LAST_INSERT_ID();
        
        SET tasks_id_array_local = Tasks_id_array;
		SET start_pos = 1;
		SET comma_pos = locate(',', tasks_id_array_local);
        SET TaskIndex = 1;
        SET AssignedMember = 0;
        
        REPEAT
		#SET Rate = 0;
        
        IF comma_pos > 0 THEN
            SET current_taskId = substring(tasks_id_array_local, start_pos, comma_pos - start_pos);
            SET end_loop = 0;
        ELSE
            SET current_taskId = substring(tasks_id_array_local, start_pos);
            SET end_loop = 1;
        END IF;
        
        # calculate cost and revenue
        IF AssignedMember = 0 THEN
			SET AssignedMember = (select team_members.employeeId from team_members 
								  join employees on employees.id = team_members.EmployeeId
								  join employees_tasks on employees_tasks.EmployeeId = team_members.EmployeeId 
								  where teamId = TeamId_param and taskId = current_taskId LIMIT 1); 
			IF AssignedMember = 0 OR AssignedMember is null THEN # if first team member doesn't have the task in the on call team
				SET AssignedMember = (select team_members.employeeId from team_members where teamId = TeamId_param LIMIT 1);
			END IF;
            
        ELSE 
			SET AssignedMember = (select team_members.employeeId from team_members 
								  join employees on employees.id = team_members.EmployeeId
								  join employees_tasks on employees_tasks.EmployeeId = team_members.EmployeeId 
								  where teamId = TeamId_param and taskId = current_taskId and employees.id <> AssignedMember LIMIT 1); 
			SET Rate = (select HourlyRate from employees where id = AssignedMember);      
            IF Rate = 0 or AssignedMember is null THEN
				SET AssignedMember = (select team_members.employeeId from team_members 
									  join employees on employees.id = team_members.EmployeeId
									  join employees_tasks on employees_tasks.EmployeeId = team_members.EmployeeId 
									  where teamId = TeamId_param and taskId = current_taskId LIMIT 1); 
				IF AssignedMember = 0 OR AssignedMember is null THEN # if first team member doesn't have the skill, set second team member for the task
					SET AssignedMember = (select team_members.employeeId from team_members where teamId = TeamId_param LIMIT 1,1);
				END IF;
			END IF;
        END IF;
        
        SET Rate = (select HourlyRate from employees where id = AssignedMember);        
        SET DurationPerTask = (select cast(duration as decimal(13,2)) from tasks where id = current_taskId);
        
        IF IsOnSite = true THEN
			SET DurationPerTask = DurationPerTask + 60.00;
        END IF;
        
        
        SET OperatingCost_param = Rate * (DurationPerTask/60.00);
        if TaskIndex = 2 then
        select OperatingCost_param;
        end if;
		SET OperatingRevenue_param = OperatingCost_param * 4.00;
        
        # insert current task id into job_tasks table        
        INSERT INTO job_tasks(TaskId, JobId, OperatingCost, OperatingRevenue)
		VALUES
			(current_taskId, Id_out, OperatingCost_param, OperatingRevenue_param);
        
		IF TaskIndex % 2 = 0 THEN
			SET AssignedMember = 0;
		END IF;
		SET TaskIndex = TaskIndex + 1;
		
        IF end_loop = 0 THEN
            SET tasks_id_array_local = substring(tasks_id_array_local, comma_pos + 1);
            SET comma_pos = locate(',', tasks_id_array_local);
        END IF;
        
        UNTIL end_loop = 1
		END REPEAT;
	COMMIT;
END ;;
DELIMITER ;

DELIMITER ;;
CREATE PROCEDURE `InsertEmployee`(
  IN FirstName_param VARCHAR(50),
  IN LastName_param VARCHAR(50),
  IN SIN_param VARCHAR(11),
  IN HourlyRate_param DECIMAL(13,2),
  OUT Id_out INT
)
BEGIN
	INSERT INTO employees(FirstName, LastName, SIN, HourlyRate, IsDeleted, CreatedAt)
		VALUES(FirstName_param, LastName_param, SIN_param, HourlyRate_param, 0, CURRENT_TIMESTAMP());
		
    SET Id_out = LAST_INSERT_ID();
END ;;
DELIMITER ;

DELIMITER ;;
CREATE PROCEDURE `InsertJob`(
IN TeamId_param INT,
IN ClientName_param NVARCHAR(255),
IN Description_param NVARCHAR(255),
IN Start_param datetime,
IN Tasks_id_array VARCHAR(1000),
IN IsOnSite boolean,
IN Duration_param INT,
OUT Id_out INT
)
BEGIN
	DECLARE EndTime datetime;
	# variables for insert task_jobs
    DECLARE tasks_id_array_local VARCHAR(1000);
    DECLARE start_pos SMALLINT;
    DECLARE comma_pos SMALLINT;
    DECLARE current_taskId VARCHAR(1000);
    DECLARE end_loop TINYINT;
    DECLARE TaskIndex INT;
    DECLARE AssignedMember INT; # Employee ID
    DECLARE Rate DECIMAL(13,2); # Employee hourly rate
    DECLARE OperatingCost_param DECIMAL(13,2);
    DECLARE OperatingRevenue_param DECIMAL(13,2);
    DECLARE DurationPerTask DECIMAL(13,2);
	DECLARE exit handler FOR SQLEXCEPTION, SQLWARNING
	  BEGIN
		ROLLBACK;
		RESIGNAL;
	  END;

	START TRANSACTION; 
        # if the job is on site, add 30 minutes for start and end time
        IF IsOnSite = true THEN
			SET Start_param = subtime(Start_param, '00:30:00');
		END IF;
        
        SET EndTime = addtime(Start_param, SEC_TO_TIME(Duration_param * 60));
        
		INSERT INTO jobs(TeamId, Description, ClientName, Start, End)
		VALUES(TeamId_param, Description_param, ClientName_param, Start_param, EndTime);
		
        # set job id
		SET Id_out = LAST_INSERT_ID();
        
        SET tasks_id_array_local = Tasks_id_array;
		SET start_pos = 1;
		SET comma_pos = locate(',', tasks_id_array_local);
        SET TaskIndex = 1;
        SET AssignedMember = 0;
        
        REPEAT
		#SET Rate = 0;
        
        IF comma_pos > 0 THEN
            SET current_taskId = substring(tasks_id_array_local, start_pos, comma_pos - start_pos);
            SET end_loop = 0;
        ELSE
            SET current_taskId = substring(tasks_id_array_local, start_pos);
            SET end_loop = 1;
        END IF;
        
        # calculate cost and revenue
        IF AssignedMember = 0 THEN
			SET AssignedMember = (select team_members.employeeId from team_members 
								  left join employees on employees.id = team_members.EmployeeId
								  left join employees_tasks on employees_tasks.EmployeeId = team_members.EmployeeId 
								  where teamId = TeamId_param and taskId = current_taskId LIMIT 1); 
        ELSE 
			SET AssignedMember = (select team_members.employeeId from team_members 
								  left join employees on employees.id = team_members.EmployeeId
								  left join employees_tasks on employees_tasks.EmployeeId = team_members.EmployeeId 
								  where teamId = TeamId_param and taskId = current_taskId and employees.id <> AssignedMember LIMIT 1); 
		
            IF Rate = 0 THEN
				SET AssignedMember = (select team_members.employeeId from team_members 
									  left join employees on employees.id = team_members.EmployeeId
									  left join employees_tasks on employees_tasks.EmployeeId = team_members.EmployeeId 
									  where teamId = TeamId_param and taskId = current_taskId LIMIT 1); 
			END IF;
        END IF;
        
        SET Rate = (select HourlyRate from employees where id = AssignedMember);
        SET DurationPerTask = (select cast(duration as decimal(13,2)) from tasks where id = current_taskId);
        
        IF IsOnSite = true THEN
			SET DurationPerTask = DurationPerTask + 60.0;
        END IF;
        
        SET OperatingCost_param = Rate * (DurationPerTask/60);
        SET OperatingRevenue_param = OperatingCost_param * 3;
        
        # insert current task id into job_tasks table        
        INSERT INTO job_tasks(TaskId, JobId, OperatingCost, OperatingRevenue)
		VALUES
			(current_taskId, Id_out, OperatingCost_param, OperatingRevenue_param);
        
		IF TaskIndex % 2 = 0 THEN
			SET AssignedMember = 0;
		END IF;
 
		SET TaskIndex = TaskIndex + 1;
 
        IF end_loop = 0 THEN
            SET tasks_id_array_local = substring(tasks_id_array_local, comma_pos + 1);
            SET comma_pos = locate(',', tasks_id_array_local);
        END IF;
        
        UNTIL end_loop = 1
		END REPEAT;
		
	COMMIT;
END ;;
DELIMITER ;

DELIMITER ;;
CREATE PROCEDURE `InsertTask`(
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

DELIMITER ;;
CREATE PROCEDURE `InsertTeam`(
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

DELIMITER ;;
CREATE PROCEDURE `RemoveEmployeeSkill`(
IN Employee_id_param INT,
IN Task_id_param INT
)
BEGIN
	DELETE FROM employees_tasks
		WHERE 
			EmployeeId = Employee_id_param AND 
            TaskId = Task_id_param;
END ;;
DELIMITER ;

DELIMITER ;;
CREATE PROCEDURE `RetrieveTasks`(
	IN Id_param INT
)
BEGIN
	
    SELECT Id, Name, Description, Duration FROM Tasks
    WHERE (Id_param IS NULL OR Id = Id_param)
    ORDER BY CreatedAt;
    
END ;;
DELIMITER ;

DELIMITER ;;
CREATE PROCEDURE `RetrieveTeams`(
IN Id_param INT
)
BEGIN
	SELECT teams.id, teams.Name, teams.isOnCall, teams.isDeleted, teams.CreatedAt, teams.UpdatedAt, teams.DeletedAt,
			GROUP_CONCAT(CONCAT(employees.firstName, ' ' , employees.lastName) Separator ', ') as teamMember FROM teams
	INNER JOIN team_members
		ON team_members.TeamId = teams.Id
	INNER JOIN employees
		ON team_members.EmployeeId = employees.Id
	WHERE
	(Id_param IS NULL OR teams.Id = Id_param)
	GROUP BY teams.id
	ORDER BY teams.id;
END ;;
DELIMITER ;

DELIMITER ;;
CREATE PROCEDURE `SearchEmployees`(
IN keyword_param VARCHAR(50)
)
BEGIN
    SELECT DISTINCT * FROM employees 
        WHERE firstName LIKE CONCAT ('%', keyword_param, '%') OR
            lastName LIKE CONCAT ('%', keyword_param, '%') OR 
            SIN LIKE CONCAT ('%', keyword_param, '%');
END ;;
DELIMITER ;

DELIMITER ;;
CREATE PROCEDURE `SelectAvailableTeamList`(
IN Start_param datetime,
IN Tasks_id_array VARCHAR(1000),
IN IsOnSite boolean)
BEGIN
	DECLARE EndTime_param datetime;
	DECLARE tasks_id_array_local VARCHAR(1000);
    DECLARE start_pos SMALLINT;
    DECLARE comma_pos SMALLINT;
    DECLARE current_taskId VARCHAR(1000);
    DECLARE end_loop TINYINT;
    DECLARE Rate DECIMAL;
    DECLARE TaskIndex INT;
    DECLARE TeamNum INT DEFAULT 0;
    DECLARE TeamIndex INT DEFAULT 0;
    DECLARE current_TeamId INT;
    DECLARE AssignedMember INT; # Employee ID
    DECLARE Duration_Temp INT;
  
	IF IsOnSite = true THEN
		SET Start_param = subtime(Start_param, '00:30:00');
	END IF;
	
	#filter teams based on Tasks
	drop TABLE if exists TempTable;        
	create temporary table TempTable (teamid INT, teamName varchar(255), totalDuration INT, tasks varchar(1000), StartDate datetime, EndDate datetime);
	insert into TempTable 
	select DISTINCT id, name, 0, group_concat(DISTINCT(employees_tasks.taskId) Separator ',') as tasks, Start_param, '1000-01-01 00:00:00' from teams 
	join team_members on teams.id = team_members.TeamId 
	join employees_tasks on team_members.employeeId = employees_tasks.employeeId
	where FIND_IN_SET(employees_tasks.taskId, Tasks_id_array) and teams.isOnCall = 0 and teams.isDeleted = 0
	group by teams.id
	having tasks like concat('%',Tasks_id_array,'%');        
  
	select COUNT(*) from TempTable INTO TeamNum;
	SET TeamIndex = 0;
	
	WHILE TeamIndex < TeamNum DO
	
		SET tasks_id_array_local = Tasks_id_array;
		SET start_pos = 1;
		SET comma_pos = locate(',', tasks_id_array_local);
		SET TaskIndex = 1;
		SET AssignedMember = 0;
		SET Duration_Temp = 0;
		SET current_TeamId = (SELECT teamid from TempTable LIMIT TeamIndex, 1);
		
		REPEAT
			IF comma_pos > 0 THEN
				SET current_taskId = substring(tasks_id_array_local, start_pos, comma_pos - start_pos);
				SET end_loop = 0;
			ELSE
				SET current_taskId = substring(tasks_id_array_local, start_pos);
				SET end_loop = 1;
			END IF;
			
			# calculate cost and revenue
			IF AssignedMember = 0 THEN # assigned task to first team member who has the skill
				SET AssignedMember = (select team_members.employeeId from team_members 
									  join employees on employees.id = team_members.EmployeeId
									  join employees_tasks on employees_tasks.EmployeeId = team_members.EmployeeId 
									  where teamId = current_TeamId and taskId = current_taskId LIMIT 1); 
				
				SET Duration_Temp = Duration_Temp + (select duration from tasks where id = current_taskId);
				
			ELSE # assinged task to another team member(parallel work)
				SET AssignedMember = (select team_members.employeeId from team_members 
									  join employees on employees.id = team_members.EmployeeId
									  join employees_tasks on employees_tasks.EmployeeId = team_members.EmployeeId 
									  where teamId = current_TeamId and taskId = current_taskId and employees.id <> AssignedMember LIMIT 1); 
			
				IF Rate = 0 THEN # if another team member doesn't have the skill, assigned the task to first team member and add duration
					SET AssignedMember = (select team_members.employeeId from team_members 
										  join employees on employees.id = team_members.EmployeeId
										  join employees_tasks on employees_tasks.EmployeeId = team_members.EmployeeId 
										  where teamId = current_TeamId and taskId = current_taskId LIMIT 1); 
										  
					SET Duration_Temp = Duration_Temp + (select duration from tasks where id = current_taskId);
					
				ELSE # if another team member take next tasks, set total duration as the duration time if the duration time is more than total duration
					IF Duration_Temp < (select duration from tasks where id = current_taskId) THEN
						SET Duration_Temp = (select duration from tasks where id = current_taskId);
					END IF;
				END IF;
			END IF;
			
			SET Rate = (select HourlyRate from employees where id = AssignedMember);
			SET TaskIndex = TaskIndex + 1;
	 
			IF end_loop = 0 THEN
				SET tasks_id_array_local = substring(tasks_id_array_local, comma_pos + 1);
				SET comma_pos = locate(',', tasks_id_array_local);
			END IF;
			
			UNTIL end_loop = 1
		END REPEAT;        
		
		SET SQL_SAFE_UPDATES=0;
		IF IsOnSite = true THEN
			SET Duration_Temp = Duration_Temp + 60;
		END IF;
		
		SET EndTime_param = addtime(Start_param, SEC_TO_TIME(Duration_Temp * 60));
		UPDATE TempTable SET totalDuration = Duration_Temp, EndDate = EndTime_param where teamid = current_TeamId;
		
		SET TeamIndex = TeamIndex + 1;
		
	END WHILE;
		
	select DISTINCT TempTable.TeamId, TeamName, totalDuration, StartDate, EndDate from TempTable 
	left join jobs on TempTable.TeamId = jobs.TeamId
	where TempTable.TeamId 
						NOT in (select jobs.TeamId from jobs where Start between Start_param and EndDate OR End between Start_param and EndDate)
						AND
						(TIME(TempTable.StartDate) > '08:00:00' and TIME(TempTable.EndDate) < '17:00:00');
		
END ;;
DELIMITER ;

DELIMITER ;;
CREATE PROCEDURE `SelecTeamByJobTeamId`(
 IN JobId_param INT
)
BEGIN
	SELECT teams.id, teams.Name, employees.id as employeeId, employees.firstName, employees.lastName FROM teams
		INNER JOIN team_members
			ON team_members.TeamId = teams.Id
		INNER JOIN employees
			ON team_members.EmployeeId = employees.Id
		INNER JOIN jobs
			ON jobs.teamId = team_members.TeamId
		WHERE jobs.id = JobId_param;
END ;;
DELIMITER ;

DELIMITER ;;
CREATE PROCEDURE `SelectEmergencyTeam`(
IN Start_param datetime,
IN Tasks_id_array VARCHAR(1000),
IN IsOnSite boolean)
BEGIN
	DECLARE EndTime_param datetime;
	DECLARE tasks_id_array_local VARCHAR(1000);
    DECLARE start_pos SMALLINT;
    DECLARE comma_pos SMALLINT;
    DECLARE current_taskId VARCHAR(1000);
    DECLARE end_loop TINYINT;
    DECLARE AssignedMember INT; # Employee ID
    DECLARE current_TeamId INT;
    DECLARE TaskIndex INT;
    DECLARE Rate DECIMAL;
    DECLARE Duration_Temp INT;
    
    IF IsOnSite = 1 THEN
		SET Start_param = subtime(Start_param, '00:30:00');
	END IF;
    
    drop TABLE if exists TempTable;        
	create temporary table TempTable (teamid INT, teamName varchar(255) , totalDuration INT, tasks varchar(1000), StartDate datetime, EndDate datetime);
	insert into TempTable SELECT Id, Name, 0, group_concat(DISTINCT(employees_tasks.taskId) Separator ',') as tasks, Start_param, '1000-01-01 00:00:00' from teams 
	join team_members on teams.id = team_members.TeamId 
	join employees_tasks on team_members.employeeId = employees_tasks.employeeId
    where IsOnCall = 1;
    
    SET tasks_id_array_local = Tasks_id_array;
	SET start_pos = 1;
	SET comma_pos = locate(',', tasks_id_array_local);
	SET AssignedMember = 0;
	SET Duration_Temp = 0;
	SET current_TeamId = (SELECT teamid from TempTable LIMIT 1);
	SET TaskIndex = 1;
    
	REPEAT
		IF comma_pos > 0 THEN
			SET current_taskId = substring(tasks_id_array_local, start_pos, comma_pos - start_pos);
			SET end_loop = 0;
		ELSE
			SET current_taskId = substring(tasks_id_array_local, start_pos);
			SET end_loop = 1;
		END IF;
		
		# calculate cost and revenue
		IF AssignedMember = 0 THEN # assigned task to first team member who has the skill
			SET AssignedMember = (select team_members.employeeId from team_members 
								  join employees on employees.id = team_members.EmployeeId
								  join employees_tasks on employees_tasks.EmployeeId = team_members.EmployeeId 
								  where teamId = current_TeamId and taskId = current_taskId LIMIT 1); 
			
            IF AssignedMember = 0 THEN # if first team member doesn't have the task in the on call team
				SET AssignedMember = (select team_members.employeeId from team_members 
									  join TempTable on team_members.TeamId = TempTable.TeamId LIMIT 1);
			END IF;
            
			SET Duration_Temp = Duration_Temp + (select duration from tasks where id = current_taskId);
			
		ELSE # assinged task to another team member(parallel work)
			SET AssignedMember = (select team_members.employeeId from team_members 
								  join employees on employees.id = team_members.EmployeeId
								  join employees_tasks on employees_tasks.EmployeeId = team_members.EmployeeId 
								  where teamId = current_TeamId and taskId = current_taskId and employees.id <> AssignedMember); 
			SET Rate = (select HourlyRate from employees where id = AssignedMember);
			 IF Rate = 0 THEN # if second team member doesn't have the skill, check the first team member has the skill
				SET AssignedMember = (select team_members.employeeId from team_members 
									  join employees on employees.id = team_members.EmployeeId
									  join employees_tasks on employees_tasks.EmployeeId = team_members.EmployeeId 
									  where teamId = current_TeamId and taskId = current_taskId LIMIT 1);
                
                IF AssignedMember = 0 THEN # if first team member doesn't have the skill, set second team member for the task
					SET AssignedMember = (select team_members.employeeId from team_members 
										  join TempTable on team_members.TeamId = TempTable.TeamId LIMIT 1, 1);
					IF Duration_Temp < (select duration from tasks where id = current_taskId) THEN
						SET Duration_Temp = (select duration from tasks where id = current_taskId);
					END IF;
				ELSE 
					SET Duration_Temp = Duration_Temp + (select duration from tasks where id = current_taskId);
				END IF;
			ELSE 
				IF Duration_Temp < (select duration from tasks where id = current_taskId) THEN
					SET Duration_Temp = (select duration from tasks where id = current_taskId);
				END IF;
			END IF;
		END IF;
		
        SET Rate = (select HourlyRate from employees where id = AssignedMember);
        
        IF TaskIndex % 2 = 0 THEN
			SET AssignedMember = 0;
        END IF;
        
        SET TaskIndex = TaskIndex + 1;
        
		IF end_loop = 0 THEN
			SET tasks_id_array_local = substring(tasks_id_array_local, comma_pos + 1);
			SET comma_pos = locate(',', tasks_id_array_local);
		END IF;
		
		UNTIL end_loop = 1
	END REPEAT;        
	
	SET SQL_SAFE_UPDATES=0;
	IF IsOnSite = 1 THEN
		SET Duration_Temp = Duration_Temp + 60;
	END IF;
	
	SET EndTime_param = addtime(Start_param, SEC_TO_TIME(Duration_Temp * 60));
	UPDATE TempTable SET totalDuration = Duration_Temp, EndDate = EndTime_param order by teamid LIMIT 1;
		
    select * from TempTable;
    
END ;;
DELIMITER ;

DELIMITER ;;
CREATE PROCEDURE `SelectEmployees`(IN Id_param INT)
BEGIN
SELECT * FROM employees
    WHERE
    (Id_param IS NULL OR  employees.id = Id_param)
    ORDER BY  employees.CreatedAt;
END ;;
DELIMITER ;

DELIMITER ;;
CREATE PROCEDURE `SelectEmployeesByTeamId`(
	IN Id_param INT
)
BEGIN
	SELECT Id, CONCAT(FirstName, ' ', lastName) as FullName FROM Employees
    INNER JOIN team_members on team_members.employeeId = Employees.id
    WHERE team_members.teamId = Id_param;
END ;;
DELIMITER ;

DELIMITER ;;
CREATE PROCEDURE `SelectEmployeesNotInTeam`()
BEGIN
	SELECT id, CONCAT(firstName, ' ', LastName) AS FullName FROM employees 
    WHERE id NOT IN (SELECT employeeId FROM team_members);
END ;;
DELIMITER ;

DELIMITER ;;
CREATE PROCEDURE `SelectJobByTaskId`(
IN EmployeedId_param INT,
IN TaskId_param INT)
BEGIN
	SELECT jobs.id FROM jobs 
	join job_tasks on jobs.id = job_tasks.jobId
    join team_members on team_members.teamId = jobs.teamId
    join employees on employees.id = team_members.employeeId
	where jobs.start >= current_date() and job_tasks.Taskid = TaskId_param and employees.id = EmployeedId_param;
END ;;
DELIMITER ;

DELIMITER ;;
CREATE PROCEDURE `SelectJobs`(
	IN Id_param INT,
    IN Date_param VARCHAR(10)
)
BEGIN
	IF Date_param IS NULL THEN
		select jobs.Id, jobs.TeamId, teams.name as TeamName, jobs.ClientName, jobs.Description, jobs.Start, jobs.End, sum(OperatingCost) as Cost, sum(OperatingRevenue) as Revenue, 
		group_concat(tasks.name separator ', ') as tasks from jobs
		join job_tasks on job_tasks.JobId = jobs.Id
		join tasks on job_tasks.taskId = tasks.id
		join teams on teams.id = jobs.teamId
		where (Id_param IS NULL OR jobs.Id = Id_param)
		group by jobs.id
        order by jobs.start;
    ELSE 
		select jobs.Id, jobs.TeamId, teams.name as TeamName, jobs.ClientName, jobs.Description, jobs.Start, jobs.End, sum(OperatingCost) as Cost, sum(OperatingRevenue) as Revenue, 
		group_concat(tasks.name separator ', ') as tasks from jobs
		join job_tasks on job_tasks.JobId = jobs.Id
		join tasks on job_tasks.taskId = tasks.id
		join teams on teams.id = jobs.teamId
		where jobs.start between concat(Date_param, ' ', '00:00:00') and concat(Date_param, ' ', '23:59:59')
		group by jobs.id
        order by jobs.start;
	END IF;
END ;;
DELIMITER ;

DELIMITER ;;
CREATE PROCEDURE `SelectJobsByMonth`(
IN Month_param VARCHAR(10),
IN Year_param VARCHAR(10)
)
BEGIN
    select jobs.Id, jobs.TeamId, teams.name as TeamName, jobs.ClientName, jobs.Description, jobs.Start, jobs.End, sum(OperatingCost) as Cost, sum(OperatingRevenue) as Revenue, 
        group_concat(tasks.name separator ', ') as tasks from jobs
        join job_tasks on job_tasks.JobId = jobs.Id
        join tasks on job_tasks.taskId = tasks.id
        join teams on teams.id = jobs.teamId
        where (Month_param IS NULL OR MONTH(jobs.start) = Month_param)
            AND YEAR(jobs.start) = Year_param
            AND jobs.End <= current_timestamp()
        group by jobs.id
        order by jobs.start;
END ;;
DELIMITER ;

DELIMITER ;;
CREATE PROCEDURE `SelectOnCallTeam`(
)
BEGIN
	SELECT teams.id, teams.Name, GROUP_CONCAT(CONCAT(employees.firstName, ' ' , employees.lastName) Separator ', ') as teamMember FROM Teams 
    INNER JOIN team_members
		ON team_members.TeamId = teams.Id
	INNER JOIN employees
		ON team_members.EmployeeId = employees.Id
	WHERE IsOnCall = 1;
END ;;
DELIMITER ;

DELIMITER ;;
CREATE PROCEDURE `SelectTasks`(IN Id_param INT)
BEGIN
SELECT tasks.id, Name FROM tasks
		INNER JOIN employees_tasks
			ON employees_tasks.TaskId = tasks.Id
		INNER JOIN employees
			ON employees_tasks.EmployeeId = employees.Id
    WHERE
    (Id_param IS NULL OR employees.Id = Id_param)
	ORDER BY Name;
END ;;
DELIMITER ;

DELIMITER ;;
CREATE PROCEDURE `SelectTeams`(IN Id_param INT)
BEGIN
	SELECT Name FROM teams
		INNER JOIN team_members
			ON team_members.TeamId = teams.Id
		INNER JOIN employees
			ON team_members.EmployeeId = employees.Id
    WHERE
    (Id_param IS NULL OR employees.Id = Id_param)
    ORDER BY Name;
END ;;
DELIMITER ;

DELIMITER ;;
CREATE PROCEDURE `UpdateEmployee`(
IN Id_param INT,
IN FirstName_param VARCHAR(50),
IN LastName_param VARCHAR(50),
IN SIN_param VARCHAR(11),
IN HourlyRate_param DECIMAL(13,2)
)
BEGIN

    UPDATE employees 
    SET
    FirstName = IF(FirstName_param IS NULL,FirstName,FirstName_param),
    LastName = IF(LastName_param IS NULL,LastName,LastName_param),
    SIN = IF(SIN_param IS NULL,SIN,SIN_param ),
    HourlyRate = IF(HourlyRate_param IS NULL,HourlyRate,HourlyRate_param),
    UpdatedAt = current_timestamp()
    WHERE Id = Id_param;

END ;;
DELIMITER ;

DELIMITER ;;
CREATE PROCEDURE `UpdateIsOnCallTeam`(
	IN Id_param INT,
    IN IsOnCall_param BOOLEAN,
    OUT out_param VARCHAR(255)
)
BEGIN
	IF IsOnCall_param = TRUE THEN
		IF (SELECT COUNT(*) FROM Teams WHERE isOnCall = 1 AND Id <> Id_param) > 0 THEN
			SET out_param = (SELECT name FROM Teams WHERE isOnCall = 1);
		ELSE 
			UPDATE `ats2021hotel`.`teams`
				SET
				`IsOnCall` = 1,
				`UpdatedAt` = CURRENT_TIMESTAMP()
				WHERE `Id` = Id_param;
        END IF;
    ELSE
		UPDATE `ats2021hotel`.`teams`
			SET
			`IsOnCall` = 0,
			`UpdatedAt` = CURRENT_TIMESTAMP()
			WHERE `Id` = Id_param;    
    END IF;
END ;;
DELIMITER ;

DELIMITER ;;
CREATE PROCEDURE `UpdateTask`(
IN Id_param INT,
IN TaskName_param NVARCHAR(255),
IN TaskDescription_param NVARCHAR(255),
IN TaskDuration_param INT
)
BEGIN
	UPDATE tasks 
    SET
    Name = IF(TaskName_param IS NULL,Name,TaskName_param),
    Description = IF(TaskDescription_param IS NULL,Description,TaskDescription_param),
    Duration = IF(TaskDuration_param IS NULL,Duration,TaskDuration_param),
    UpdatedAt = current_timestamp()
    WHERE Id = Id_param;
END ;;
DELIMITER ;

-- Dump completed on 2021-04-16 18:34:48
