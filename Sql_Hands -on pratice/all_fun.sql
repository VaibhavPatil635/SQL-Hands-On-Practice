CREATE TABLE customers (
    customer_id INT PRIMARY KEY,
    customer_name VARCHAR(50),
    city VARCHAR(30),
    state VARCHAR(30),
    signup_date DATE
);

INSERT INTO customers VALUES
(1, 'Amit', 'Mumbai', 'Maharashtra', '2023-01-10'),
(2, 'Rohit', 'Pune', 'Maharashtra', '2023-02-15'),
(3, 'Neha', 'Delhi', 'Delhi', '2023-03-05'),
(4, 'Priya', 'Bangalore', 'Karnataka', '2023-01-20'),
(5, 'Karan', 'Mumbai', 'Maharashtra', '2023-04-01');


CREATE TABLE orders1 (
    order_id INT PRIMARY KEY,
    customer_id INT,
    order_date DATE,
    total_order_value INT,
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);

INSERT INTO orders1 VALUES
(101, 1, '2023-05-01', 5000),
(102, 1, '2023-06-10', 3000),
(103, 2, '2023-05-15', 7000),
(104, 3, '2023-06-01', 4000),
(105, 4, '2023-06-20', 9000),
(106, 5, '2023-07-01', 2000),
(107, 2, '2023-07-05', 6000);


CREATE TABLE products (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(50),
    category VARCHAR(30),
    price INT
);

INSERT INTO products VALUES
(1, 'Laptop', 'Electronics', 60000),
(2, 'Mobile', 'Electronics', 30000),
(3, 'Headphones', 'Accessories', 3000),
(4, 'Keyboard', 'Accessories', 1500);


CREATE TABLE order_items (
    order_item_id INT PRIMARY KEY,
    order_id INT,
    product_id INT,
    quantity INT,
    FOREIGN KEY (order_id) REFERENCES orders1(order_id),
    FOREIGN KEY (product_id) REFERENCES products(product_id)
);

INSERT INTO order_items VALUES
(1, 101, 1, 1),
(2, 101, 3, 2),
(3, 102, 2, 1),
(4, 103, 1, 1),
(5, 104, 4, 3),
(6, 105, 1, 1),
(7, 107, 2, 2);

-- customers table से सभी customers दिखाओ 

select customer_name from customers;

-- Mumbai city के customers निकालो
select * from customers 
where city = "mumbai";

-- 2023 के बाद signup हुए customer
select * from customers
WHERE signup_date > '2023-12-31';

-- orders table से सभी orders जिनकी value > 5000
select * from orders1
where total_order_value > 5000;

-- Total कितने customers हैं?
select count(customer_id) from customers;

-- Total कितने orders हुए हैं?
select count(order_id) from orders1;

-- Distinct states निकालो
select distinct(state) from customers;

-- Orders को order_date के descending order में दिखाओ
select * from orders1 order by order_date;

-- Average order value निकालो
select avg(total_order_value) from orders1;

-- Highest order value क्या है?
select max(total_order_value) from orders1;

-- हर customer का total spending निकालो
select c.customer_id, c.customer_name, sum(o.total_order_value) as total_spending
from customers as c
join orders1 as o
on c.customer_id = o.customer_id
group by customer_id, customer_name;

-- हर state का total revenue निकालो
select c.state, sum(o.total_order_value) as state_wise_revenue
from customers as c
join orders1 as o
on c.customer_id = o.customer_id
group by c.state;

-- Customer name के साथ उसका total order value दिखाओ
select c.customer_name, c.customer_id, sum(o.total_order_value)
from customers as c
join orders1 as o
on c.customer_id = o.customer_id
group by c.customer_name, c.customer_id;

-- जिन customers ने एक से ज्यादा orders दिए हैं
select c.customer_name, c.customer_id, count(o.order_id) as total_order
from customers as c
join orders1 as o
on c.customer_id = o.customer_id
group by c.customer_name, c.customer_id
having count(o.order_id)>1;

