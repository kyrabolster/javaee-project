USE `ats2021hotel`;

DELIMITER //
DROP PROCEDURE IF EXISTS InsertTask;
// DELIMITER;

DELIMITER $$
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

END$$
DELIMITER ;

DELIMITER //
DROP PROCEDURE IF EXISTS RetrieveTasks;
// DELIMITER;

DELIMITER $$
CREATE PROCEDURE `RetrieveTasks`(
	IN Id_param INT
)
BEGIN
	
    SELECT Id, Name, Description, Duration FROM Tasks
    WHERE (Id_param IS NULL OR Id = Id_param)
    ORDER BY CreatedAt;
    
END$$
DELIMITER ;
