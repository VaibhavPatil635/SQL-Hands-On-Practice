CREATE DATABASE library;
USE library;
-- drop database library_db;

CREATE TABLE books (
    book_id INT PRIMARY KEY AUTO_INCREMENT,
    title VARCHAR(100) NOT NULL,
    author VARCHAR(100) NOT NULL,
    category VARCHAR(50),
    total_copies INT NOT NULL,
    available_copies INT NOT NULL
);

CREATE TABLE members (
    member_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    join_date DATE DEFAULT (CURDATE()),
    book_issue varchar(100),
    status ENUM('active', 'inactive') DEFAULT 'active'
);
CREATE TABLE book_issues (
    issue_id INT PRIMARY KEY AUTO_INCREMENT,
    book_id INT,
    member_id INT,
    issue_date DATE NOT NULL DEFAULT (CURDATE()),
    due_date DATE NOT NULL,
    return_date DATE,
    FOREIGN KEY (book_id) REFERENCES books (book_id),
    FOREIGN KEY (member_id) REFERENCES members (member_id)
);

INSERT INTO books (title, author, category, total_copies, available_copies) VALUES
('Rag Darbari', 'Shrilal Shukla', 'Novel', 7, 7),
('Yugandhar', 'Shivaji Sawant', 'Historical', 5, 5);
-- Members
INSERT INTO members (name, email, join_date, book_issue, status) VALUES
('Vaibhav', 'vaibhav@gmail.com', '2025-09-01', NULL, 'active'),
('Aditay', 'adi@gmail.com', '2025-09-05',NULL,'inactive');

INSERT INTO book_issues (book_id, member_id, issue_date, due_date, return_date) VALUES
(1, 1, '2023-09-01', '2025-09-2', NULL);
select * from books;
select * from members;
select * from book_issues;

