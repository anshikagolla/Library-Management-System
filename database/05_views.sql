USE LibraryManagementSystem;


-- VIEW 1: Display books with their category and publisher names
CREATE VIEW book_catalog AS
SELECT
    b.book_id,
    b.title,
    c.category_name,
    p.publisher_name,
    b.publication_year,
    b.price
FROM books b
INNER JOIN categories c
ON b.category_id = c.category_id
INNER JOIN publishers p
ON b.publisher_id = p.publisher_id;


-- VIEW 2: Display member loan details
CREATE VIEW member_loan_details AS
SELECT
    m.member_id,
    m.member_name,
    l.loan_id,
    l.issue_date,
    l.due_date,
    l.return_date,
    l.loan_status
FROM members m
INNER JOIN loans l
ON m.member_id = l.member_id;


-- VIEW 3: Display unpaid fines
CREATE VIEW unpaid_fines AS
SELECT
    f.fine_id,
    f.loan_id,
    m.member_name,
    f.fine_amount,
    f.payment_status,
    f.fine_date
FROM fines f
INNER JOIN loans l
ON f.loan_id = l.loan_id
INNER JOIN members m
ON l.member_id = m.member_id
WHERE f.payment_status = 'Unpaid';




-- Check View 1
SELECT * FROM book_catalog;

-- Check View 2
SELECT * FROM member_loan_details;

-- Check View 3
SELECT * FROM unpaid_fines;