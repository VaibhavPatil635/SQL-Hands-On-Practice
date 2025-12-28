	CREATE DATABASE SHRIKRUSHANAFARM;
    USE SHRIKRUSHANAFARM;
    
    CREATE TABLE employee (
    id INT PRIMARY KEY,
    name VARCHAR(50),
    sal INT
);
     
	insert into employee (id,name,sal) values
    (1,"ram",20000),
    (2,"shyam",20050);
    
    SELECT *FROM employee;
    drop table students;
    
    CREATE TABLE students (
    roll_no INT PRIMARY KEY,
    name VARCHAR(50),
    city VARCHAR(50),
    marks INT NOT NULL
);
    
    insert into students (roll_no, name, city, marks)
    values
    (12, 'ram', 'ayodhya', 78),
    (13, 'mohan', 'mohan', 56),
    (14, 'madav','dwaraka', 88),
    (15, 'keshav','mathura', 78),
    (16, 'krushana','vaikunth', 98);
    
    select * from students;
     
    select name from students;
    
    select * from students order by marks asc;
    
    select * from students limit 3;
    
    select * from students order by marks desc limit 3;
    
    select * from students where marks > 56;
    
    select avg(marks) from students; 
    
    
    
    drop table students;
    
    
CREATE DATABASE SHRIKRUSHANAFARM;
USE SHRIKRUSHANAFARM;
    
    
    
CREATE TABLE students (
    id INT PRIMARY KEY,
    name VARCHAR(50),
    class INT,
    marks INT NOT NULL,
    city VARCHAR(50)
);

insert into students (id, name, class, marks, city)
values
(1, 'Raj', 10, 78, 'Pune'),
(2, 'Priya', 10, 92, 'Mumbai'),
(3, 'Aman', 9, 67, 'Delhi'),
(4, 'Sneha', 9, 88, 'Pune'),
(5, 'Rohan', 10, 95, 'Delhi'),
(6, 'Pooja', 9, 73, 'Mumbai'),
(7, 'Arjun', 10, 81, 'Pune');

select * from students;

select * from students where city ='pune';

select * from students where marks > 80;

select * from students where class = 10 and city = 'delhi';

select * from students where city != 'mumbai';

select * from students where marks between 70 and 90;

select * from students order by marks asc limit 3;

select * from students order by marks desc limit 3;

select * from students order by city asc, marks desc; 

select * from students where city = 'pune' limit 2;

select count(name) from students;

select avg(marks) from students;

select max(marks) from students;

select min(marks) from students where class = 9;

select count(name) from students where city = 'pune';

select sum(marks) from students where city = 'delhi';

-- Show top 2 students (highest marks) from Pune.

select * from students where city = 'pune' order by marks desc limit 2;

-- Show average marks of students from class 10 only.

select avg(marks) from students where class = 10;

-- Show students from Mumbai whose marks are greater than 80, sorted by marks descending.

SELECT 
    *
FROM
    students
WHERE
    city = 'mumbai' AND marks > 80
ORDER BY marks DESC;

SELECT 
    city, COUNT(city), MAX(marks)
FROM
    students
GROUP BY city;

SELECT 
    class, AVG(marks)
FROM
    students
GROUP BY class;

select class, count(id)
from students
group by class
having count(id) > 2;

SELECT class, COUNT(*) AS total_students
FROM students
GROUP BY class
HAVING COUNT(*) > 2;

SELECT 
    city, AVG(marks)
FROM
    students
GROUP BY city
HAVING AVG(marks) > 80;

select city, sum(marks)
from students
group by city
having sum(marks) > 200;

select class, min(marks)
from students
group by class;





 

 

