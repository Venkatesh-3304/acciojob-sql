create table daily.numeric_data(
	age smallint,
	order_counts int,
	aadhar_no bigint,
	price decimal(10,3)
);

select
	*
from
	daily.numeric_data;

select
	*
from
	daily.numeric_data;

-- Inserted all the columns | one row
insert into
	daily.numeric_data
	(age,order_counts,aadhar_no,price)
values
	(23,123456,123456789012,123456.123456);


-- Inserted all the columns with multipe rows
insert into
	daily.numeric_data
	(age,order_counts,aadhar_no,price)
values
	(23,123456,123456789012,123456.123456),
	(23,123456,123456789012,123456.123456),
	(23,123456,123456789012,123456.123456),
	(23,123456,123456789012,123456.123456),
	(23,123456,123456789012,123456.123456);

-- Because we are following the same table column seq so no need to give column name list
insert into
	daily.numeric_data
values
	(1123,123456,123456789012,123456.123456);

-- Insert age
insert into
	daily.numeric_data
	(age)
values
	(4000);

alter table 
	daily.numeric_data
add column id serial;






















	