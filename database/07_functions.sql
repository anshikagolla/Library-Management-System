USE LibraryManagementSystem;

DELIMITER $$

CREATE FUNCTION calculate_fine(p_loan_id INT)
RETURNS DECIMAL(10,2)
DETERMINISTIC
BEGIN
    DECLARE v_due_date DATE;
    DECLARE v_return_date DATE;
    DECLARE v_days_late INT;
    DECLARE v_fine DECIMAL(10,2);

    SELECT due_date, return_date
    INTO v_due_date, v_return_date
    FROM loans
    WHERE loan_id = p_loan_id;

    IF v_return_date IS NULL THEN
        SET v_return_date = CURDATE();
    END IF;

    SET v_days_late = DATEDIFF(v_return_date, v_due_date);

    IF v_days_late > 0 THEN
        SET v_fine = v_days_late * 10;
    ELSE
        SET v_fine = 0;
    END IF;

    RETURN v_fine;
END$$

DELIMITER ;