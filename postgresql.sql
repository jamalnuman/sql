--Postgres is the actual database 

--SQL is the Structured Query Language, which allows commands such 
SELECT first_name FROM person
--where first_name is the column and person is the name of the table 

--SQL manages data in a relational datbase

--Stores data in a table that has columns and rows 

                --Table - Person 
  --id    first_name    last_name   gender    age
  --1     jamal         numan       male      38
  --2     yasmeen       ahmed       female    34
--line 11 are the column headings and line 13 / 14 are the rows 

--Relational database is where a relationship exist btw two or more tables. 

--PostgreSql is open source as opposed to Oracle which requires a license. other options are mysql, oracle database, microsoft sql server

--DataGrip can be used as a GUI client for many database, but you need to buy a license. 

--Postico can also be used, it is free, only for Mac users

--To enter postrgeSQL: 
psql postgres

--To exit out of postgreSQL: 
\q

--to see a list of the databases: 
\l

--create new database: 
CREATE DATABASE [name];

--to drop a database: 
DROP DATABASE [name];

--to get a list of commands..cant be inside the database, type: 
psql --help

--to get version of postgres: 
psql -V

--to connect to the database: 
psql -h localhost -p 5432 -U jamalnuman test
-h is for hostname, -p is for port number, -U is the name of the host, test is name of the table 

--you can also connect to databases: 
\c


--Create Table:

CREATE TABLE [table_name] (
  --*column name + *data type + constraints if any
  )

CREATE TABLE person (  
  id INT, 
  first_name VARCHAR(50),
  last_name VARCHAR(50),
  gender VARCHAR(50),
  date_of_birth TIMESTAMP,
  );               

--TIMESTAMP includes full date, hour, minutes and seconds

--**** WITHOUT CONSTRAINTS & NOTICE THE SYNTAX..means you can create a person without any information. This is similar to validations in Rails. 

--there are various data types, money, bigserial (auto increments), time, text(no limit), date, uuid, xml etc...review the various data types

--To see a list of tables: 
\d ....d for describe or 
\dt..there is a small difference btw the two commands. 

--To see a specific table: 
\d [name of table] => \d person

--Create a table WITH constraints:

CREATE TABLE person (  
  id BIGSERIAL NOT NULL PRIMARY KEY,
  first_name VARCHAR(50) NOT NULL,
  last_name VARCHAR(50) NOT NULL,
  gender VARCHAR(50) NOT NULL,
  date_of_birth DATE NOT NULL
  ); 
--**** WITH CONSTRAINTS & NOTICE THE SYNTAX

--BIGSERIAL increments by itself..autoincrement 8-bit integer

--to drop a table:
DROP TABLE [name]....DROP TABLE person

--how to insert records into tables:
INSERT INTO person (
  first_name, 
  last_name, 
  gender, 
  date_of_birth,
  email)
VALUES('Anne', 'Smith', 'Female', DATE '1988-01-09', 'anne@gmail.com');

--notice the syntax for the date 

--order of the values match the order of columns from above. 

--the id column is not being specified cause the BIGSERIAL, which autoincrements, handles that. 

--to see the rows in a table:
SELECT * FROM [table]
SELECT * FROM person....select everything from person table 

--mockaroo to get dummy data.

--to execute commands from a file: REMEBER TO CREATE THE TABLE AND THEN INPUT THE DATA, YOU MUST BE CONNECTED TO THE DATABASE FIRST
  \i [path file]
  \i /Users/jamalnuman/Downloads/person.sql

-- * means you want to SELECT every column

-- to select multiple columns:
SELECT first_name, last_name FROM person;

--how to sort data using ORDER BY..either ascending or descending

SELECT first_name FROM person ORDER BY country_of_birth
  --so this command will sort the data by country_of_birth and it will automatically be ASC..if you want descending..at the end include DESC
    -- IMPORTANT: ASC and DESC work for dates, numbers and strings
    --best to sort by one column, instead of multiple columns

--SELECT country_of_birth FROM person ORDER BY country_of_birth;

--to remove duplicates from the returned data, use DISTINCT
  SELECT DISTINCT country_of_birth FROM person;
  SELECT DISTINCT country_of_birth FROM person ORDER BY country_of_birth DESC;
    --DISTINCT CAN BE USED FOR ANY COLUMN

-- WHERE ..allows to filter column(s) of data based on conditions
  SELECT * FROM person WHERE gender = 'Female';
    --the clause in the parenthesis MUST match

--multiple WHERE clause:
SELECT * FROM person WHERE gender = 'Male' AND country_of_birth = "China";

SELECT * FROM person WHERE gender = 'Male' AND (country_of_birth = "China" or country_of_birth = 'Poland');

--to get extremely specific: 
SELECT * FROM person WHERE gender = 'Male' AND last_name = 'Swalwell' AND (country_of_birth = 'China' or country_of_birth = 'Poland');

--WHERE must come before the ORDER BY...you can't ORDER BY when the conditions have not been met.

SELECT country_of_birth FROM person WHERE country_of_birth = 'China';

SELECT DISTINCT country_of_birth FROM person WHERE country_of_birth = 'China';

