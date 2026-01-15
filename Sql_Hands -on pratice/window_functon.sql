use b1011;

CREATE TABLE orders (
    order_id INT,
    customer_id INT,
    state VARCHAR(20),
    order_date DATE,
    total_order_value INT
);
INSERT INTO orders VALUES
(1, 101, 'Maharashtra', '2024-01-05', 1200),
(2, 102, 'Maharashtra', '2024-01-06', 3000),
(3, 101, 'Maharashtra', '2024-01-10', 1500),
(4, 103, 'Gujarat',     '2024-01-07', 2000),
(5, 104, 'Gujarat',     '2024-01-09', 2500),
(6, 103, 'Gujarat',     '2024-01-15', 1800),
(7, 105, 'Delhi',       '2024-01-08', 2200),
(8, 105, 'Delhi',       '2024-01-18', 2700),
(9, 106, 'Delhi',       '2024-01-20', 3200),
(10,101, 'Maharashtra', '2024-02-05', 4000),
(11,102, 'Maharashtra', '2024-02-06', 2800),
(12,103, 'Gujarat',     '2024-02-07', 3500),
(13,104, 'Gujarat',     '2024-02-10', 4200),
(14,105, 'Delhi',       '2024-02-12', 3900),
(15,106, 'Delhi',       '2024-02-15', 4100);

select * from orders;


select order_id, total_order_value,
sum(total_order_value) over() as total_sales
from orders;

select order_id, customer_id, state, total_order_value,
sum(total_order_value) over(partition by state) as state_wise_total_sales
from orders;

select customer_id, order_id, state, order_date, total_order_value,
row_number() over(partition by customer_id order by order_date) as row_numbers
from orders;

with previous as (
select customer_id, order_id, total_order_value, order_date,
lag(total_order_value) over(partition by customer_id order by order_date) as previous_order_amount
from orders
)
select *, previous_order_amount - total_order_value as diffiernt
from previous;

with top as(
select customer_id, state, 
sum(total_order_value) as total_sales,
dense_rank() over(partition by state order by sum(total_order_value) desc) as rnk
from orders
group by state, customer_id
)
select * from top
where rnk <= 2;


select state, sum(total_order_value) as total_sales,
dense_rank() over(partition by state order by sum(total_order_value)) as rnk
from orders
group by state,customer_id;


with base as(
select customer_id, state, sum(total_order_value) as total_sales
from orders
group by state,customer_id
),
top as(
select *,
dense_rank() over(partition by state order by total_sales desc) as rnk,
sum(total_sales) over(partition by state) as state_wise
from base
)
select * from top
where rnk <= 2;           

select customer_id, order_id, order_date,
min(order_date) over(partition by customer_id) as first_order
from orders;


select customer_id, order_id, order_date,
dense_rank()over(
partition by customer_id 
order by order_date desc
) as latest_to_oldest
from orders;

with base as(
select customer_id, order_id, order_date, total_order_value,
lag(total_order_value) over(
partition by customer_id
order by order_date
) as previous_order_sales
from orders
)
select *,
case when previous_order_sales is null then null
	 when previous_order_sales = 0 then	null
else concat(
             round(
            (total_order_value - previous_order_sales)
            / previous_order_sales * 100,
        2),
        '%') 
 end as per_change
from base;



with customer_sales as(
select customer_id,
       state,
       sum(total_order_value) as customer_total
from orders
group by customer_id, state
),

ranked_customers as(
select state,
	customer_id,
    customer_total,
dense_rank() over(
partition by state order by customer_total desc
) as rnk
from customer_sales
),

state_sales as (
select state,
sum(total_order_value) as state_total
from orders
group by state
)

select r.state,
	   r.customer_id,
       r.customer_total,
       s.state_total,
       concat(round(r.customer_total/s.state_total*100,2),"%") as contribution_pct
from ranked_customers r
join state_sales s
on s.state = r.state
;

select customer_id, order_id, order_date,total_order_value,
avg(total_order_value) over(partition by customer_id
order by order_date
rows between 2 preceding and current row) as moving_avg
from orders;


with state_sales as(
select state, customer_id, sum(total_order_value) as total_sales
from orders
group by state, customer_id
), 
ranked_customers as(
select state, customer_id, total_sales,
dense_rank() over(partition by state order by total_sales desc) as rnk
from state_sales
)
select state,customer_id,total_sales
from ranked_customers
where rnk = 2;

select customer_id, state,



       

