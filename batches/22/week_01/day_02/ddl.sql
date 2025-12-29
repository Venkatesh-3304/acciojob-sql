create database batch_22;

select current_database();

create schema daily;

create table products (
	product_id int,
	product_name text,
	price decimal(10,2),
	stock_quantity int
);

show search_path;

set search_path to daily;

create table daily.product (
	product_id int,
	product_name text,
	price decimal(10,2),
	stock_quantity int
);

Alter table daily.product
alter column stock_quantity type numeric(5,2);

Alter table daily.products
add column category text;


drop table daily.product;


create schema daily_practise
	create table table_1(id int)
	create table table_2(id int);




















