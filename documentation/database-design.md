# Database Design – Library Management System

## 1. Database Overview

The Library Management System uses a relational database named `LibraryManagementSystem`, developed using MySQL 8+. It stores and manages information about books, authors, publishers, members, staff, book copies, loans, reservations and fines.

The database is designed to reduce data duplication, maintain data consistency and establish relationships between different entities using primary keys and foreign keys.

## 2. Tables and Their Purposes

| Table | Purpose |
|---|---|
| authors | Stores author details. |
| categories | Stores book categories. |
| publishers | Stores publisher information. |
| books | Stores book details, including ISBN, price and publication year. |
| book_authors | Connects books with their authors. |
| members | Stores library member information. |
| staff | Stores library staff details. |
| book_copies | Tracks individual physical copies of books. |
| loans | Stores book issue and return transactions. |
| reservations | Stores member book reservations. |
| fines | Stores fines associated with loans. |

## 3. Primary Keys and Foreign Keys

Each table has a primary key to uniquely identify its records.

Foreign keys maintain relationships between tables:

- `books.category_id` references `categories.category_id`.
- `books.publisher_id` references `publishers.publisher_id`.
- `book_authors.book_id` references `books.book_id`.
- `book_authors.author_id` references `authors.author_id`.
- `book_copies.book_id` references `books.book_id`.
- `loans.member_id` references `members.member_id`.
- `loans.copy_id` references `book_copies.copy_id`.
- `loans.staff_id` references `staff.staff_id`.
- `reservations.member_id` references `members.member_id`.
- `reservations.book_id` references `books.book_id`.
- `fines.loan_id` references `loans.loan_id`.

## 4. Relationships

### One-to-Many (1:M)
- One category can contain multiple books.
- One publisher can publish multiple books.
- One book can have multiple physical copies.
- One member can have multiple loans.
- One staff member can handle multiple loans.
- One member can make multiple reservations.
- One book can have multiple reservations.

### Many-to-Many (M:N)
Books and authors have a many-to-many relationship. A book can have multiple authors, and an author can write multiple books.

The `book_authors` junction table implements this relationship using a composite primary key consisting of `book_id` and `author_id`.

### One-to-One (1:1)
The `fines` table has a one-to-one relationship with `loans`, because `loan_id` is declared as a UNIQUE foreign key in the fines table. Each loan can have at most one fine record.

## 5. Normalization

Normalization organizes data into related tables to reduce unnecessary duplication and improve consistency.

### First Normal Form (1NF)
- Each column contains a single, atomic value.
- Each table has a primary key.
- Repeating groups are avoided.
- Multiple authors are stored separately in `book_authors` instead of being stored together in one books column.

### Second Normal Form (2NF)
- The database satisfies 1NF.
- Every non-key attribute depends on the entire primary key.
- The `book_authors` table uses a composite primary key (`book_id`, `author_id`) and contains no non-key attributes that depend on only part of that key.

### Third Normal Form (3NF)
- The database satisfies 2NF.
- Non-key attributes depend on the primary key rather than on other non-key attributes.
- Author, publisher and category details are maintained in separate tables instead of repeatedly storing those details in the books table.

## 6. Constraints

The database uses the following constraints:

- **PRIMARY KEY:** Uniquely identifies each record.
- **FOREIGN KEY:** Maintains referential integrity between related tables.
- **NOT NULL:** Ensures required fields contain values.
- **UNIQUE:** Prevents duplicate values in fields such as ISBN, email and barcode.
- **DEFAULT:** Provides default values for fields such as status.
- **CHECK:** Validates values such as non-negative prices and valid loan dates.
- **AUTO_INCREMENT:** Automatically generates numeric identifiers.

## 7. Indexing

Indexes are created to improve the performance of frequently used searches.

The project includes:
- `idx_book_title` on `books(title)`.
- `idx_member_name` on `members(member_name)`.
- `idx_loan_issue_date` on `loans(issue_date)`.
- `idx_loan_member_date` on `loans(member_id, issue_date)`.
- `idx_reservation_status` on `reservations(reservation_status)`.

The database also uses unique constraints on fields such as ISBN, member email, author email and book barcode. These create unique indexes to prevent duplicate values.

The `EXPLAIN` statement is used to inspect how MySQL executes queries and whether indexes are considered by the query optimizer.

## 8. Advanced Database Features

The project uses additional SQL features to support library operations:

- **Views:** Provide reusable results for book catalogues, member loan details and unpaid fines.
- **Stored Procedures:** Support book searches by category, member registration and overdue book reports.
- **Stored Function:** `calculate_fine()` calculates a fine based on the number of days a book is overdue, at a rate of ₹10 per day.
- **Trigger:** Automatically changes a book copy's availability status to `Issued` after a new loan record is inserted.
- **Cursor:** Processes members individually to generate a member-wise loan summary.
- **Transactions:** Demonstrate `COMMIT`, `ROLLBACK` and `SAVEPOINT` to manage database changes safely.

These features reduce repeated SQL work, support consistent operations and demonstrate advanced MySQL concepts.