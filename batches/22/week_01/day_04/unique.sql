-- You are working for Myntra 

-- To create a user table 

-- Rahul Sharma	=>	rahul.sharma@myntra_user.com

set search_path to daily;

create table users_unique(
	user_id int unique,
	email varchar(100) not null,
	phone varchar(15) not null unique
);

insert into users_unique values (1,'rahul.sharma@gmail.com','+91 9988776655');

insert into users_unique (email,phone) values ('rahul.sharma@gmail.com','+91 9990776955');

select * from users_unique;


-- Student can enroll in each course only once
-- Lang
-- 	Tamil
-- 	French
-- 	Urdu
-- 	German
	

create table course_enrollments(
	enrollment_id serial,
	student_id int,
	course_id int,
	semester varchar(20),
	enrolled_date date default current_date,
	unique(student_id,course_id,semester)
);

INSERT INTO daily.course_enrollments(
	 student_id, course_id, semester)
	VALUES (1, 1, 'Even 2024');
	
INSERT INTO daily.course_enrollments(
	 student_id, course_id, semester)
	VALUES (1, 2, 'Even 2024');


INSERT INTO daily.course_enrollments(
	 student_id, course_id, semester)
	VALUES (1, 1, 'Odd 2024');

select * from course_enrollments;







create table course_enrollments_(
	enrollment_id serial,
	student_id int,
	course_id int,
	semester varchar(20),
	enrolled_date date default current_date,
	unique(student_id,course_id,semester),
	constraint uq_enrollmene unique(student_id,course_id)
);

INSERT INTO daily.course_enrollments_(
	 student_id, course_id, semester)
	VALUES (1, 1, 'Even 2024');

select * from course_enrollments_;
















