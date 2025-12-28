create database ECOMMERCE;
use ecommerce;
CREATE TABLE customers (
    customer_id INT PRIMARY KEY,
    customer_name VARCHAR(100),
    email VARCHAR(100),
    city VARCHAR(50),
    join_date DATE
);

INSERT INTO customers VALUES
(1, 'Amit Sharma', 'amit@gmail.com', 'Mumbai', '2022-01-10'),
(2, 'Priya Singh', 'priya@gmail.com', 'Delhi', '2021-11-15'),
(3, 'Rohit Patil', 'rohit@gmail.com', 'Bangalore', '2022-03-20'),
(4, 'Neha Verma', 'neha@gmail.com', 'Pune', '2021-09-05'),
(5, 'Karan Mehta', 'karan@gmail.com', 'Hyderabad', '2022-04-01');

select * from customers;

CREATE TABLE categories (
    category_id INT PRIMARY KEY,
    category_name VARCHAR(50)
);

INSERT INTO categories VALUES
(10, 'Electronics'),
(11, 'Fashion'),
(12, 'Home Appliances'),
(13, 'Beauty'),
(14, 'Sports');

CREATE TABLE products (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(100),
    price INT,
    category_id INT,
    FOREIGN KEY (category_id) REFERENCES categories(category_id)
);

INSERT INTO products VALUES
(101, 'iPhone 14', 70000, 10),
(102, 'Samsung TV', 40000, 12),
(103, 'Nike Shoes', 6000, 11),
(104, 'Mixer Grinder', 3500, 12),
(105, 'Sports Watch', 5500, 14),
(106, 'Lipstick Set', 1200, 13),
(107, 'Laptop HP', 55000, 10);

CREATE TABLE orders (
    order_id INT PRIMARY KEY,
    customer_id INT,
    order_date DATE,
    status VARCHAR(20),
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);

INSERT INTO orders VALUES
(5001, 1, '2023-01-02', 'Delivered'),
(5002, 3, '2023-01-05', 'Delivered'),
(5003, 2, '2023-01-08', 'Cancelled'),
(5004, 4, '2023-01-10', 'Delivered'),
(5005, 5, '2023-01-12', 'Shipped');

CREATE TABLE order_items (
    item_id INT PRIMARY KEY,
    order_id INT,
    product_id INT,
    quantity INT,
    FOREIGN KEY (order_id) REFERENCES orders(order_id),
    FOREIGN KEY (product_id) REFERENCES products(product_id)
);

INSERT INTO order_items VALUES
(1, 5001, 101, 1),
(2, 5001, 103, 2),
(3, 5002, 102, 1),
(4, 5003, 104, 1),
(5, 5004, 105, 3),
(6, 5005, 107, 1);	

CREATE TABLE payments (
    payment_id INT PRIMARY KEY,
    order_id INT,
    amount INT,
    method VARCHAR(20),
    payment_date DATE,
    FOREIGN KEY (order_id) REFERENCES orders(order_id)
);

INSERT INTO payments VALUES
(9001, 5001, 82000, 'UPI', '2023-01-02'),
(9002, 5002, 40000, 'Credit Card', '2023-01-05'),
(9003, 5004, 16500, 'Debit Card', '2023-01-10'),
(9004, 5005, 55000, 'UPI', '2023-01-12');

-- 1. Kaunse city ka total revenue sabse zyada hai?
select c.city, sum(p.amount)
from customers as c
left join orders as o on
c.customer_id = o.customer_id
left join payments as p on
p.order_id = o.order_id
group by city;

-- 2. Top 3 products by total sales amount
select p.product_name, sum(p1.amount) as total_amount
from products as p
join order_items as o on
p.product_id = o.product_id
join payments as p1 on
p1.order_id = o.order_id
group by p.product_name
order by total_amount desc limit 3;

-- 3. Kitne orders cancel hue?
select p.product_name,o.status
from products as p
join order_items as o1 on
p.product_id = o1.product_id
join orders as o  on
o.order_id = o1.order_id
where o.status = 'Cancelled';

-- 4. January month me kis category ki highest sales hui?-- 
select c.category_name, sum(amount) as total_sales from categories as c
join products as p on
c.category_id = p.category_id
join order_items as o on
o.product_id = p.product_id
join payments as p1 on
p1.order_id = o.order_id
where payment_date
between '2023-01-01' and '2023-01-31'
group by c.category_name
order by total_sales desc
limit 1
;

--  5. Customer-wise total spending
select c.customer_name, sum(amount) from customers as c
join orders as o on
o.customer_id = c.customer_id
join payments as p on
p.order_id = o.order_id
group by c.customer_name;

-- 6. Which product is most frequently ordered? 
select product_name, quantity 
from products as p
join order_items as o 
on p.product_id = o.product_id
order by quantity
desc limit 1;

-- 7. Payment method-wise total revenue
select method, sum(amount) 
as total_revenue 
from payments
group by method;

-- 8. Orders with multiple items
select order_id, count(*) 
as total_item 
from order_items 
group by order_id
having count(*) > 1;

-- 9. City-wise customer count 
select city, count(*)
as customer_total
from customers
group by city;

-- 10. Order with highest amount
select o.order_id,sum(amount) 
as highest_amount
from order_items as o
join payments as p
on o.order_id = p.order_id
group by o.order_id
order by highest_amount desc 
limit 1;

SELECT o.order_id,
       SUM(oi.quantity * p.price) AS total_amount
FROM orders o
JOIN order_items oi ON o.order_id = oi.order_id
JOIN products p ON p.product_id = oi.product_id
GROUP BY o.order_id
ORDER BY total_amount DESC
LIMIT 1;

SELECT 
    c.city,
    cat.category_name,
    SUM(p.amount) AS total_revenue
FROM customers AS c
JOIN orders AS o 
    ON c.customer_id = o.customer_id
JOIN payments AS p 
    ON p.order_id = o.order_id
JOIN order_items AS oi
    ON oi.order_id = o.order_id
JOIN products AS pr
    ON pr.product_id = oi.product_id
JOIN categories AS cat
    ON cat.category_id = pr.category_id
GROUP BY c.city, cat.category_name
ORDER BY c.city, total_revenue DESC;

-- 2️ Customer who bought maximum different categories
select c.customer_name,
count(distinct c1.category_id)
as category_count
from customers as c
join orders as o 
on c.customer_id = o.customer_id
join order_items as oi
on oi.order_id = o.order_id
join products as p 
on p.product_id = oi.product_id
join categories as c1 
on c1.category_id = p.category_id
group by c.customer_id;

-- 3 Category-wise average purchase amount
select c.category_id,c.category_name, 
avg(p.amount * oi.quantity) as average_purchase_amount
from categories as c
join products as p1
on c.category_id = p1.category_id
join order_items as oi
on oi.product_id = p1.product_id
join payments as p
on p.order_id = oi.order_id
group by c.category_id;


SELECT 
    c.category_id,
    c.category_name,
    AVG(oi.quantity * p1.price) AS average_purchase_amount
FROM categories AS c
JOIN products AS p1
    ON c.category_id = p1.category_id
JOIN order_items AS oi
    ON oi.product_id = p1.product_id
JOIN orders AS o
    ON oi.order_id = o.order_id
JOIN payments AS pay
    ON pay.order_id = o.order_id
GROUP BY c.category_id, c.category_name;

