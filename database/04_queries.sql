-- basic queries
USE LibraryManagementSystem;

-- QUERY 1: Display all books
SELECT * FROM books;


-- QUERY 2: Display all library members
SELECT * FROM members;


-- QUERY 3: Display only book titles and prices
SELECT title, price
FROM books;


-- QUERY 4: Display all distinct book publication years
SELECT DISTINCT publication_year
FROM books;


-- QUERY 5: Display books in ascending order of price
SELECT title, price
FROM books
ORDER BY price ASC;


-- QUERY 6: Display books costing more than 400
SELECT title, price
FROM books
WHERE price > 400;


-- QUERY 7: Find books with 'The' in their title
SELECT title
FROM books
WHERE title LIKE '%The%';


-- QUERY 8: Find books published between 1990 and 2020
SELECT title, publication_year
FROM books
WHERE publication_year BETWEEN 1990 AND 2020;


-- QUERY 9: Display books belonging to categories 1, 2 and 3
SELECT title, category_id
FROM books
WHERE category_id IN (1, 2, 3);


-- QUERY 10: Display the first five books
SELECT title, price
FROM books
LIMIT 5;


-- QUERY 11: Count the total number of books
SELECT COUNT(*) AS Total_Books
FROM books;


-- QUERY 12: Find the average price of all books
SELECT AVG(price) AS Average_Price
FROM books;


-- QUERY 13: Find the highest and lowest book prices
SELECT MAX(price) AS Highest_Price,
       MIN(price) AS Lowest_Price
FROM books;


-- QUERY 14: Calculate the total value of all books
SELECT SUM(price) AS Total_Book_Value
FROM books;


-- QUERY 15: Count the number of books in each category
SELECT category_id, COUNT(*) AS Total_Books
FROM books
GROUP BY category_id;


-- QUERY 16: Display books that do not belong to categories 1, 2 and 3
SELECT title, category_id
FROM books
WHERE category_id NOT IN (1, 2, 3);


-- QUERY 17: Display books starting from the sixth record
SELECT title, price
FROM books
ORDER BY book_id
LIMIT 5 OFFSET 5;


-- QUERY 18: Find books costing more than 300 AND published after 1990
SELECT title, price, publication_year
FROM books
WHERE price > 300 AND publication_year > 1990;


-- QUERY 19: Display loans that have not been returned yet
SELECT loan_id, member_id, copy_id, due_date
FROM loans
WHERE return_date IS NULL;


-- QUERY 20: Display loans that have been returned
SELECT loan_id, member_id, copy_id, return_date
FROM loans
WHERE return_date IS NOT NULL;

-- QUERY 21: Find books that are Fiction OR Science
SELECT title, category_id
FROM books
WHERE category_id = 1 OR category_id = 2;


-- QUERY 22: Find books that are NOT in the Fiction category
SELECT title, category_id
FROM books
WHERE NOT category_id = 1;


-- QUERY 23: Count books in categories having more than one book
SELECT category_id, COUNT(*) AS Total_Books
FROM books
GROUP BY category_id
HAVING COUNT(*) > 1;


-- QUERY 24: Count loans handled by each staff member
SELECT staff_id, COUNT(*) AS Total_Loans
FROM loans
GROUP BY staff_id
HAVING COUNT(*) >= 2;


-- QUERY 25: INNER JOIN - Display books with their category names
SELECT b.title, c.category_name
FROM books b
INNER JOIN categories c
ON b.category_id = c.category_id;


-- QUERY 26: LEFT JOIN - Display all members and their loan details
SELECT m.member_name, l.loan_id, l.issue_date, l.loan_status
FROM members m
LEFT JOIN loans l
ON m.member_id = l.member_id;


-- QUERY 27: RIGHT JOIN - Display all loans with their member details
SELECT m.member_name, l.loan_id, l.issue_date, l.loan_status
FROM members m
RIGHT JOIN loans l
ON m.member_id = l.member_id;


-- QUERY 28: SELF JOIN - Find pairs of authors from the same country
SELECT a1.author_name AS Author_1,
       a2.author_name AS Author_2,
       a1.country
FROM authors a1
JOIN authors a2
ON a1.country = a2.country
AND a1.author_id < a2.author_id;


-- QUERY 29: SUBQUERY - Find books costing more than the average book price
SELECT title, price
FROM books
WHERE price > (
    SELECT AVG(price)
    FROM books
);


-- QUERY 30: SUBQUERY - Find members who have borrowed books
SELECT member_name
FROM members
WHERE member_id IN (
    SELECT member_id
    FROM loans
);


-- QUERY 31: CORRELATED SUBQUERY - Find books priced above their category's average price
SELECT b.title, b.price, b.category_id
FROM books b
WHERE b.price > (
    SELECT AVG(b2.price)
    FROM books b2
    WHERE b2.category_id = b.category_id
);


-- QUERY 32: EXISTS - Find members who have at least one loan
SELECT m.member_id, m.member_name
FROM members m
WHERE EXISTS (
    SELECT 1
    FROM loans l
    WHERE l.member_id = m.member_id
);


