create table daily.events(
	event_date date
);

insert into daily.events values('2025-01-15');
insert into daily.events values('2025/10/26');
insert into daily.events values('31-12-2025');

select * from daily.events;

set search_path to daily;

create table test_customers(
	cust_id serial,
	cust_name varchar(50),
	join_date date
);

insert into test_customers (cust_name,join_date) values ('Rahul Sharma','2024-06-15');

select * from test_customers;

create table test_orders(
	order_id serial,
	order_timestamp timestamp,
	delivery_date date
);

insert into test_orders (order_timestamp,delivery_date) values('2025-01-15 14:30:00','2025-01-16');

select * from test_orders;

select now();

create table delivery_orders(
	order_id serial,
	order_time timestamp,
	estimate_delivery timestamp
);


insert into delivery_orders (order_time,estimate_delivery) values ('2025-01-15 14:30:00','2025-01-15 14:30:00'::timestamp + interval '45 minutes');
insert into delivery_orders (order_time,estimate_delivery) values (NOW(),NOW() + interval '45 minutes');

select * from delivery_orders;


































