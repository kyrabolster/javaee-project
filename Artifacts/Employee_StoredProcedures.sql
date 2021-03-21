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
DROP PROCEDURE IF EXISTS SelectEmployees;
// DELIMITER;

DELIMITER $$
CREATE PROCEDURE `SelectEmployees`(IN Id_param INT)
BEGIN
SELECT * FROM employees
    WHERE
    (Id_param IS NULL OR  employees.id = Id_param)
    ORDER BY  employees.CreatedAt;
END$$
DELIMITER ;

DELIMITER //
DROP PROCEDURE IF EXISTS SelectTasks;
// DELIMITER;

DELIMITER $$
CREATE PROCEDURE `SelectTasks`(IN Id_param INT)
BEGIN
SELECT Name FROM tasks
		INNER JOIN employees_tasks
			ON employees_tasks.TaskId = tasks.Id
		INNER JOIN employees
			ON employees_tasks.EmployeeId = employees.Id
    WHERE
    (Id_param IS NULL OR employees.Id = Id_param)
	ORDER BY Name;
END$$
DELIMITER ;

DELIMITER //
DROP PROCEDURE IF EXISTS SelectTasks;
// DELIMITER;

DELIMITER $$
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
END$$
DELIMITER ;