set search_path to daily;


create table user_preferences(
	user_id int,
	preferences JSON
);

insert into user_preferences values (1,'{
    "spice_level": "high",
    "diet": "vegetarian", 
    "cuisines": ["North Indian", "Chinese", "Italian"],
    "allergies": ["peanuts"],
    "budget": "medium"
}');

select * from user_preferences;




-- JSON type
CREATE TABLE user_settings (
    user_id INT,
    settings JSON
);

INSERT INTO user_settings VALUES 
(1, '{"theme": "dark", "language": "hindi"}');

-- JSONB (Binary - recommended for queries)
CREATE TABLE user_profiles (
    user_id INT,
    profile JSONB
);

-- UUID type
CREATE TABLE sessions (
    session_id UUID DEFAULT gen_random_uuid(),
    user_id INT
);

-- ARRAY type
CREATE TABLE student_marks (
    student_id INT,
    subjects TEXT[],
    marks INT[]
);

INSERT INTO student_marks VALUES 
(1, ARRAY['Math', 'Science', 'English'], ARRAY[85, 90, 78]);


CREATE TABLE app_config (
    app_id INT,
    config JSON
);

INSERT INTO app_config VALUES 
(1, '{"app_name": "RetailMart", "version": "2.0"}');

SELECT * FROM app_config;


CREATE TABLE user_sessions (
    session_id UUID DEFAULT gen_random_uuid(),
    user_name VARCHAR(50),
    login_time TIMESTAMP DEFAULT NOW()
);

INSERT INTO user_sessions (user_name) VALUES ('Rahul');
INSERT INTO user_sessions (user_name) VALUES ('Priya');

SELECT * FROM user_sessions;
-- Each row gets unique UUID automatically!


CREATE TABLE product_tags (
    prod_id INT,
    prod_name VARCHAR(50),
    tags TEXT[]
);

INSERT INTO product_tags VALUES 
(1, 'iPhone 15', ARRAY['electronics', 'mobile', 'apple', 'premium']),
(2, 'Nike Shoes', ARRAY['footwear', 'sports', 'nike']);

SELECT * FROM product_tags;


CREATE TABLE modern_customers (
    cust_uuid UUID DEFAULT gen_random_uuid(),
    cust_name VARCHAR(50),
    preferences JSONB,
    favorite_categories TEXT[],
    created_at TIMESTAMP DEFAULT NOW()
);

INSERT INTO modern_customers (cust_name, preferences, favorite_categories) 
VALUES (
    'Arjun Mehta',
    '{"theme": "dark", "language": "english", "notifications": true}',
    ARRAY['Electronics', 'Books', 'Sports']
);

SELECT * FROM modern_customers;







--=================================================================================================






-- MONEY type (Note: Better to use NUMERIC for currency)
CREATE TABLE price_list (
    item_id INT,
    price MONEY
);

-- INET type
CREATE TABLE login_logs (
    log_id INT,
    user_id INT,
    ip_address INET,
    login_time TIMESTAMP
);

INSERT INTO login_logs VALUES 
(1, 101, '192.168.1.100', NOW());

CREATE TABLE ip_logs (
    log_id INT,
    ip_address INET
);

INSERT INTO ip_logs VALUES 
(1, '192.168.1.1'),
(2, '10.0.0.50');

SELECT * FROM ip_logs;


CREATE TABLE user_access_log (
    access_id INT,
    user_name VARCHAR(50),
    ip_address INET,
    access_time TIMESTAMP DEFAULT NOW()
);

INSERT INTO user_access_log (access_id, user_name, ip_address) VALUES 
(1, 'admin', '192.168.1.1'),
(2, 'guest', '10.0.0.25');

SELECT * FROM user_access_log;
```




