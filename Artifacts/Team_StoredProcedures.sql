DELIMITER //
DROP PROCEDURE IF EXISTS InsertTeam;
// DELIMITER;

DELIMITER //
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
END
// DELIMITER;


DELIMITER //
DROP PROCEDURE IF EXISTS selectEmployeesNotInTeam;
// DELIMITER;

DELIMITER //
CREATE PROCEDURE `selectEmployeesNotInTeam`()
BEGIN
	SELECT id, CONCAT(firstName, ' ', LastName) AS FullName FROM employees 
    WHERE id NOT IN (SELECT employeeId FROM team_members);
END
// DELIMITER;


DELIMITER //
DROP PROCEDURE IF EXISTS UpdateIsOnCallTeam;
// DELIMITER;

DELIMITER //
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
END
// DELIMITER;

DELIMITER //
DROP PROCEDURE IF EXISTS SelectOnCallTeam;
// DELIMITER;

DELIMITER //
CREATE PROCEDURE `SelectOnCallTeam`(
)
BEGIN
	SELECT * FROM Teams WHERE IsOnCall = 1;
END