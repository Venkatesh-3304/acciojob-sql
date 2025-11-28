set search_path to daily;


create table members(
	member_id int,
	member_name varchar(50),
	status varchar(20) default 'active',
	join_date date default current_date,
	points int default 0,
	is_verified boolean default FALSE
);

insert into  members (member_id,member_name) values(1,'Rahul');

select * from members;