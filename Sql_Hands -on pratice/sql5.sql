create database sales;
use sales;
-- Step 1️⃣: Table create karo
CREATE TABLE sales (
    id INT PRIMARY KEY,
    product VARCHAR(50),
    category VARCHAR(50),
    price INT,
    quantity INT,
    city VARCHAR(50)
);

-- Step 2️⃣: Data insert karo
INSERT INTO sales (id, product, category, price, quantity, city) VALUES
(1, 'Laptop', 'Electronics', 55000, 2, 'Delhi'),
(2, 'Phone', 'Electronics', 30000, 4, 'Mumbai'),
(3, 'Chair', 'Furniture', 2500, 10, 'Pune'),
(4, 'Table', 'Furniture', 4000, 5, 'Pune'),
(5, 'TV', 'Electronics', 45000, 3, 'Delhi'),
(6, 'Sofa', 'Furniture', 15000, 2, 'Mumbai'),
(7, 'AC', 'Electronics', 35000, 1, 'Delhi'),
(8, 'Fan', 'Electronics', 2000, 12, 'Pune'),
(9, 'Bed', 'Furniture', 18000, 1, 'Mumbai'),
(10, 'Lamp', 'Decor', 1200, 8, 'Delhi');

select * from sales;

select product, price from sales where price > 10000;

select * from sales where city = "pune" order by price desc;

select * from sales order by quantity desc limit 3;

select category, count(product) from sales group by category;

select category, avg(price) from sales group by category;

select city, sum(quantity) from sales group by city;

select category, sum(quantity) from sales group by category having SUM(quantity) > 10;

select city, max(price) from sales group by city;

select category, sum(price * quantity) from sales group by category ;

SELECT category, 
       SUM(price * quantity) AS total_sales
FROM sales
GROUP BY category;

select * from sales where quantity between 2 and 8 and city = 'mumbai';

select product, avg(price) from sales group by product having avg(price) > 20000;

select product, min(price) from sales group by product;

select * from sales where city != 'delhi';

select * from sales where category = 'electronics' order by price desc limit 2;

select category, count(product), sum(quantity) from sales group by category;

select * from sales where price > 20000 and city = 'delhi';

select * from sales order by quantity desc;

select city, sum(quantity) from sales group by city;

select category, avg(price) from sales group by category;

select category, avg(price) from sales group by category having avg(price) > 10000;

select * from sales order by price desc limit 3;

select category, count(product) from sales group by CATEGORY;

select category, sum(price * quantity) from sales group by category;

select city, sum(quantity) from sales group by city having sum(quantity) > 10;

select category, min(price) from sales group by category;


