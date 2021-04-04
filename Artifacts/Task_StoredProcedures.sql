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
DROP PROCEDURE IF EXISTS SelectTasks;
// DELIMITER;

CREATE PROCEDURE `SelectTasks`(IN Id_param INT)
BEGIN
SELECT tasks.Id, Name FROM tasks
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

DELIMITER //
DROP PROCEDURE IF EXISTS DeleteEmployee
// DELIMITER;

DELIMITER //
CREATE PROCEDURE DeleteTask (
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
END//
DELIMITER;

DELIMITER //
DROP PROCEDURE IF EXISTS AddEmployeeSkill;
// DELIMITER;

CREATE PROCEDURE `AddEmployeeSkill` (
IN Employee_id_param INT,
IN Task_id_param INT
)
BEGIN
	INSERT INTO employees_tasks
		(EmployeeId, TaskId)
	VALUES 
		(Employee_id_param, Task_id_param);
END$$
DELIMITER ;

DELIMITER //
DROP PROCEDURE IF EXISTS getTasksNotAssignedToEmployee;
// DELIMITER;

CREATE PROCEDURE `getTasksNotAssignedToEmployee`(IN Employee_Id_param INT)
BEGIN
	SELECT tasks.* FROM tasks 
	WHERE tasks.id NOT IN (
		SELECT taskId FROM employees_tasks
			INNER JOIN employees
				ON employees.id = employees_tasks.EmployeeId
		WHERE employees.id = Employee_Id_param
    );
END$$
DELIMITER ;

DELIMITER //
DROP PROCEDURE IF EXISTS RemoveEmployeeSkill;
// DELIMITER;

CREATE PROCEDURE `RemoveEmployeeSkill`(
IN Employee_id_param INT,
IN Task_id_param INT
)
BEGIN
	DELETE FROM employees_tasks
		WHERE 
			EmployeeId = Employee_id_param AND 
            TaskId = Task_id_param;
END$$
DELIMITER ;
