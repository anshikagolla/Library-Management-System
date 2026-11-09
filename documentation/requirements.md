# Project Requirements – Library Management System

## 1. Project Title
**Library Management System Using MySQL**

## 2. Project Objective
The objective of this project is to develop a relational database system that helps manage library operations efficiently. It maintains information about books, authors, publishers, members, staff, book loans, reservations and fines.

## 3. Real-World Problem
Traditional library management can involve maintaining book records, tracking issued books, managing member information and calculating overdue fines manually. This can lead to duplicate records, errors and difficulty retrieving information.

The proposed system organizes library data in a centralized MySQL database and makes information easier to manage and retrieve.

## 4. Main Modules

1. **Book Management:** Stores book details such as title, ISBN, category, publisher, publication year and price.
2. **Author Management:** Maintains author information and connects authors with books.
3. **Category Management:** Organizes books into different categories.
4. **Publisher Management:** Stores publisher information.
5. **Member Management:** Maintains member details and membership status.
6. **Staff Management:** Stores library staff information.
7. **Book Copy Management:** Tracks individual physical copies and their availability.
8. **Loan Management:** Records book issue dates, due dates and return dates.
9. **Reservation Management:** Maintains book reservations made by members.
10. **Fine Management:** Records fines associated with overdue loans.

## 5. Users and Roles

### Librarian
- Manages book and book-copy records.
- Handles book issue and return records.
- Manages member reservations.
- Monitors overdue books and fines.

### Library Member
- Registers with the library.
- Borrows books.
- Reserves books.
- Checks borrowing and reservation information through library services.

### Administrator
- Maintains library staff and database records.
- Monitors library operations.
- Generates reports using SQL queries.

## 6. System Workflow

1. Book, author, publisher and category details are stored in the database.
2. Library members register and their details are maintained.
3. Staff members handle book issue transactions.
4. Loan records store issue dates and due dates.
5. Book copies are tracked using their availability status.
6. Members can reserve books.
7. Returned books are recorded in the loan details.
8. Fines are recorded for applicable overdue loans.
9. SQL queries and reports help analyze library activities.

## 7. Technologies Used

- **Database:** MySQL 8+
- **Database Tool:** MySQL Workbench
- **Query Language:** SQL
- **Documentation:** Markdown

## 8. Expected Outcome

The project provides a structured relational database for managing library information. It demonstrates database design, normalization, relationships, SQL queries, views, stored procedures, functions, triggers, cursors, transactions and indexing.