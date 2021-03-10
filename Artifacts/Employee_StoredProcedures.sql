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
