-- CHECK Constraint

-- CHECK constraint ensures that values in a column satisfy a specific Boolean condition. If the condition evaluates to FALSE, the insert/update is rejected.

-- 🍺 THE UNDERAGE PURCHASE BLOCK!

-- Government rule: Only 21+ can buy alcohol!

set search_path to daily;

create table age_check(
	order_id serial,
	age int check( age >= 21)
);


insert into age_check (age) values(21);

select * from age_check;


create table employee_records(
	emp_id int not null unique,
	emp_name varchar(50) not null,
	age int check (age >= 18 and age <=65),
	salary numeric(12,2) check(salary >=15000),
	experience_yrs int check(experience_yrs>=0),
	constraint valid_exp_age check (experience_yrs <= age-18)
);

insert into employee_records values(1,'Ali',25,20000,6);

25-18
= 7

select * from employee_records;











