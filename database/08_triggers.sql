USE LibraryManagementSystem;

DELIMITER $$

CREATE TRIGGER after_loan_insert
AFTER INSERT ON loans
FOR EACH ROW
BEGIN
    UPDATE book_copies
    SET availability_status = 'Issued'
    WHERE copy_id = NEW.copy_id;
END$$

DELIMITER ;