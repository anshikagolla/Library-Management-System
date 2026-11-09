

USE LibraryManagementSystem;

DELIMITER $$

-- PROCEDURE 1: Issue a book to a member
-- Checks member, staff and book availability before issuing.

DROP PROCEDURE IF EXISTS issue_book$$

CREATE PROCEDURE issue_book(
    IN p_member_id INT,
    IN p_copy_id INT,
    IN p_staff_id INT,
    IN p_due_date DATE
)
BEGIN
    DECLARE v_available INT DEFAULT 0;

    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
        RESIGNAL;
    END;

    START TRANSACTION;

    IF NOT EXISTS (
        SELECT 1 FROM members
        WHERE member_id = p_member_id
        AND status = 'Active'
    ) THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Member does not exist or is inactive';
    END IF;

    IF NOT EXISTS (
        SELECT 1 FROM staff
        WHERE staff_id = p_staff_id
    ) THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Staff member does not exist';
    END IF;

    IF p_due_date < CURDATE() THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Due date cannot be in the past';
    END IF;

    UPDATE book_copies
    SET availability_status = 'Issued'
    WHERE copy_id = p_copy_id
    AND availability_status = 'Available';

    SET v_available = ROW_COUNT();

    IF v_available = 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Book copy does not exist or is unavailable';
    END IF;

    INSERT INTO loans (
        member_id, copy_id, staff_id,
        issue_date, due_date, loan_status
    )
    VALUES (
        p_member_id, p_copy_id, p_staff_id,
        CURDATE(), p_due_date, 'Issued'
    );

    COMMIT;
END$$


-- PROCEDURE 2: Return a borrowed book
-- Updates loan details and book availability.

DROP PROCEDURE IF EXISTS return_book$$

CREATE PROCEDURE return_book(
    IN p_loan_id INT
)
BEGIN
    DECLARE v_copy_id INT;

    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
        RESIGNAL;
    END;

    START TRANSACTION;

    IF NOT EXISTS (
        SELECT 1 FROM loans
        WHERE loan_id = p_loan_id
        AND return_date IS NULL
    ) THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Invalid loan or book already returned';
    END IF;

    SELECT copy_id INTO v_copy_id
    FROM loans
    WHERE loan_id = p_loan_id
    FOR UPDATE;

    UPDATE loans
    SET return_date = CURDATE(),
        loan_status = 'Returned'
    WHERE loan_id = p_loan_id;

    UPDATE book_copies
    SET availability_status = 'Available'
    WHERE copy_id = v_copy_id;

    COMMIT;
END$$


-- PROCEDURE 3: Display member loan history
-- Shows all books borrowed by a particular member.

DROP PROCEDURE IF EXISTS member_loan_history$$

CREATE PROCEDURE member_loan_history(
    IN p_member_id INT
)
BEGIN
    SELECT
        m.member_id,
        m.member_name,
        l.loan_id,
        b.title,
        l.issue_date,
        l.due_date,
        l.return_date,
        l.loan_status
    FROM members m
    INNER JOIN loans l
        ON m.member_id = l.member_id
    INNER JOIN book_copies bc
        ON l.copy_id = bc.copy_id
    INNER JOIN books b
        ON bc.book_id = b.book_id
    WHERE m.member_id = p_member_id
    ORDER BY l.issue_date DESC;
END$$

DELIMITER ;


-- transaction queries(anvance query)

-- Example 1: COMMIT
-- Purpose: Save changes permanently.

START TRANSACTION;

UPDATE members
SET member_name = member_name
WHERE member_id = 1;

COMMIT;


-- Example 2: ROLLBACK
-- Purpose: Cancel changes made in a transaction.

START TRANSACTION;

UPDATE members
SET status = 'Inactive'
WHERE member_id = 1;

ROLLBACK;


-- Example 3: SAVEPOINT
-- Purpose: Roll back to a particular point in a transaction.

START TRANSACTION;

UPDATE members
SET status = 'Inactive'
WHERE member_id = 2;

SAVEPOINT member_update;

UPDATE members
SET status = 'Inactive'
WHERE member_id = 3;

ROLLBACK TO SAVEPOINT member_update;

ROLLBACK;


-- Cursor Procedure: generate_member_loan_summary

DELIMITER $$

CREATE PROCEDURE generate_member_loan_summary()
BEGIN
    DECLARE v_member_id INT;
    DECLARE v_member_name VARCHAR(100);
    DECLARE v_total_loans INT;
    DECLARE finished INT DEFAULT 0;

    -- Declare cursor to retrieve all members
    DECLARE member_cursor CURSOR FOR
        SELECT member_id, member_name
        FROM members;

    -- Handler to identify when all rows are processed
    DECLARE CONTINUE HANDLER FOR NOT FOUND
        SET finished = 1;

    -- Temporary table to store the summary
    CREATE TEMPORARY TABLE IF NOT EXISTS member_loan_summary (
        member_id INT,
        member_name VARCHAR(100),
        total_loans INT
    );

    TRUNCATE TABLE member_loan_summary;

    OPEN member_cursor;

    read_members: LOOP

        FETCH member_cursor
        INTO v_member_id, v_member_name;

        IF finished = 1 THEN
            LEAVE read_members;
        END IF;

        SELECT COUNT(*)
        INTO v_total_loans
        FROM loans
        WHERE member_id = v_member_id;

        INSERT INTO member_loan_summary
        VALUES (v_member_id, v_member_name, v_total_loans);

    END LOOP;

    CLOSE member_cursor;

    -- Display the final summary
    SELECT *
    FROM member_loan_summary
    ORDER BY member_id;

    DROP TEMPORARY TABLE member_loan_summary;

END$$

DELIMITER ;