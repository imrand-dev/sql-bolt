-- https://dbfiddle.uk/5A9fDGNy

-- check version
select version();

-- import `schemas/create-database.sql` file
show databases;
show tables;

-- select all customers
select * from customers;

-- select specfic column
select * from customers where customer_id=2;

-- sort by first_name
select * from customers order by first_name;
select * from customers order by first_name desc;

-- update state for id=1 on purpose
update customers set state='VA' where customer_id=1;

-- select all customers state
select state from customers;

-- without duplicate
select distinct state from customers;

-- Exercise
	-- return all the products
		-- name
		-- unit_price
		-- unit_price * 1.1 as new new_price
select name, unit_price, unit_price * 1.1 as new_price from products;

-- where clause
select * from customers where points > 3000;
select * from customers where state="VA";

-- all customers except Virgnia
select * from customers where state != "VA";
select * from customers where state <> "VA";
select * from customers where state not like "%VA%";

-- customers born after 1st January of 1990
select * from customers where birth_date > "1990-01-01";

-- Exercise
	-- get the orders placed current year
select * from orders where order_date > "2017-01-01" and order_date < "2017-12-31";
select * from orders where order_date between "2017-01-01" and "2017-12-31";
selct * from orders where year(order_date) = year(now());

-- condition applied (both return same result)
select * from customers where birth_date <= "1990-01-01" and points <= 1000;
select * from customers where not(birth_date > "1990-01-01" or points > 1000);

-- Exercise
	-- from the order_items table, get the items
		-- for order #6 where total price is  > 30
select * from order_items where order_id=6 and quantity*unit_price > 30;

-- IN Operator
select * from customers where state in ("VA", "GA", "FL");
select * from customers where state not in ("VA", "GA", "FL");

-- Exercise
	-- return products with
		-- quantity in stock equal to 49, 38, 72
select * from products where quantity_in_stock in (49, 72, 38);

-- between clause
select * from customers where points between 1000 and 3000;
select * from customers where points >= 1000 and points <= 3000;

-- Exercise
	-- return customers born between 1/1/1990 and 1/1/2000
select * from customers where birth_date between "1990-01-01" and "2000-01-01";

-- like operator
-- _ single character
-- % any number of characters
select * from customers where last_name like "b%"; -- any last name that starts with b and followed by any number of characters.
select * from customers where last_name like "%b%"; -- b in the middle/last/first
select * from customers where last_name like "%y"; -- ends with y
select * from customers where last_name like "_y"; -- exact 2 characters name 1st char can be anything but last char must be y

-- Exercise
	-- get the customers whose
		-- address contain trail or avenue
select * from customers where (address like "%Trail%" or address like "%avenue%");
	-- phone number's last digit is 9
select * from customers where phone like "%9";

-- better version of like regexp
select * from customers where phone regexp "^9"; -- starts with 9
select * from customers where phone regexp "9$"; -- ends with 9

select * from customers where last_name regexp "field|mac|rose";

-- Exercises
-- get the customers whose	
	-- first names are elka or ambur
select * from customers where first_name in ("elka", "ambur");
select * from customers where first_name regexp "elka|ambur";
	-- last name ends with ey or on
select * from customers where last_name regexp "ey$|on$";
select * from customers where last_name like "%ey" or last_name like "%on";
	-- last names start with my or contains se
select * from customers where last_name like "my%" or last_name like "%se%";
select * from customers where last_name regexp "^my|se";
	-- last names contains B followed by r or u
select * from customers where last_name like "%br%" or last_name like "%bu%";
select * from customers where last_name regexp "b[r|u]";

-- IS operator
select * from customers where phone is null;
select * from customers where phone is not null;

-- Exercise
	-- get the orders that are not shipped
select * from orders where shipped_date is null;

-- order by
select * from customers order by last_name desc;

-- Exercise
select * from order_items where order_id=2 order by quantity*unit_price desc; 

-- limit clause
select * from customers order by customer_id asc limit 3 offset 6;
select * from customers order by customer_id asc limit 6 offset 3;

-- Exercise
	-- top 3 loyel customers
select * from customers order by points desc limit 3;

-- Inner join
select * from orders join customers on orders.customer_id = customers.customer_id;
select order_id, orders.customer_id, first_name, last_name from orders join customers on orders.customer_id = customers.customer_id;

-- Exercise
select order_id, products.product_id, name, quantity, order_items.unit_price from order_items inner join products on order_items.product_id=products.product_id;

-- Join tables accross databases
select order_id, p.product_id, name, quantity, order_items.unit_price from order_items inner join sql_inventory.products as p on order_items.product_id=p.product_id;

