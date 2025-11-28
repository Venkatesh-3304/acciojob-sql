create table daily.customer_contacts(
	contact_id serial,
	first_name varchar(50),
	last_name varchar(50),
	phone_number varchar(15),  -- +91-9876543212
	address  varchar(250),
	about text
);