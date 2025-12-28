-- Step 1: Create Database
CREATE DATABASE library_db;
USE library_db;
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
('The Alchemist', 'Paulo Coelho', 'Fiction', 10, 10),

-- Members
INSERT INTO members (name, email, join_date, book_issue, status) VALUES
('Amit Sharma', 'amit@gmail.com', '2023-05-01', NULL, 'active');



INSERT INTO book_issues (book_id, member_id, issue_date, due_date, return_date) VALUES
(1, 1, '2023-09-01', '2023-09-15', NULL),  
(2, 2, '2023-09-05', '2023-09-20', '2023-09-18');
select * from books;
select * from members;
select * from book_issues;

