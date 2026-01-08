5. Topic 1: Numeric Data Types

5.1 Definition

Technical Definition:

Numeric data types in PostgreSQL are used to store numbers, including integers (whole numbers) and floating-point numbers (decimals). They vary in storage size and precision, allowing developers to optimize for both accuracy and storage efficiency.
Layman's Terms:
Think of numeric types like different sized containers for numbers! 🫙

SMALLINT = Small jar (holds numbers from -32,768 to 32,767) - like storing your age
INTEGER = Medium container (holds billions!) - like storing customer IDs
BIGINT = Massive tank (holds quintillions!) - like storing India's population over centuries
DECIMAL = Precise measuring cup - when you need EXACT numbers (like money! 💰)
SERIAL = Auto-counter - like the token machine at a bank that gives you the next number automatically!

C1  =>  Concept clear
C2  =>  Concept clear from brain

Order Counts
date

age
customer_id

-- ═══════════════════════════════════════════════════════════
-- INTEGER TYPES
-- ═══════════════════════════════════════════════════════════

-- SMALLINT: 2 bytes, range: -32,768 to +32,767
column_name SMALLINT

-- INTEGER (or INT): 4 bytes, range: -2.1 billion to +2.1 billion
column_name INTEGER
column_name INT  -- shorthand

-- BIGINT: 8 bytes, range: -9.2 quintillion to +9.2 quintillion
column_name BIGINT

-- ═══════════════════════════════════════════════════════════
-- AUTO-INCREMENT TYPES (for Primary Keys)
-- ═══════════════════════════════════════════════════════════

-- SERIAL: Auto-incrementing INTEGER (1, 2, 3, 4...)
column_name SERIAL PRIMARY KEY

-- BIGSERIAL: Auto-incrementing BIGINT
column_name BIGSERIAL PRIMARY KEY

-- ═══════════════════════════════════════════════════════════
-- DECIMAL/NUMERIC TYPES (for precise calculations)
-- ═══════════════════════════════════════════════════════════

-- NUMERIC(precision, scale) or DECIMAL(precision, scale)
-- precision = total digits, scale = digits after decimal
column_name NUMERIC(10, 2)   -- 12345678.99 (8 digits + 2 decimals)
column_name DECIMAL(12, 2)   -- Same as NUMERIC

-- ═══════════════════════════════════════════════════════════
-- FLOATING POINT TYPES (approximate, for scientific data)
-- ═══════════════════════════════════════════════════════════

-- REAL: 4 bytes, 6 decimal digits precision
column_name REAL

-- DOUBLE PRECISION: 8 bytes, 15 decimal digits precision
column_name DOUBLE PRECISION


-- create new schema
CREATE SCHEMA DAY_03;

-- show current schema
SHOW SEARCH_PATH;

-- change the schema
SET
	SEARCH_PATH TO DAY_03;

Product_Rating
	rating_id		serial
	product_id		int
	rating_value	smallint
	helful_votes	int
	average_price	decimal(10,2)


CREATE TABLE PRODUCT_RATINGS (
	RATING_ID SERIAL,
	PRODUCT_ID INTEGER,
	RATING_VALUE SMALLINT,
	HELPFUL_VOTES INTEGER,
	AVERAGE_PRICE DECIMAL(10, 2)
);

INSERT INTO
	PRODUCT_RATINGS (
		PRODUCT_ID,
		RATING_VALUE,
		HELPFUL_VOTES,
		AVERAGE_PRICE
	)
VALUES
	(1, 3768, 39568, 7889098769.56789);

SELECT
	*
FROM
	PRODUCT_RATINGS;