-- Month-wise total revenue निकालो
select monthname(order_date)as months,sum(total_order_value) as month_wise_revenue
from orders1
group by months;

-- हर customer की first order date हर row के साथ दिखाओ (window function)
select c.customer_id,o.order_id, o.order_date,
min(o.order_date) over(partition by c.customer_id) as first_order_value
from customers as c
join orders1 as o
on c.customer_id = o.customer_id;

-- हर state में top 2 customers by total spending
with s1 as(
select c.customer_id,c.customer_name,c.state,
sum(o.total_order_value) as total_spending
from customers as c
join orders1 as o
on c.customer_id = o.customer_id
group by c.customer_id,c.customer_name,c.state
)
select * from (
select *, 
dense_rank() over(partition by state order by total_spending desc) as rnk
from s1
)t
where rnk <= 2;

-- Customer-wise order value का running total
with s1 as(
select c.customer_id, c.customer_name, o.order_date,
sum(o.total_order_value) as total_sale
from customers as c
join orders1 as o
on c.customer_id = o.customer_id
group by c.customer_id,c.customer_name,o.order_date      
)
select *,
sum(total_sale) over(partition by customer_id order by order_date) as running_total
from s1;

-- Previous order से current order का percentage growth
with s1 as(
select c.customer_id, c.customer_name, o.order_date, o.order_id, o.total_order_value
from customers as c
join orders1 as o
on c.customer_id = o.customer_id
)
select *,
LAG(total_order_value) over(partition by customer_id order by order_date) as previous_avg
from s1;
 

-- Repeat vs New customers पहचानो
select c.customer_id, c.customer_name,count(o.order_id) as order_count,
case when count(o.order_id) = 1 then "new_customers"
	 when count(o.order_id) > 1 then "repeat_customers"
end as customer_type
from customers as c
join orders1 as o
on c.customer_id = o.customer_id
group by c.customer_id, c.customer_name;

select * from customers
where customer_name like "_a%";

/* ==============================================================================================================================================*/

create database GRT_test;
use grt_test;
create table student1(
id int,
name varchar(40),
gender varchar(20),
city varchar(20),
marks int,
age int
);

INSERT INTO student1  VALUES
(1, 'Neha',   'F', 'Pune',   78, 21),
(2, 'Rahul',  'M', 'Mumbai', 85, 22),
(3, 'Seema',  'F', 'Pune',   92, 23),
(4, 'Aman',   'M', 'Delhi',  60, 20),
(5, 'Sneha',  'F', 'Mumbai', 88, 22),
(6, 'Suresh', 'M', 'Pune',   55, 24),
(7, 'Ritu',   'F', 'Delhi',  70, 21);
INSERT INTO student1 (name,age) VALUES
("aditya",22);
select * from student1;
delete from student1
where name = "aditya";
-- Sirf name aur marks dikha
select name, marks from student1;

-- Marks 80 se zyada wale students dikha
select name,marks from student1
where marks > 80;

-- Pune city ke students dikha
select name, city  from student1
where city = "Pune";

-- Female students (F) dikha
select name, gender from student1
where gender = "F";

-- Jiska name S se start hota ho
select name from student1
where name like "s%";

-- Jiska 2nd letter e ho
select name from student1
where name like "_e%";

-- Jiska name a pe end hota ho
select name from student1
where name like "%a";

-- Jiska name me u kahi bhi ho
select name from student1
where name like "%u%";

-- Marks ke hisab se highest to lowest
select marks from student1
order by marks desc;

-- Top 3 highest marks wale students
select marks from student1
order by marks desc limit 3;

-- Age ke hisab se youngest student
select name, age from student1
order by age;

-- Total students count
select count(id) from student1;

-- Pune city me kitne students hai
select count(id) from student1
where city = "pune";

