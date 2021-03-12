USE `ats2021hotel`;

DELIMITER //
DROP PROCEDURE IF EXISTS InsertEmployee;
// DELIMITER;

DELIMITER $$
CREATE PROCEDURE `InsertEmployee` (
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
END$$
DELIMITER ;

DELIMITER //
DROP PROCEDURE IF EXISTS RetrieveAllEmployees;
// DELIMITER;

DELIMITER $$
CREATE PROCEDURE `RetrieveAllEmployees` ()
BEGIN

	SELECT (Id, FirstName, LastName, SIN, HourlyRate, IsDeleted, CreatedAt, UpdatedAt, DeletedAt)
    FROM employees
    ORDER BY CreatedAt;

END$$
DELIMITER ;

DELIMITER //
DROP PROCEDURE IF EXISTS RetrieveAllEmployeeById;
// DELIMITER;

DELIMITER $$
CREATE PROCEDURE `RetrieveAllEmployeeById` (
	IN Id_param INT
)
BEGIN

	SELECT (Id, FirstName, LastName, SIN, HourlyRate, IsDeleted, CreatedAt, UpdatedAt, DeletedAt)
    FROM employees
    WHERE (Id_param IS NULL OR id = Id_param)
    ORDER BY CreatedAt;

END$$
DELIMITER ;