-- self join
use sql_hr;
select e.employee_id, e.first_name, e.last_name, m.first_name as manager from employees e join employees m on e.reports_to=m.employee_id;

-- multiple join
select o.order_id, o.order_date, c.first_name, c.last_name, os.name as status from orders as o inner join customers as c on o.customer_id=c.customer_id inner join order_statuses as os on o.status=os.order_status_id;

-- Compound Join Conditions
select * from order_items as oi join order_item_notes as oin 
on oi.order_id=oin.order_id and oi.product_id=oin.product_id;

-- Explicit join
select * from customers join orders on orders.customer_id=customers.customer_id;
select * from customers join orders using (customer_id); -- alternate of ON
-- Implicit Join
select * from customers, orders where orders.customer_id=customers.customer_id;

-- Outer (left/right) Join
select customers.customer_id, orders.order_id, first_name, last_name from customers left join orders on orders.customer_id=customers.customer_id;

-- Exercise
select products.product_id, products.name, order_items.quantity from products left join order_items on products.product_id=order_items.product_id;

-- natural join joins 2 tables based on the common column name
select * from orders natural join customers;

-- cross join (every record from left table joins with every record from right join)

-- union
select first_name from customers union select name from shippers;

-- Exercise
select customer_id, first_name, points, "Bronze" as type from customers where points < 2000
union 
select customer_id, first_name, points, "Silver" as type from customers where points between 2000 and 3000
union
select customer_id, first_name, points, "Gold" as type from customers where points > 3000
order by first_name asc;

-- Insert 3 rows in the products table
insert into products (name, quantity_in_stock, unit_price) values
	("Coconat Oil", 4, 1.89),
	("Breads", 10, 10),
	("Drink", 1, 30);

-- Insert data into multiple table (parent/child)
insert into orders (customer_id, order_date, status) values 
	(10, "1990-02-01", 1);
insert into order_items(order_id, product_id, quantity, unit_price) values 
	(last_insert_id(), 1, 2, 2.95);

-- copy data from one table to another (soft copy)
-- https://popsql.com/learn-sql/mysql/how-to-duplicate-a-table-in-mysql
create table orders_archived as
select * from orders;

-- copy specfic records
insert into orders_archived select * from orders where order_date < "2019-01-01";

-- Delete a record
delete from invoices where invoice_id=1;

-- Update a record
update products set name="Soft drink" where product_id=12;

-- Exercise
use sql_invoicing;
create table invoices_archived as 
select inv.invoice_id, inv.number, c.name as client, inv.invoice_total, inv.payment_total, inv.invoice_date, inv.due_date, inv.payment_date
from invoices as inv
inner join clients as c using (client_id);

-- Exercise
select 
  "First half of 2019" as date_range, 
  sum(invoice_total) as total_sales, 
  sum(payment_total) as total_payments, 
  sum(invoice_total - payment_total) as what_to_expect
from invoices
  where invoice_date between "2019-01-01" and "2019-06-30";
union
select 
  "Second half of 2019" as date_range, 
  sum(invoice_total) as total_sales, 
  sum(payment_total) as total_payments, 
  sum(invoice_total - payment_total) as what_to_expect
from invoices
  where invoice_date between "2019-07-01" and "2019-12-31";
union
select 
  "Total" as date_range, 
  sum(invoice_total) as total_sales, 
  sum(payment_total) as total_payments, 
  sum(invoice_total - payment_total) as what_to_expect
from invoices
  where invoice_date between "2019-01-01" and "2019-12-31";

-- where clause filter the data before group by clause, 
-- having clause filter the data after group by clause.
select client_id, sum(invoice_total) as total_sales,
	count(*) as number_of_invoices
from invoices
group by client_id
having total_sales > 500 and number_of_invoices > 5;

-- Exercise
-- Get the customers
	-- located in Virginia
	-- who have spent more than $100
select
	c.customer_id,
	c.first_name,
	c.last_name,
	sum(oi.quantity * oi.unit_price) as total_spent
from customers as c 
join orders as o using (customer_id)
join order_items as oi using (order_id)
where state = "VA"
group by
	c.customer_id,
	c.first_name,
	c.last_name
having total_spent > 100;

-- Rollup (only mysql)
select
	client_id,
	sum(invoice_total) as total_spent
from invoices
group by client_id with rollup;

-- Exercise
-- with rollup, we can't use alias name in group by clause
select name as payment_method, sum(amount) as total 
from payments join payment_methods
on payment_method = payment_method_id
group by name with rollup;

