-- https://dbfiddle.uk/3aMmxpPT

-- check MySQl version
select version();

-- see which database I'm currently work upon
select database();

-- create new database
create database if not exists techwithpriya;
use techwithpriya;
select database();

-- display all available databases
show databases;

-- employees table
create table employees (
	id int primary key auto_increment,
	first_name varchar(50) not null,
	last_name varchar(50) not null,
	age int not null,
	salary int not null,
	address varchar(100) not null
);

-- description of the table
desc employees;

-- display all available tables inside a particular database
show tables;

-- delete/drop a table
drop table employees;

-- insert data into table employees
insert into employees(first_name, last_name, age, salary, address) values
	("John", "Snow", 28, 100000, "Bhopal"),
	("Vivek", "Kumar", 30, 50000, "Mumbai");

select * from employees;

-- retrieve employees first and last name
select first_name, last_name from employees;

-- 3 max salary employees
select * from employees order by salary desc limit 3;

-- update table record
update employees set address="Pune" where id=1;

-- delete a record
delete from employees where id=1;

-- DDL (data defination language)
	-- drop, alter, add commands
-- DML (data manipulation language)
	-- update, delete, insert commands

-- update is used to change the record inside a particular table
-- alter is used to change the schema of the table

alter table employees modify first_name varchar(100);

-- add a new column
alter table employees add position varchar(100);

-- delete a specfic column
alter table employees drop column position;

-- count all employees
select count(id) as employees from employees;

-- max salary
select max(salary) as max_salary_employee from employees;

-- course table
create table courses (
	id int primary key auto_increment,
	name varchar(50) not null,
	duration int not null,
	fee int not null
);

-- sourceOfJoining table
create table sojs (
	id int primary key auto_increment,
	title varchar(50) not null
);

-- learner table
create table learners (
	id int primary key auto_increment,
	first_name varchar(50) not null,
	last_name varchar(50) not null,
	phone varchar(15) not null,
	email varchar(20) unique key,
	enroll_date date not null default (current_date),
	course int not null,
	experience int not null,
	company varchar(50),
	batch_start_date timestamp not null,
	source_of_join int not null,
	location varchar(50) not null,

	foreign key (course) references courses(id),
	foreign key (source_of_join) references sojs(id)
);

desc learners;

-- insert record into courses
insert into courses(name, duration, fee) values
	("Excel Mastery", 1, 999),
	("DSA for Interview Prep", 2, 8999),
	("SQL Bootcamp", 7, 2999);

show tables;

select * from courses;

-- change/modify the table columns
alter table courses change fee fees int not null;
alter table learners modify experience decimal(10, 2);

-- insert record for source of joining
insert into sojs (title) values
	("YouTube"),
	("WhatsApp"),
	("Linkedin"),
	("Ads"),
	("Colleauges");

-- change email varchar
alter table learners modify email varchar(100) not null;

-- insert record for learners
insert into learners (first_name, last_name, phone, email, course, experience, company, batch_start_date, source_of_join, location) values
	("Akhil", "George", "99800857", "akhil.george.87435@gmail.com", 1, 0, "Amazon", "2024-01-16", 2, "Mumbai"),
	("Rishikesh", "Joshi", "99800957", "carjakop@yahoo.com", 2, 2.0, "Google", "2024-01-16", 2, "Pune"),
	("Maduram", "Ravichandran", "99858288", "ravichandran.madhuram@gmail.com", 1, 1.5, "Google", "2024-02-29", 2, "Rajpur"),
	("Jeevan", "Hedge", "9874562", "jeevanheadgfe@gmail.com", 1, 1, "MediaSoft", "2024-03-25", 4, "Jodhpur"),
	("Sidhish", "Kumar", "98741235", "kumarsidish789@gmail.com", 1, 3.5, "TYC", "2024-03-25", 1, "Delhi"),
	("Ram", "Bharma", "99808857", "ramgolpal@gmail.com", 1, 4.5, "Netflix", "2024-01-16", 3, "Udaypur"),
	("Naga", "Sai", "99889857", "nagasairty@gmail.com", 1, 0, "Facebook", "2024-02-29", 3, "Delhi");

-- ====== queries ======

-- 1. Give me the records of employee getting highest salary
select * from employees order by salary desc limit 1;
-- flow => from -> select -> order by -> limit

-- 2. give me the record of the employee getting highest salary and age is bigger than 25
select * from employees where age > 25 order by salary desc limit 1 offset 1;
-- flow => from -> where -> select -> order by -> limit

-- 3. display number of enrollments 
select count(id) as enrolls from learners;

-- 4. display the number of enrollments for the course "SQL Bootcamp"
select count(id) as sql_enrolls from learners where course=3;

