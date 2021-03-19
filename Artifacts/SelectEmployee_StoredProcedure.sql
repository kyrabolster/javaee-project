DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `SelectEmployees`(
IN Id_param INT
)
BEGIN
	SELECT * FROM employees
    WHERE
    (Id_param IS NULL OR id = Id_param)
    ORDER BY CreatedDate;
END$$
DELIMITER ;