--arithmetic operations and comparison operators
  --to get a boolean result use the arithmetic operators
  SELECT 1 = 1; should return t for true and f for false
  SELECT 1 > 2;
  SELECT 1 <> 2; 1 is not equal 2
  --these comparison operators can be used on any data..such as numbers, strings etc. 
  --These can be used to filter the data in the WHERE clause 

  --OFFSET and FETCH and LIMIT

  SELECT * FROM person LIMIT 10; 
    --gives the first 10 rows. 

  SELECT * FROM person OFFSET 5 LIMIT 10; 
    --gives the first 10 rows after the 5th row, meaning, it starts at the 6th row. remove the LIMIT to get everything after the 5th row.
    SELECT * FROM person OFFSET 5 FETCH FIRST 10 ROW ONLY;
      --Same command as line 172

--Using the IN keyword
SELECT * FROM person WHERE country_of_birth = 'China' OR country_of_birth = 'Poland' OR country_of_birth = 'Brazil';

======>>>>> SELECT * FROM person WHERE country_of_birth IN ('China', 'Brazil', 'Poland');
  --same code line 174 / 177

 --BETWEEN ..allows you to select data within a range...both bounds are inclusive. 
  SELECT * FROM person WHERE date_of_birth BETWEEN DATE '2001-01-01' AND '2015-01-01';
    
    SELECT * FROM person WHERE id BETWEEN '1' AND '10' ORDER BY country_of_birth DESC;
    --NOTE THE SYNTAX

--LIKE and iLIKE - used to match text values against a pattern using wildcards
  --find every email that ends in .com
    SELECT * FROM person WHERE email LIKE '%.com';

    SELECT * FROM person WHERE email LIKE ' %oakley.com';

    SELECT * FROM person WHERE email LIKE '%google.%';

    --also use underscores: to match a pattern..in this case, where the email has 8 characters before the @ sign. 

    SELECT * FROM person WHERE email LIKE '________@%';

    --8 characters with an "a" and the '@' and then whatever else.  
    SELECT * FROM person WHERE email LIKE '_______a@%';

    --iLIKE doesn't worry about the case..besides that, works the same way. 

  --GROUP BY..to group data by column. 
    --to find out how many members belong to a country
    SELECT country_of_birth, COUNT(*) FROM person GROUP BY country_of_birth;
      --selecting the country of birth column and we want to count every person who belongs to a country

    SELECT last_name, COUNT(*) FROM person WHERE last_name = 'Seed' GROUP BY last_name;
      --NOTICE THE WHERE CLAUSE COMES FIRST

  --GROUP BY HAVING..allows an extra filter 
    --to select all countries that have more than 5 people: 
      SELECT country_of_birth, COUNT(*) FROM person GROUP BY country_of_birth HAVING COUNT(*) > 5 ORDER BY country_of_birth;

      --same last name: 
      SELECT last_name, COUNT(*) FROM person GROUP BY last_name HAVING COUNT(*) > 1 ORDER BY last_name;

      --THE CATEGORY IN THE SELECT COMMAND MUST BE PRESENT IN THE GROUP BY COMMAND. 

--max, min and sum commands: 
--to get the max price in a table: 
SELECT MAX(price) FROM car;
--for min value 
SELECT MIN(price) FROM car; 
--to get the average
SELECT AVG(price) FROM car;

--to round the value returned: 
SELECT ROUND(AVG(price)) FROM car; 

--to group the results by a column, in this example by make and model. 
SELECT make, model, MAX(price) FROM car GROUP BY make, model;

SELECT make, model, MIN(price) FROM car GROUP BY make, model;

SELECT make, model, ROUND(AVG(price)) FROM car GROUP BY make, model;

--SUM operator...allows addition of data:
SELECT SUM(price) FROM car; --this is the sum of all the prices in the table

--this is for each model
SELECT make, SUM(price) FROM car GROUP BY make;

--ordering it by price  
SELECT make, SUM(price) FROM car GROUP BY make, price ORDER BY price DESC;


--Basics of Arithmitic

--perform addition
SELECT 10 + 2;
SELECT 10 - 2; 
SELECT 10 * 2;
SELECT 10 / 2 + 8;

--the power of a number 
SELECT 10^2; --gives back 100 

--Factorial of a number 
SELECT 5!;

--Modulus operator..gives the remainder 
SELECT 10 % 3;

--to get 10 percent off of the price

SELECT id, make, model, price, price * .10 FROM car


--getting an extra row and rounding the price 2 decimal places. 
SELECT id, make, model, price, ROUND(price * .10,2) FROM car

--subtracting the discounted price from the total price and then displaying the new price:
SELECT id, make, model, price, ROUND(price * .10), ROUND(price - (price * .10), 2) FROM car;
 
--Alias, changing the name of the temporary columms. This also you to override any column. 

SELECT id, make, model, price AS original_price, ROUND(price * .10) AS ten_percent_off , ROUND(price - (price * .10), 2) AS new_price_after_discount FROM car;  

--Coalesce: allows a default in case the first value is null

SELECT COALESCE (1);

SELECT COALESCE(null, 1); --if the first value is null, then return 1
SELECT COALESCE(null, null, 1); --allows for multiple values
SELECT COALESCE(null, 5, 1); --this would return 5

--when the email is not provided, return a value: 
SELECT COALESCE(email, 'no email provided') FROM person;

--NULLIF: this will return a null value, if the second parameter equals the first parameter. 
SELECT NULLIF(10, 10); --returns 0
SELECT NULLIF(10, 100); --returns 10

SELECT 10 / 0; --this throws an exception..to get around this use NULLIF: 
SELECT 10 / NULLIF(0, 0); --this will now return 0, instead of an exception
SELECT 10 / NULLIF(0, 10); --this will now return 1

--TIMESTAMPS AND DATES: 



































