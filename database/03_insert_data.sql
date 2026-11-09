USE LibraryManagementSystem;

-- 1. Insert Categories
INSERT INTO categories (category_name, description)
VALUES
('Fiction', 'Fictional stories and novels'),
('Science', 'Scientific books and discoveries'),
('Technology', 'Computers and emerging technologies'),
('History', 'Historical events and civilizations'),
('Biography', 'Life stories of notable people'),
('Fantasy', 'Fantasy and magical stories'),
('Mystery', 'Mystery and detective novels'),
('Education', 'Academic and educational books'),
('Business', 'Management and business studies'),
('Self Help', 'Personal development and motivation');



-- 2. Insert Authors
INSERT INTO authors (author_name, country, email)
VALUES
('J.K. Rowling', 'United Kingdom', 'jkrowling@example.com'),
('George Orwell', 'United Kingdom', 'georgeorwell@example.com'),
('Dan Brown', 'United States', 'danbrown@example.com'),
('Paulo Coelho', 'Brazil', 'paulocoelho@example.com'),
('Agatha Christie', 'United Kingdom', 'agathachristie@example.com'),
('Stephen Hawking', 'United Kingdom', 'stephenhawking@example.com'),
('Yuval Noah Harari', 'Israel', 'yuvalharari@example.com'),
('Robert Kiyosaki', 'United States', 'robertkiyosaki@example.com'),
('Jane Austen', 'United Kingdom', 'janeausten@example.com'),
('A.P.J. Abdul Kalam', 'India', 'apjkalam@example.com');



-- 3. Insert Publishers
INSERT INTO publishers (publisher_name, city, country)
VALUES
('Penguin Random House', 'New York', 'United States'),
('HarperCollins', 'New York', 'United States'),
('Bloomsbury Publishing', 'London', 'United Kingdom'),
('Oxford University Press', 'Oxford', 'United Kingdom'),
('Scholastic', 'New York', 'United States'),
('Macmillan Publishers', 'London', 'United Kingdom'),
('Hachette Book Group', 'New York', 'United States'),
('Pearson Education', 'London', 'United Kingdom'),
('S.Chand Publishing', 'New Delhi', 'India'),
('Rupa Publications', 'New Delhi', 'India');


ALTER TABLE books
MODIFY publication_year SMALLINT;


-- 4. Insert Books
INSERT INTO books
(title, isbn, category_id, publisher_id, publication_year, price)
VALUES
('Harry Potter and the Philosopher''s Stone', '9780747532699', 6, 3, 1997, 450.00),
('1984', '9780451524935', 1, 1, 1949, 350.00),
('The Da Vinci Code', '9780307474278', 7, 2, 2003, 500.00),
('The Alchemist', '9780061122415', 1, 1, 1988, 300.00),
('Murder on the Orient Express', '9780062693662', 7, 2, 1934, 400.00),
('A Brief History of Time', '9780553380163', 2, 6, 1988, 550.00),
('Sapiens', '9780062316097', 4, 1, 2011, 600.00),
('Rich Dad Poor Dad', '9781612680194', 9, 10, 1997, 350.00),
('Pride and Prejudice', '9780141439518', 1, 1, 1813, 250.00),
('Wings of Fire', '9788173711466', 5, 9, 1999, 300.00);




SELECT book_id, title FROM books;

SELECT author_id, author_name FROM authors;

-- 5. Connect Books with Authors
INSERT INTO book_authors (book_id, author_id)
VALUES
(11, 1),
(12, 2),
(13, 3),
(14, 4),
(15, 5),
(16, 6),
(17, 7),
(18, 8),
(19, 9),
(20, 10);


-- 6. Insert Members
INSERT INTO members
(member_name, email, phone, address, membership_date, status)
VALUES
('Rahul Sharma', 'rahul@example.com', '9876543210', 'Chennai', '2025-01-10', 'Active'),
('Priya Reddy', 'priya@example.com', '9876543211', 'Hyderabad', '2025-02-15', 'Active'),
('Arjun Kumar', 'arjun@example.com', '9876543212', 'Bangalore', '2025-03-20', 'Active'),
('Sneha Patel', 'sneha@example.com', '9876543213', 'Mumbai', '2025-04-05', 'Active'),
('Karthik Rao', 'karthik@example.com', '9876543214', 'Vijayawada', '2025-04-18', 'Active'),
('Ananya Das', 'ananya@example.com', '9876543215', 'Kolkata', '2025-05-12', 'Active'),
('Vikram Singh', 'vikram@example.com', '9876543216', 'Delhi', '2025-06-01', 'Active'),
('Meera Nair', 'meera@example.com', '9876543217', 'Kochi', '2025-06-15', 'Active'),
('Aditya Verma', 'aditya@example.com', '9876543218', 'Pune', '2025-07-10', 'Active'),
('Divya Iyer', 'divya@example.com', '9876543219', 'Chennai', '2025-08-20', 'Active');