-- Average marks
select avg(marks) from student1;

-- Maximum marks
select max(marks) from student1;

-- Minimum marks
select min(marks) from student1;

-- Marks 70 se 90 ke beech wale students
select name, marks from student1
where marks between 70 and 90;

-- Mumbai ke students jinke marks 80+ hai
select name, marks from student1
where marks > 80;

-- Female students ko marks ke hisab se sort kar
select name, gender, marks from student1
where gender = "f" 
order by marks;

/* student1 table me ek naya student insert kar:
id = 11
name = Rohini
gender = F
city = Pune
marks = 86
age = 22 */

insert into student1(id, name, gender, city, marks, age) 
values
(11,"Rohini", "F", "Pune", 86, 22);
select * from student1;

/* Ek hi query me 2 students insert kar:
(12, Arjun, M, Mumbai, 74, 21)
(13, Kavya, F, Delhi, 91, 23) */
insert into student1 (id, name, gender, city, marks, age) values
(12, "Arjun", "M", "Mumbai", 74, 21),
(13, "Kavya", "F", "Delhi", 91, 23);

/* Sirf id, name, city ke saath ek student insert kar
(id = 14, name = Sagar, city = Nashik) */
insert into student1 (id, name, city) values
(14, "Sager", "Nashik"); 

-- Jis student ka id = 6 hai, uske marks 65 kar.
update student1 
set  marks = 65
where id = 6;

-- Aman ka: city → Mumbai  marks → 72
 update student1
 set marks = 72, city = "Mumbai"
 where id = 4;
 
 -- Jinke marks 60 se kam hain, unke marks +5 badha.
 update student1
 set marks = marks + 5
 where marks < 60;
 
 -- Pune city ke students ki age 1 year increase kar.
 update student1
 set age = age + 1
 where city = "pune";
 
 select * from student1;
 
 /*student1 table me ek naya column add kar:
column name = phone
datatype = VARCHAR(15)*/

alter table student1 
add phone varchar(15);

-- marks column ka datatype change karke DECIMAL(5,2) kar.
alter table student1
modify marks decimal(5, 2);

-- gender column ka naam change karke sex kar.
alter table student1
rename column gender to sex;

-- age column delete kar (sirf query likhni hai).
alter table student1
drop column age;

/* pune_students naam ka VIEW bana jo:
sirf Pune city ke students dikhaye
columns: id, name, marks */
create view pune_student as
select id, name, marks
from student1
where city = "Pune";

select * from pune_student;

/* high_scorers naam ka VIEW bana:
jinke marks ≥ 85
sirf name, marks */
create view high_scorers as
select name, marks
from student1
where marks > 85;
select * from high_scorers;

/* female_students naam ka VIEW bana:
jinka sex = 'F'
id, name, city */
create view femal_student as
select id, name, city
from student1
where sex = "F";
select * from femal_student;

/* top_students naam ka VIEW bana:
marks descending order
sirf name, marks */
create view top_student as 
select name, marks
from student1
order by marks desc;
select * from top_student;

/* mumbai_students naam ka VIEW bana:
city = Mumbai
marks ≥ 70
name, marks, phone */
create view mumbai_students as 
select name, marks, phone
from student1
where marks > 70;

/* public_view naam ka VIEW bana:
no marks, no phone
sirf name, city */
create view public_view as 
select name, city
from student1;
select * from public_view;

/* young_students naam ka VIEW bana:
age < 22
id, name, age */
create view youngest_students as
select id, name, age
from student1
where age < 22;
select * from youngest_students;

-- high_scorers VIEW ko delete kar.
drop view high_scorers;

-- pune_students VIEW ka data dekhne ki query likh.
drop view pune_student;

/* public_view VIEW ko replace kar:
ab sirf Mumbai ke students dikhe */
create or replace view public_view as
select name, city from student1
where city = "Mumbai";

select name from student1
where name > 1;


 










