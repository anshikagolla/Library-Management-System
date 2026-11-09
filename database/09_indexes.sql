USE LibraryManagementSystem;

-- Index 1: Speeds up searching books by title.
CREATE INDEX idx_book_title
ON books(title);

-- Index 2: Speeds up searching members by name.
CREATE INDEX idx_member_name
ON members(member_name);

-- Index 3: Speeds up searching loans by issue date.
CREATE INDEX idx_loan_issue_date
ON loans(issue_date);

-- Index 4: Composite index for member loan history.
CREATE INDEX idx_loan_member_date
ON loans(member_id, issue_date);

-- Index 5: Speeds up searching reservations by status.
CREATE INDEX idx_reservation_status
ON reservations(reservation_status);

SHOW INDEX FROM reservations;

SHOW INDEX FROM books;

SHOW INDEX FROM members;

SHOW INDEX FROM loans;




-- **explain queries**

-- Example 1: Explain book title search
EXPLAIN
SELECT *
FROM books
WHERE title = 'The Alchemist';

-- Example 2: Explain member name search
EXPLAIN
SELECT *
FROM members
WHERE member_name = 'Arun Kumar';

-- Example 3: Explain loan history using composite index
EXPLAIN
SELECT *
FROM loans
WHERE member_id = 1
ORDER BY issue_date DESC;

-- Example 4: Explain reservation status search
EXPLAIN
SELECT *
FROM reservations
WHERE reservation_status = 'Pending';