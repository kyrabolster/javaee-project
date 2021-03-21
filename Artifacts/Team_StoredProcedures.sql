DELIMITER $$
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
END$$
DELIMITER ;


DELIMITER $$
CREATE PROCEDURE `selectEmployeesNotInTeam`()
BEGIN
	SELECT id, CONCAT(firstName, ' ', LastName) AS FullName FROM employees 
    WHERE id NOT IN (SELECT employeeId FROM team_members);
END$$
DELIMITER ;

