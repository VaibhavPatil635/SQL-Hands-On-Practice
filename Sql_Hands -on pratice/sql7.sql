create database join_data;
use join_data;

drop database dep;

CREATE TABLE departments (
    dep_id INT PRIMARY KEY,
    dep_name VARCHAR(50),
    location VARCHAR(50)
);

INSERT INTO departments VALUES
(101, 'HR', 'Pune'),
(102, 'IT', 'Mumbai'),
(103, 'Finance', 'Delhi'),
(104, 'Marketing', 'Bangalore'),
(105, 'Operations', 'Hyderabad');

select * from departments;
CREATE TABLE employees (
    emp_id INT PRIMARY KEY,
    emp_name VARCHAR(50),
    salary INT,
    dep_id INT,
    FOREIGN KEY (dep_id) REFERENCES departments(dep_id)
);

INSERT INTO employees VALUES
(1, 'Ram', 25000, 101),
(2, 'Shyam', 30000, 101),
(3, 'Vaibhav', 40000, 102),
(4, 'Adi', 45000, 103),
(5, 'Tej', 50000, 104),
(6, 'Karan', 35000, 102),
(7, 'Siali', 27000, NULL);
select * from employees;

CREATE TABLE projects (
    proj_id INT PRIMARY KEY,
    proj_name VARCHAR(100),
    dep_id INT,
    FOREIGN KEY (dep_id) REFERENCES departments(dep_id)
);

INSERT INTO projects VALUES
(201, 'Payroll System', 101),
(202, 'Website Dev', 102),
(203, 'Audit Tool', 103),
(204, 'Market Survey', 104);
select * from projects;

select emp_name , dep_name
from employees as e
join departments as d
on e.dep_id = d.dep_id;

select emp_name , dep_name
from employees as e
left join departments as d
on e.dep_id = d.dep_id;

select dep_name, emp_name
from employees as e
right join departments as d
on e.dep_id = d.dep_id;

select emp_name, dep_name, proj_name
from employees as e
join departments as d
on e.dep_id = d.dep_id             
join projects as p
on d.dep_id = p.dep_id;

select proj_name , emp_name
from projects as p
join employees as e
on p.dep_id = e.dep_id;

select emp_name, salary, location
from employees as e
join departments as d
on e.dep_id = d.dep_id
where location = 'mumbai';

select emp_name, dep_name
from employees as e
join departments as d
on e.dep_id = d.dep_id
join projects as p
on d.dep_id = p.dep_id
where salary >= 35000 and proj_name = 'Website Dev';

select emp_name, dep_name, emp_id
from employees as e
left join departments as d
on d.dep_id = e.dep_id
where e.emp_id is null;

-- 1
select emp_name, dep_name, location
from employees as e
join departments as d
on e.dep_id = d.dep_id;

select emp_name, dep_name, salary
from employees as e
join departments as d
on e.dep_id = d.dep_id
where salary > 30000 and dep_name != 'hr';

select dep_name, location, proj_name
from employees as e
join departments as d
on e.dep_id = d.dep_id
join projects as p
on p.dep_id = d.dep_id
where location = 'mumbai';

select dep_name, count(emp_name)
from employees as e
join departments as d
on d.dep_id = e.dep_id
group by dep_name;

select emp_name, proj_name
from employees as e
left join departments as d
on e.dep_id = d.dep_id
left join projects as p
on p.dep_id = d.dep_id;

select proj_name, dep_name, emp_name
from departments as e
left join employees as d
on e.dep_id = d.dep_id
right join projects as p
on p.dep_id = d.dep_id;

select proj_name, emp_name, salary
from employees as e
right join departments as d
on  e.dep_id = d.dep_id
right join projects as p
on  p.dep_id = d.dep_id;

select emp_name, dep_name, max(salary)
from employees as e
join departments as d
on e.dep_id = d.dep_id
group by dep_name;

SELECT e.emp_name, d.dep_name, e.salary
FROM employees AS e
right join departments AS d
ON e.dep_id = d.dep_id
WHERE e.salary = (
    SELECT MAX(salary)
    FROM employees
    WHERE dep_id = d.dep_id
)
union
SELECT e.emp_name, d.dep_name, e.salary
FROM employees AS e
left join departments AS d
ON e.dep_id = d.dep_id
WHERE e.salary = (
    SELECT MAX(salary)
    FROM employees
    WHERE dep_id = d.dep_id
);

select dep_name, emp_name, proj_name
from employees as e
join departments as d
on e.dep_id = d.dep_id
join projects as p
on p.dep_id = d.dep_id
where dep_name = proj_name = 'Audit Tool' and 'Market Survey';

