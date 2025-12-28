create database company;
use company;
drop database employees;    
CREATE TABLE employees (
    emp_id INT PRIMARY KEY,
    name VARCHAR(50),
    department VARCHAR(50),
    salary INT,
    city VARCHAR(50)
);
INSERT INTO employees1 (emp_id, name, department, salary, city) VALUES
(1, 'Raj', 'HR', 35000, 'Mumbai'),
(2, 'Priya', 'IT', 60000, 'Pune'),
(3, 'Aman', 'IT', 55000, 'Delhi'),
(4, 'Riya', 'Sales', 40000, 'Delhi'),
(5, 'Neha', 'HR', 37000, 'Pune'),
(6, 'Arjun', 'Finance', 70000, 'Mumbai'),
(7, 'Meena', 'Sales', 45000, 'Pune'),
(8, 'Ravi', 'Finance', 65000, 'Delhi'),
(9, 'Kiran', 'IT', 62000, 'Mumbai'),
(10, 'Alok', 'HR', 30000, 'Delhi');

select * from employees;



                