-- 7. Insert Staff
INSERT INTO staff
(staff_name, email, designation, hire_date)
VALUES
('Ramesh Kumar', 'ramesh.staff@example.com', 'Librarian', '2022-01-10'),
('Lakshmi Devi', 'lakshmi.staff@example.com', 'Assistant Librarian', '2022-03-15'),
('Suresh Babu', 'suresh.staff@example.com', 'Library Manager', '2021-06-20'),
('Nisha Rao', 'nisha.staff@example.com', 'Librarian', '2023-02-01'),
('Vijay Menon', 'vijay.staff@example.com', 'Assistant Librarian', '2023-07-12');


-- 8. Insert Book Copies
INSERT INTO book_copies (book_id, barcode, availability_status)
VALUES
(11, 'LIB1001', 'Available'),
(11, 'LIB1002', 'Available'),
(12, 'LIB1003', 'Available'),
(12, 'LIB1004', 'Available'),
(13, 'LIB1005', 'Available'),
(13, 'LIB1006', 'Available'),
(14, 'LIB1007', 'Available'),
(14, 'LIB1008', 'Available'),
(15, 'LIB1009', 'Available'),
(15, 'LIB1010', 'Available'),
(16, 'LIB1011', 'Available'),
(17, 'LIB1012', 'Available'),
(18, 'LIB1013', 'Available'),
(19, 'LIB1014', 'Available'),
(20, 'LIB1015', 'Available');


-- 9. Insert Loans
INSERT INTO loans
(member_id, copy_id, staff_id, issue_date, due_date, return_date, loan_status)
VALUES
(1, 1, 1, '2026-01-01', '2026-01-15', '2026-01-12', 'Returned'),
(2, 3, 2, '2026-01-03', '2026-01-17', NULL, 'Issued'),
(3, 5, 1, '2026-01-05', '2026-01-19', '2026-01-18', 'Returned'),
(4, 7, 3, '2026-01-07', '2026-01-21', NULL, 'Issued'),
(5, 9, 4, '2026-01-09', '2026-01-23', '2026-01-20', 'Returned'),
(6, 11, 2, '2026-01-11', '2026-01-25', NULL, 'Issued'),
(7, 12, 5, '2026-01-13', '2026-01-27', '2026-01-30', 'Returned'),
(8, 13, 1, '2026-01-15', '2026-01-29', NULL, 'Issued'),
(9, 14, 3, '2026-01-17', '2026-01-31', '2026-01-28', 'Returned'),
(10, 15, 4, '2026-01-19', '2026-02-02', NULL, 'Issued'),
(1, 2, 2, '2026-02-01', '2026-02-15', NULL, 'Issued'),
(2, 4, 3, '2026-02-03', '2026-02-17', '2026-02-16', 'Returned'),
(3, 6, 5, '2026-02-05', '2026-02-19', NULL, 'Issued'),
(4, 8, 1, '2026-02-07', '2026-02-21', '2026-02-25', 'Returned'),
(5, 10, 4, '2026-02-09', '2026-02-23', NULL, 'Issued');

-- 10. Insert Reservations
INSERT INTO reservations
(member_id, book_id, reservation_date, reservation_status)
VALUES
(1, 12, '2026-02-01', 'Pending'),
(2, 13, '2026-02-02', 'Completed'),
(3, 14, '2026-02-03', 'Pending'),
(4, 15, '2026-02-04', 'Cancelled'),
(5, 16, '2026-02-05', 'Pending'),
(6, 17, '2026-02-06', 'Completed'),
(7, 18, '2026-02-07', 'Pending'),
(8, 19, '2026-02-08', 'Cancelled'),
(9, 20, '2026-02-09', 'Completed'),
(10, 11, '2026-02-10', 'Pending');


-- 11. Insert Fines
INSERT INTO fines
(loan_id, fine_amount, payment_status, fine_date)
VALUES
(7, 30.00, 'Paid', '2026-01-30'),
(9, 20.00, 'Paid', '2026-01-28'),
(14, 40.00, 'Unpaid', '2026-02-25'),
(1, 10.00, 'Paid', '2026-01-12'),
(5, 25.00, 'Unpaid', '2026-01-20');


SELECT 'authors' AS Table_Name, COUNT(*) AS Total_Records FROM authors
UNION ALL
SELECT 'categories', COUNT(*) FROM categories
UNION ALL
SELECT 'publishers', COUNT(*) FROM publishers
UNION ALL
SELECT 'books', COUNT(*) FROM books
UNION ALL
SELECT 'book_authors', COUNT(*) FROM book_authors
UNION ALL
SELECT 'members', COUNT(*) FROM members
UNION ALL
SELECT 'staff', COUNT(*) FROM staff
UNION ALL
SELECT 'book_copies', COUNT(*) FROM book_copies
UNION ALL
SELECT 'loans', COUNT(*) FROM loans
UNION ALL
SELECT 'reservations', COUNT(*) FROM reservations
UNION ALL
SELECT 'fines', COUNT(*) FROM fines;
