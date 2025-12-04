PRIMARY KEY is a constraint that uniquely identifies each record in a table. It combines NOT NULL and UNIQUE. 
A table can have only ONE primary key.

It's like your Aadhaar number! 🆔
- Every Indian has exactly ONE Aadhaar
- No two people share the same Aadhaar
- You MUST have an Aadhaar (can't be empty)

set search_path to daily;

CREATE TABLE customers_pk (
    cust_id INT PRIMARY KEY,
    cust_name VARCHAR(100)
);

-- Method 2: Constraint at end
CREATE TABLE orders_pk (
    order_id INT,
    order_date DATE,
    PRIMARY KEY (order_id)
);

-- Method 3: Names=d Constraints

create table products__pk(
	prod_id int,
	prod_name varchar(200),
	constraint siraj_product_pk primary key(prod_id)
);


-- Composite Primary Key
create table order_items(
	order_id int,
	prod_id int,
	quantity int,
	primary key (order_id,prod_id)
);

-- FOREIGN KEY is a constraint that creates a link between two tables. 
-- It ensures that values in the child table must exist in the parent table's primary key column (referential integrity).

CREATE TABLE customers_pk (
    cust_id INT PRIMARY KEY,
    cust_name VARCHAR(100)
);


insert into customers_pk values(1,'Siraj'),(2,'Rishav'),(3,'Vishal');

create table orders_fk(
	order_id int primary key,
	cust_id int references customers_pk(cust_id),
	order_date date
);

insert into orders_fk values(1,1,'2025-12-05'),(2,1,'2025-12-05'),(3,2,'2025-12-05');


select * from customers_pk;

select * from orders_fk;

delete from customers_pk where cust_id =1;
delete from orders_fk where cust_id =1;

delete from customers_pk where cust_id =3;
