-- ================== Subqueries ================================
-- find all products that are more expensive than lettuce (id=3)
use sql_store;
select * from products where unit_price > (select unit_price from products where product_id=3);

-- Exercise
-- in sql_hr database, find all employees who earn more than average
use sql_hr;
select * from employees where salary > (select avg(salary) from employees);

-- find the products that never been ordered
use sql_store;
select * from products where product_id not in (select distinct product_id from order_items);

-- exercise
-- find clients without invoices
use sql_invoicing;
select * from clients where client_id not in (select distinct client_id from invoices);
-- joining
select c.client_id, c.name, c.address, c.city, c.state, c.phone from clients as c left join invoices as i using(client_id) where i.client_id is null;

-- find cutomers who have ordered lettuce (id=3)
use sql_store;
select customer_id, first_name, last_name from customers where customer_id in (
	select o.customer_id from order_items as oi join orders as o using (order_id) where product_id=3
);
-- joining
select distinct customer_id, first_name, last_name from customers as c
join orders as o using (customer_id)
join order_items as oi using (order_id)
where oi.product_id=3;

-- Select invoices larger than all invoices of client 3
select * from invoices where invoice_total > (select max(invoice_total) from invoices where client_id=3);
-- solve above problem using all
select * from invoices where invoice_total > all (select invoice_total from invoices where client_id=3);

-- select clients with at least 2 invoices
select * from clients where client_id in (select client_id from invoices group by client_id having count(*) >= 2);
-- solve above problem via any
select * from clients where client_id = any (select client_id from invoices group by client_id having count(*) >= 2);

-- select clients that have an invoices
use sql_invoicing;
select * from clients where client_id in (select distinct client_id from invoices);
-- solve via join
select distinct clients.* from clients inner join invoices using (client_id)
-- solve via exists
select * from clients where exists (select client_id from invoices as i where client_id=i.client_id);

-- find the products that have never been ordered
select * from products as p where not exists (select product_id from order_items where product_id=p.product_id);

-- subqueries in select clause
select invoice_id, invoice_total, 
(select avg(invoice_total) from invoices) as invoice_average,
invoice_total - (select invoice_average) as difference
from invoices;

-- ifnull function
use sql_store;
select order_id, ifnull(shipper_id, 'Not assigned') as shipper 
from orders;

-- coalesce function
-- it takes more than 2 arguments, return first non null value
use sql_store;
select order_id, coalesce(shipper_id, 'Not assigned') as shipper 
from orders;

-- exercise
select concat(first_name, ' ', last_name) as customer, ifnull(phone, "Unknown") as phone from customers;

-- if function
select 
	order_id,
	if (year(order_date) = year(now()), "Active", "Archived") as category
from orders;

-- case operator
select 
	order_id,
	case 
		when year(order_date) = year(now()) then "Active"
		when year(order_date) = year(now()) - 1 then "Last year"
		when year(order_date) < year(now()) -1 then "Archived"
	end as category
from orders;

-- ========================= view ===========================
use sql_invoicing;

-- it returns nothing
create or replace view sales_by_client as
select c.client_id, c.name, sum(invoice_total) as total_sales from clients as c
join invoices as i using(client_id)
group by c.client_id, c.name;

-- execute view as normal statement
select * from sales_by_client;

-- drop view
drop view sales_by_client;

-- exercise
-- create a view to see the balance for each client
	-- clients_balance
		-- client_id
		-- name
		-- balance
create view clients_balance as 
	select c.client_id, c.name, sum(invoice_total-payment_total) as balance
	from clients as c  
	join invoices as i using (client_id)
	group by client_id, name;

select * from clients_balance;

-- we can update/delete row from view as well only
	-- if the view doesn't contains
	-- distinct
	-- aggregrate functions
	-- group by / having
	-- union

-- with check option

-- ============= store procedure/custom function ========================
-- it is used to store and organize data

use sql_store;

delimiter $$ -- can be optional
create procedure get_customers()
begin
	select * from customers;
end$$

delimiter ; -- return back to original stage

call get_customers();

-- exercise
-- create a procedure called get_invoices_with_balance 
-- to return all the invoices with balance > 0
use sql_invoicing;
create procedure get_invoices_with_balance()
begin
	select * 
	from invoices 
	where invoice_total - payment_total > 0;
end;

call get_invoices_with_balance();

-- drop procedure
drop procedure if exists get_invoices_with_balance;

-- store procedure with parameters
use sql_invoicing;
drop procedure if exists get_clients_by_state;

create procedure get_clients_by_state(state varchar(5))
begin
  select * from clients as c where c.state=state;
