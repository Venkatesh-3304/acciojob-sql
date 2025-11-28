SET
  search_path TO daily;


CREATE TABLE subscribers (
    user_id serial,
    email VARCHAR(100),
    is_verified boolean,
    is_subscribed boolean
);

insert into daily.subscribers (email, is_verified, is_subscribed) values
('starlordali@gmail.com',TRUE,FALSE);

select * from subscribers;