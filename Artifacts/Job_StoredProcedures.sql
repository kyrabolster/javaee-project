USE ats2021hotel;

DELIMITER //
DROP PROCEDURE IF EXISTS InsertJob
// DELIMITER;

DELIMITER //
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
    DECLARE Rate DECIMAL; # Employee hourly rate
    DECLARE OperatingCost_param DECIMAL;
    DECLARE OperatingRevenue_param DECIMAL;
    DECLARE DurationPerTask DECIMAL;
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
        ELSE 
			SET AssignedMember = (select team_members.employeeId from team_members 
								  join employees on employees.id = team_members.EmployeeId
								  join employees_tasks on employees_tasks.EmployeeId = team_members.EmployeeId 
								  where teamId = TeamId_param and taskId = current_taskId and employees.id <> AssignedMember LIMIT 1); 
		
            IF Rate = 0 THEN
				SET AssignedMember = (select team_members.employeeId from team_members 
									  join employees on employees.id = team_members.EmployeeId
									  join employees_tasks on employees_tasks.EmployeeId = team_members.EmployeeId 
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
END
DELIMITER;

DELIMITER //
DROP PROCEDURE IF EXISTS InsertEmergencyJob
// DELIMITER;

DELIMITER //
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
END
// DELIMITER;

DELIMITER //
DROP PROCEDURE IF EXISTS SelectAvailableTeamList
// DELIMITER;

DELIMITER //
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
	where FIND_IN_SET(employees_tasks.taskId, Tasks_id_array) and teams.isOnCall = 0
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
		
END

// DELIMITER;

DELIMITER //
DROP PROCEDURE IF EXISTS SelectEmergencyTeam
// DELIMITER;

DELIMITER //
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
    
END
// DELIMITER;

DELIMITER //
DROP PROCEDURE IF EXISTS SelectJobs
// DELIMITER;

DELIMITER //
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
END
// DELIMITER;

DELIMITER //
DROP PROCEDURE IF EXISTS SelecTeamByJobTeamId
// DELIMITER;

DELIMITER //
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
END
// DELIMITER;

DELIMITER //
DROP PROCEDURE IF EXISTS DeleteJob
// DELIMITER;

DELIMITER //
CREATE PROCEDURE `DeleteJob`(
	IN Id_param INT
)
BEGIN
	DELETE FROM job_tasks WHERE JobId = Id_param;
	DELETE FROM jobs WHERE id = Id_param;
END