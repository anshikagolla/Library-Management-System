# Library Management System

A Relational Database Management System using MySQL

---

## 1. Project Title

**Library Management System Using MySQL**

## 2. Project Description

The Library Management System is a database project developed using MySQL to simplify and organize library operations. It provides a centralized database for maintaining information about books, authors, publishers, categories, members, staff, loans, reservations and fines.

The system helps manage book availability, track borrowing and returning activities, maintain member records and monitor overdue books.

This project demonstrates the practical implementation of relational database concepts, SQL queries, database normalization and advanced SQL features.

## 3. Features

The major features of the project include:

- **Book Management:** Store and manage book details, ISBN, category, publisher and price.
- **Author Management:** Maintain author information and associate authors with books.
- **Category Management:** Organize books based on different categories.
- **Publisher Management:** Maintain publisher information.
- **Member Management:** Store member details and membership status.
- **Staff Management:** Maintain library staff information.
- **Book Copy Management:** Track individual book copies and their availability.
- **Loan Management:** Maintain book issue dates, due dates and return dates.
- **Reservation Management:** Record book reservations made by members.
- **Fine Management:** Maintain fine records associated with loans.
- **Business Reports:** Generate reports for popular books, member activity, overdue loans and fines.
- **Advanced SQL Operations:** Implement views, stored procedures, functions, triggers, cursors and transactions.
- **Query Optimization:** Use indexes and EXPLAIN to analyze query execution.

## 4. Technologies Used

| Technology | Purpose |
|---|---|
| MySQL 8+ | Relational database management |
| MySQL Workbench | Database design and SQL execution |
| SQL | Database creation, manipulation and querying |
| Markdown | Project documentation |

## 5. Database Structure

The project uses a database named `LibraryManagementSystem`.

It consists of the following 11 tables:

| Table Name | Description |
|---|---|
| authors | Stores author information. |
| categories | Stores book categories. |
| publishers | Stores publisher details. |
| books | Stores book information. |
| book_authors | Connects books and authors. |
| members | Stores library member details. |
| staff | Stores staff information. |
| book_copies | Tracks individual physical book copies. |
| loans | Maintains book borrowing and return records. |
| reservations | Stores book reservation details. |
| fines | Maintains fine information associated with loans. |

### Database Relationships

- Categories and Books – One-to-Many.
- Publishers and Books – One-to-Many.
- Books and Authors – Many-to-Many through `book_authors`.
- Books and Book Copies – One-to-Many.
- Members and Loans – One-to-Many.
- Staff and Loans – One-to-Many.
- Members and Reservations – One-to-Many.
- Loans and Fines – One-to-One (optional).

The database uses primary keys, foreign keys, unique constraints and other validation constraints to maintain data integrity.

## 6. Installation Steps

### Prerequisites

Before executing the project, ensure that the following software is installed:

1. MySQL Server 8.0 or later.
2. MySQL Workbench.

### Installation

1. Install MySQL Server and MySQL Workbench.
2. Open MySQL Workbench.
3. Connect to your local MySQL server.
4. Open the SQL Editor.
5. Execute the database creation script.
6. Create the required tables.
7. Insert the sample records.
8. Execute the remaining SQL scripts in the specified order.

## 7. How to Execute SQL Files

The SQL scripts are organized inside the `database` folder.

Execute them in the following order:

| Order | File Name | Description |
|---|---|---|
| 1 | `01_create_database.sql` | Creates the LibraryManagementSystem database. |
| 2 | `02_create_tables.sql` | Creates all 11 tables and their relationships. |
| 3 | `03_insert_data.sql` | Inserts sample records into the tables. |
| 4 | `04_queries.sql` | Contains SQL queries and business reports. |
| 5 | `05_views.sql` | Creates database views. |
| 6 | `06_procedures.sql` | Contains stored procedures, cursor procedure and transaction examples. |
| 7 | `07_functions.sql` | Creates the fine calculation function. |
| 8 | `08_triggers.sql` | Creates the automatic book-copy status trigger. |
| 9 | `09_indexes.sql` | Creates indexes and demonstrates query optimization using EXPLAIN. |

### Execution Instructions

1. Open the required `.sql` file in MySQL Workbench.
2. Select the SQL statements or the complete script.
3. Click the Execute button.
4. Check the Action Output panel for successful execution.
5. Continue with the next SQL file in the specified order.

**Note:** Execute the creation scripts in a fresh database in the order listed. Avoid rerunning scripts containing CREATE statements when the corresponding database objects already exist, unless they are designed to handle existing objects.

## 8. Sample SQL Queries

The project contains more than 30 SQL queries demonstrating different SQL concepts.

Some examples include:

### 1. Display All Books

```sql
SELECT * FROM books;
```

### 2. Search Books by Title

```sql
SELECT book_id, title, price
FROM books
WHERE title LIKE '%Harry%';
```

### 3. Display Books with Their Categories

```sql
SELECT b.title, c.category_name
FROM books b
INNER JOIN categories c
ON b.category_id = c.category_id;
```

### 4. Find the Most Frequently Borrowed Books

```sql
SELECT b.title, COUNT(l.loan_id) AS total_borrowings
FROM books b
JOIN book_copies bc ON b.book_id = bc.book_id
JOIN loans l ON bc.copy_id = l.copy_id
GROUP BY b.book_id, b.title
ORDER BY total_borrowings DESC
LIMIT 5;
```

### 5. Display Unpaid Fines

```sql
SELECT fine_id, loan_id, fine_amount, payment_status
FROM fines
WHERE payment_status = 'Unpaid';
```

The project also includes queries using:

- SELECT, WHERE, DISTINCT and ORDER BY.
- LIKE, BETWEEN, IN and LIMIT.
- Aggregate functions and GROUP BY.
- HAVING and different types of JOINs.
- Subqueries and correlated subqueries.
- EXISTS and NOT EXISTS.
- CASE and COALESCE.
- UNION and UNION ALL.
- Business reports and statistical summaries.

## 9. Future Enhancements

The project can be extended with the following features:

- Develop a web-based library management application.
- Add secure login and authentication for members and staff.
- Implement online book reservations.
- Introduce automated email and SMS reminders for overdue books.
- Integrate online fine payment facilities.
- Generate interactive dashboards and graphical reports.
- Add barcode scanning for book issue and return operations.
- Implement role-based access control.

---

## Conclusion

The Library Management System demonstrates the practical implementation of relational database concepts using MySQL. It provides an organized approach to managing library records and demonstrates SQL operations, normalization, relationships, advanced database programming and query optimization.

The project serves as a foundation for developing a complete library management application.