-- 4.x display the number of enrollments for the course "Excel Mastery"
select count(id) as excel_enrolls from learners where course=1;

-- 5. count number of enrollments in the month of april
select count(id) as num_of_april_enrolls from learners where enroll_date like "%2024%-%04%-%"

-- 5.x count number of enrollments in the month of feb
select count(id) as num_of_feb_enrolls from learners where enroll_date like "%2024%-%04%-%"

-- 6. count the number of companies user belongs to
select count(distinct company) from learners;

-- 7. Count the number of students who joined the course via linkedin, YouTube or Community
select source_of_join, count(id) as enrolled_students from learners group by source_of_join;

-- 8. Corresponding to each course, how many students have joined
select course, count(*) as students from learners group by course;

-- 8. Corresponding to source of joining give me the max years of experience any person hold
select source_of_join, max(experience) as max_experience from learners group by source_of_join;

-- 9. Display the courses which doesn't include word "Excel"
select * from courses where name not like "Excel";

-- 10. Display the records of those student who have less than 4 years of experience and source of joining is WhatsApp
select * from learners where experience < 4 and source_of_join=2;

-- 11. Display the records of those who have experices between 1 and 3 years
select * from learners where experience between 1 and 3;

-- Update the SQL Bootcamp course fees to 3999
update courses set fees=3999 where id=3;

-- 12. For each address, what is the count of each employee and avg salary of the employee in those address.
select address, count(*) as total, avg(salary) as avg_salary from employees group by address;

-- 13. For each address, what is the count of each employee and avg salary of the employee in those address, but also display firstName and lastName corresponding to each record
-- default join is inner join
select first_name, last_name, employees.address, total, avg_salary from employees join (select address, count(*) as total, avg(salary) as avg_salary from employees group by address) as temp on employees.address=temp.address;

-- optimize queries
select first_name, last_name, address, count(address) over (partition by address) as total, avg(salary) over (partition by address) as avg_salary from employees;

-- leetcode 181
select emp1.name as Employee from employees as emp1 join employees as emp2 on emp1.managerId = emp2.id and emp1.salary > emp2.salary;

--14. which course has the highest enrollments
select course, count(id) as enrollment_counts from learners group by course order by enrollment_counts desc limit 1;

-- case statements in SQL
	-- case
		-- when condition then text
		-- else text
	-- end as alias name
-- create a new column name "fee_status" based on
	-- fee > 3999 => Expensive
	-- fee > 1499 => Moderate
	-- else > Cheap
select id, name, fee, 
	case 
		when fee > 3999 then "Expensive"
		when fee > 1499 then "Moderate"
		else "Cheap"
	end as fee_status
from courses;

-- case expressions in SQL
-- type: premium, plus, regular
select id, name, fee,
	case fee
		when 8999 then "Premium"
		when 2999 then "plus"
		else "Regular"
	end as type
from courses;

-- common table expressions
	-- useful for when dealing with complex queries

-- new table status
create table payment_status (
	id int primary key auto_increment,
	title varchar(20) not null
);

insert into payment_status (title) values 
	("Completed"),
	("Pending"),
	("Canceled");

-- new table orders
create table orders (
	id int primary key auto_increment,
	payment_date date not null default (current_date),
	student int not null,
	status int not null,

	foreign key(student) references learners(id),
	foreign key(status) references payment_status(id)
);

insert into orders(payment_date, student, status) values 
	('2024-02-01', 1, 1),
	('2024-01-15', 2, 3),
	('2024-01-10', 3, 2),
	('2024-02-02', 4, 1),
	('2024-02-05', 5, 1),
	(current_date, 6, 3);

-- total orders per student
select student, count(id) as total_orders from orders group by student;

-- total orders per student whose status is completed
select student, count(id) as total_orders from orders where status=1  group by student;

-- total orders per student along with their name
select student, first_name, last_name, count(orders.id) as total_orders from orders join learners on orders.id=learners.id group by student, first_name, last_name;

-- optimized
select student, temporary.first_name, temporary.last_name, count(orders.id) as total_orders from orders join (select id, first_name, last_name from learners) as temporary on orders.id=temporary.id group by student, temporary.first_name, temporary.last_name;

-- added status also
select student, first_name, last_name, title, count(orders.id) as total_orders from orders join learners on orders.id=learners.id join payment_status on orders.id=payment_stauts.id group by student, first_name, last_name, title;
-- or
select student, first_name, last_name, count(orders.id) as total_orders, title from orders join learners on orders.id=learners.id join payment_status on orders.id=payment_stauts.id group by student, first_name, last_name, title;
