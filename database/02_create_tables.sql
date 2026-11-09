USE LibraryManagementSystem;
CREATE TABLE authors (
    author_id INT PRIMARY KEY AUTO_INCREMENT,
    author_name VARCHAR(100) NOT NULL,
    country VARCHAR(50),
    email VARCHAR(100) UNIQUE
);

CREATE TABLE categories (
    category_id INT PRIMARY KEY AUTO_INCREMENT,
    category_name VARCHAR(100) NOT NULL UNIQUE,
    description VARCHAR(255)
);

CREATE TABLE publishers (
    publisher_id INT PRIMARY KEY AUTO_INCREMENT,
    publisher_name VARCHAR(100) NOT NULL,
    city VARCHAR(50),
    country VARCHAR(50)
);


CREATE TABLE books (
    book_id INT PRIMARY KEY AUTO_INCREMENT,
    title VARCHAR(150) NOT NULL,
    isbn VARCHAR(20) UNIQUE,
    category_id INT,
    publisher_id INT,
    publication_year YEAR,
    price DECIMAL(10,2),

    FOREIGN KEY (category_id)
        REFERENCES categories(category_id),

    FOREIGN KEY (publisher_id)
        REFERENCES publishers(publisher_id),

    CHECK (price >= 0)
);


CREATE TABLE book_authors (
    book_id INT,
    author_id INT,

    PRIMARY KEY (book_id, author_id),

    FOREIGN KEY (book_id)
        REFERENCES books(book_id),

    FOREIGN KEY (author_id)
        REFERENCES authors(author_id)
);


CREATE TABLE members (
    member_id INT PRIMARY KEY AUTO_INCREMENT,
    member_name VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE,
    phone VARCHAR(15),
    address VARCHAR(255),
    membership_date DATE NOT NULL,
    status VARCHAR(20) DEFAULT 'Active'
);




-- TABLE 7: STAFF
CREATE TABLE staff (
    staff_id INT PRIMARY KEY AUTO_INCREMENT,
    staff_name VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE,
    designation VARCHAR(50),
    hire_date DATE
);


-- TABLE 8: BOOK_COPIES
CREATE TABLE book_copies (
    copy_id INT PRIMARY KEY AUTO_INCREMENT,
    book_id INT NOT NULL,
    barcode VARCHAR(50) UNIQUE NOT NULL,
    availability_status VARCHAR(20)
        DEFAULT 'Available',

    FOREIGN KEY (book_id)
        REFERENCES books(book_id),

    CHECK (
        availability_status IN
        ('Available', 'Issued', 'Reserved', 'Lost')
    )
);


-- TABLE 9: LOANS
CREATE TABLE loans (
    loan_id INT PRIMARY KEY AUTO_INCREMENT,
    member_id INT NOT NULL,
    copy_id INT NOT NULL,
    staff_id INT NOT NULL,
    issue_date DATE NOT NULL,
    due_date DATE NOT NULL,
    return_date DATE,
    loan_status VARCHAR(20) DEFAULT 'Issued',

    FOREIGN KEY (member_id)
        REFERENCES members(member_id),

    FOREIGN KEY (copy_id)
        REFERENCES book_copies(copy_id),

    FOREIGN KEY (staff_id)
        REFERENCES staff(staff_id),

    CHECK (due_date >= issue_date),

    CHECK (
        return_date IS NULL
        OR return_date >= issue_date
    )
);


-- TABLE 10: RESERVATIONS
CREATE TABLE reservations (
    reservation_id INT PRIMARY KEY AUTO_INCREMENT,
    member_id INT NOT NULL,
    book_id INT NOT NULL,
    reservation_date DATE NOT NULL,
    reservation_status VARCHAR(20)
        DEFAULT 'Pending',

    FOREIGN KEY (member_id)
        REFERENCES members(member_id),

    FOREIGN KEY (book_id)
        REFERENCES books(book_id)
);


-- TABLE 11: FINES
CREATE TABLE fines (
    fine_id INT PRIMARY KEY AUTO_INCREMENT,
    loan_id INT NOT NULL UNIQUE,
    fine_amount DECIMAL(10,2) NOT NULL,
    payment_status VARCHAR(20)
        DEFAULT 'Unpaid',
    fine_date DATE NOT NULL,

    FOREIGN KEY (loan_id)
        REFERENCES loans(loan_id),

    CHECK (fine_amount >= 0)
);

SHOW TABLES;