-- QUERY 33: NOT EXISTS - Find members who have never borrowed a book
SELECT m.member_id, m.member_name
FROM members m
WHERE NOT EXISTS (
    SELECT 1
    FROM loans l
    WHERE l.member_id = m.member_id
);

-- QUERY 34: CASE - Categorize books based on their price
SELECT title, price,
    CASE
        WHEN price >= 500 THEN 'Expensive'
        WHEN price >= 300 THEN 'Moderate'
        ELSE 'Affordable'
    END AS Price_Category
FROM books;


-- QUERY 35: COALESCE - Display return date or 'Not Returned'
SELECT loan_id, member_id,
       COALESCE(CAST(return_date AS CHAR), 'Not Returned')
       AS Return_Status
FROM loans;


-- QUERY 36: UNION - Display unique names of members and staff
SELECT member_name AS Person_Name
FROM members

UNION

SELECT staff_name AS Person_Name
FROM staff;


-- QUERY 37: UNION ALL - Display all member and staff names
SELECT member_name AS Person_Name
FROM members

UNION ALL

SELECT staff_name AS Person_Name
FROM staff;



-- bussiness reports

-- 1. Total number of books
SELECT COUNT(*) AS total_books
FROM books;

-- 2. Total number of registered members
SELECT COUNT(*) AS total_members
FROM members;

-- 3. Monthly loan report
SELECT
    MONTH(issue_date) AS loan_month,
    YEAR(issue_date) AS loan_year,
    COUNT(*) AS total_loans
FROM loans
GROUP BY YEAR(issue_date), MONTH(issue_date)
ORDER BY loan_year, loan_month;

-- 4. Top 5 members based on borrowing activity
SELECT
    m.member_name,
    COUNT(l.loan_id) AS total_books_borrowed
FROM members m
JOIN loans l ON m.member_id = l.member_id
GROUP BY m.member_id, m.member_name
ORDER BY total_books_borrowed DESC
LIMIT 5;

-- 5. Highest and lowest book prices
SELECT
    MAX(price) AS highest_book_price,
    MIN(price) AS lowest_book_price
FROM books;

-- 6. Second highest book price
SELECT MAX(price) AS second_highest_price
FROM books
WHERE price < (SELECT MAX(price) FROM books);

-- 7. Category-wise book summary
SELECT
    c.category_name,
    COUNT(b.book_id) AS total_books
FROM categories c
LEFT JOIN books b ON c.category_id = b.category_id
GROUP BY c.category_id, c.category_name
ORDER BY total_books DESC;

-- 8. Pending reservations
SELECT COUNT(*) AS pending_reservations
FROM reservations
WHERE reservation_status = 'Pending';

-- 9. Completed book loans
SELECT COUNT(*) AS completed_loans
FROM loans
WHERE loan_status = 'Returned';

-- 10. Frequently borrowed books
SELECT
    b.title,
    COUNT(l.loan_id) AS borrowing_count
FROM books b
JOIN book_copies bc ON b.book_id = bc.book_id
JOIN loans l ON bc.copy_id = l.copy_id
GROUP BY b.book_id, b.title
ORDER BY borrowing_count DESC
LIMIT 5;

-- 11. Unpaid fine report
SELECT
    m.member_name,
    f.fine_amount,
    f.payment_status
FROM fines f
JOIN loans l ON f.loan_id = l.loan_id
JOIN members m ON l.member_id = m.member_id
WHERE f.payment_status = 'Unpaid';

-- 12. Overdue books
SELECT
    l.loan_id,
    m.member_name,
    b.title,
    l.due_date,
    DATEDIFF(CURDATE(), l.due_date) AS overdue_days
FROM loans l
JOIN members m ON l.member_id = m.member_id
JOIN book_copies bc ON l.copy_id = bc.copy_id
JOIN books b ON bc.book_id = b.book_id
WHERE l.return_date IS NULL
AND l.due_date < CURDATE();

-- 13. Top 5 staff members based on loans handled
SELECT
    s.staff_name,
    COUNT(l.loan_id) AS total_loans_handled
FROM staff s
INNER JOIN loans l ON s.staff_id = l.staff_id
GROUP BY s.staff_id, s.staff_name
ORDER BY total_loans_handled DESC
LIMIT 5;


-- 14. Monthly revenue generated from paid fines
SELECT
    YEAR(fine_date) AS report_year,
    MONTH(fine_date) AS report_month,
    SUM(fine_amount) AS total_revenue
FROM fines
WHERE payment_status = 'Paid'
GROUP BY YEAR(fine_date), MONTH(fine_date)
ORDER BY report_year, report_month;



-- 15. Staff performance report
SELECT
    s.staff_id,
    s.staff_name,
    COUNT(l.loan_id) AS total_loans_handled,
    SUM(CASE
        WHEN l.loan_status = 'Returned' THEN 1
        ELSE 0
    END) AS completed_loans,
    SUM(CASE
        WHEN l.loan_status = 'Issued' THEN 1
        ELSE 0
    END) AS pending_loans
FROM staff s
LEFT JOIN loans l ON s.staff_id = l.staff_id
GROUP BY s.staff_id, s.staff_name
ORDER BY total_loans_handled DESC;