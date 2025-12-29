set search_path to daily;

create table users(
	user_id int not null,
	user_name varchar(50) not null,
	email varchar(100) not null,
	nickname varchar(25)
);


insert into users values(1,'Siraj','starlordali@gmail.com','ali');

select * from users;

create table users_(
	user_id int ,
	user_name varchar(50) ,
	email varchar(100) not null,
	nickname varchar(25)
);


insert into users values(1,'Siraj','starlordali@gmail.com','ali');





































