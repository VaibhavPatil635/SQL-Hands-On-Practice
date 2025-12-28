create database b1011;
use b1011;
create table emp(id int primary key, name varchar(50),city varchar(30));
insert into emp values(1,"vaibhav","dhule"),
(2,"ram","dapura"),
(3,"sham","dhanur");
select * from emp;


create table student(
roll_no int primary key,
name varchar(50),
mark float);

insert into student (roll_no,name,mark)values
(21,"vai",56),
(22,"adi",57),
(23,"tej",58),
(24,"maya",68);

select * from student where 56 < mark;
select * from student where 68 > mark;

create table students(
id int primary key,
name varchar(50),
marks int,
age int
);

insert into students(id, name, percentage)
values
(1,'vai',68),
(2,'tej',98),
(3,'adi',66),
(4,'ram',78.45);

select * from students;

alter table students
add column emil varchar(100);

alter table students
rename column marks to percentage;

alter table students
drop column age;

alter table students
modify column name varchar(100);

select * from students;

alter table students
add column city varchar(50) default 'pune';

alter table students
add gender varchar(20),
add dob date;

alter table students
modify percentage float;

alter table students
alter city set default 'unknown';

alter table students
drop column dob,
drop column gender;

select * from students;

create table course(
course_id int,
course_name varchar(50),
foreign key (course_id) references students(course_id)
);
drop table course;

insert into course (course_id, course_name)
values
(102,'ml');
select * from course;

alter table students
add column course_id int unique ;

alter table students
drop column course_id;

rename table 
students 
to
student_info;

select * from student_info;

create table emp_sla(
id int primary key,
name varchar(50),
sal int check (sal <= 50000)
);

INSERT INTO emp_sla VALUES (1, 'Rahul', 30000);
INSERT INTO emp_sla VALUES (2, 'Priya', 45000);
INSERT INTO emp_sla VALUES (3, 'Amit', 50000);
INSERT INTO emp_sla VALUES (4, 'Neha', 25000);
INSERT INTO emp_sla VALUES (5, 'Karan', 10000);
insert into emp_sla values(6, 'vaibhav', 60000);
select * from emp_sla;