end;

call get_clients_by_state("CA");

-- default value doesn't support by mysql 
-- check them manually
use sql_invoicing;
drop procedure if exists get_clients_by_state;

create procedure get_clients_by_state(state varchar(5))
begin
  if state is null then
  	select * from clients;
	else
		select * from clients as c where c.state=state;
  end if;
end;

-- shorter way
create procedure get_clients_by_state(state varchar(5))
begin
  select * from clients as c where c.state=ifnull(state, c.state);
end;

call get_clients_by_state(null);

-- exercise
-- write a store procedure to return invoices for a given client get_clients_by_state
create procedure get_invoices_by_client(client_id INT)

begin
	select * from invoices as i where i.client_id=client_id;
end;

call get_invoices_by_client(2);

-- parameter validation
create procedure make_payment(invoice_id int, payment_amount decimal(9, 2), payment_date date);

begin
	if payment_amount <= 0 then
		signal sqlstate "22003" set message_text="Invalid payment amount";
	endif;

	update invoices as i 
		set i.payment_total=payment_amount, i.payment_date=payment_date
		where i.invoice_id=invoice_id;
end;

call make_payment(2, 100, "2019-01-01");

-- output parameters/return values
-- https://youtu.be/v12dw3kUJlk
create procedure get_unpaid_invoices_for_client(IN client_id INT, out invoice_count int, out invoices_total decimal(9, 2))
begin
	select count(*), sum(invoice_total)
	into invoice_count, invoices_total
	from invoices as i   
	where i.client_id=client_id
		and payment_total=0;
end;

call get_unpaid_invoices_for_client(3, @invoice_count, @invoices_total);
select @invoice_count, @invoices_total;

-- user/session variables, active until mysql disconnected
-- prefix with @
set @variable_name = value;

-- local varriable for store procedure
create procedure get_risk_factor()
begin
	declare risk_factor decimal(9, 2) DEFAULT 0;
	declare invoices_total decimal(9, 2);
	declare invoice_count int;

	select count(*), sum(invoice_total)
	into invoice_count, invoices_total
	from invoices;

	set risk_factor = invoices_total/invoice_count*5;

	select risk_factor;
end;

call get_risk_factor();

-- function (return only single value)
-- store procedure return multiple values
create function get_risk_factor_for_client(client_id int)
returns integer
-- attributes
	-- deterministic [for x return always y]
	-- reads sql data [select statement to read data]
	-- modifies sql data [update/delete statements]
reads sql data
begin 
	declare risk_factor decimal(9, 2) DEFAULT 0;
	declare invoices_total decimal(9, 2);
	declare invoice_count int;

	select count(*), sum(invoice_total)
	into invoice_count, invoices_total
	from invoices as i
	where i.client_id=client_id;

	set risk_factor = invoices_total/invoice_count*5;
	return ifnull(risk_factor, 0);
end;

select 
	client_id, name, get_risk_factor_for_client(client_id) as risk_factor
from clients;

-- drop function
drop function if exists get_risk_factor_for_client;

-- ===================== Triggers & events =====================
-- a trigger of SQL code that automatically executed before or after 
-- an insert, update, and delete statement.
use sql_invoicing;

create trigger payments_after_insert
	after insert on payments
	for each row
begin
	update invoices set payment_total = payment_total + NEW.amount
	where invoice_id=new.invoice_id;
end;

insert into payments values (DEFAULT, 5, 3, "2019-01-01", 10, 1);

select * from invoices;

-- create a trigger that gets fired when we delete a payment
create trigger payments_after_delete 
	after delete on payments
	for each row
begin
	update invoices set payment_total = payment_total - old.amount
	where invoice_id=old.invoice_id;
end;

delete from payments where payments_id=10;

show triggers; -- return all triggers in a current database

-- drop trigger
drop trigger if exists payments_after_delete;

-- payment_audit table
create table payments_audit (
	client_id int primary key auto_increment,
	date date not null,
	amount decimal(9, 2) not null,
	action_type varchar(50) not null,
	action_date datetime not null
);

-- events: a block of SQL code or task that gets executed according to schedule.
show variables; -- all system variables

-- on event_scheduler first
show variables like "event%";
set global event_scheduler=off 

create event yearly_delete_state_audit_rows
	on schedule 
	-- at "2020-05-20" (only once)
	every 1 year start "2020-05-20" ends "2029-05-20"
do begin
	delete from payments_audit
		where action_date < now() - interval 1 year;
end;

-- view events in current database
show events;

-- drop events
drop events if exists yearly_delete_state_audit_rows;