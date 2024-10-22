/*
    Name: Richard Pang
    DTSC660: Data and Database Managment with SQL
    Module 7
    Assignment 5


*/

--------------------------------------------------------------------------------
/*				                 Table Creation		  		                  */
--------------------------------------------------------------------------------

CREATE TABLE customer_spending (
    sale_date DATE,
    sale_year INTEGER,
    sale_month VARCHAR(15),
    age INTEGER,
    gender CHAR(1),
    country VARCHAR(50),
    state VARCHAR(50),
    category VARCHAR(50),
    sub_category VARCHAR(50),
    quantity INTEGER,
    unit_cost NUMERIC(10, 2),
    unit_price NUMERIC(10, 6),
    cost NUMERIC(10, 2),
    revenue NUMERIC(10, 2)
);

--------------------------------------------------------------------------------



--------------------------------------------------------------------------------
/*				                 Import Data           		  		          */
--------------------------------------------------------------------------------
SET datestyle = 'ISO, MDY'; -- Replace 'ISO, MDY' with the desired datestyle
COPY customer_spending
FROM 'C:\Users\Public\customer_spending.csv'
WITH (FORMAT CSV, HEADER);

--Check Data
SELECT * FROM customer_spending;

--------------------------------------------------------------------------------



--------------------------------------------------------------------------------
/*				                 Question 1: 		  		                  */
--------------------------------------------------------------------------------

SELECT category, SUM(revenue) AS total_revenue
FROM customer_spending
WHERE sale_year = 2016
GROUP BY category
ORDER BY category;

--------------------------------------------------------------------------------
/*				                  Question 2           		  		          */
--------------------------------------------------------------------------------

SELECT sub_category,
       AVG(unit_price) AS average_unit_price,
       AVG(unit_cost) AS average_unit_cost,
       AVG(unit_price - unit_cost) AS margin
FROM customer_spending
WHERE sale_year = 2015
GROUP BY sub_category
ORDER BY sub_category;

--------------------------------------------------------------------------------
/*				                  Question 3           		  		          */
--------------------------------------------------------------------------------

SELECT COUNT (gender) AS total_female_buyers
FROM customer_spending
WHERE category = 'Clothing' AND gender = 'F';
   
--------------------------------------------------------------------------------
/*				                  Question 4           		  		          */
--------------------------------------------------------------------------------

SELECT age,
       sub_category,
       AVG(quantity) AS average_quantity,
       AVG(cost) AS average_cost
FROM customer_spending
GROUP BY age, sub_category
ORDER BY age DESC, sub_category;

--------------------------------------------------------------------------------
/*				                  Question 5           		  		          */
--------------------------------------------------------------------------------

SELECT country FROM customer_spending
WHERE age BETWEEN 18 AND 25
GROUP BY country
HAVING COUNT(quantity) > 30;
    
--------------------------------------------------------------------------------
/*				                  Question 6           		  		          */
--------------------------------------------------------------------------------

SELECT sub_category,
       ROUND(AVG(quantity), 2) AS avg_quantity,
       ROUND(AVG(cost), 2) AS avg_cost
FROM customer_spending
GROUP BY sub_category
HAVING COUNT(*) >= 10
ORDER BY sub_category;

--------------------------------------------------------------------------------
/*				                  Question 7           		  		          */
--------------------------------------------------------------------------------

SELECT sub_category,
       SUM(quantity) AS total_quantity,
       SUM(revenue) AS total_revenue
FROM customer_spending
WHERE gender = 'M' AND sale_year = 2016
GROUP BY sub_category;

--------------------------------------------------------------------------------
/*				                  Question 8           		  		          */
--------------------------------------------------------------------------------

SELECT country, SUM(revenue) AS total_revenue
FROM customer_spending
GROUP BY country
ORDER BY country;

--------------------------------------------------------------------------------
/*				                  Question 9           		  		          */
--------------------------------------------------------------------------------

SELECT gender,
       category,
       MAX(unit_cost) AS high_cost,
       MIN(unit_cost) AS low_cost,
       AVG(unit_cost) AS avg_cost
FROM customer_spending
GROUP BY gender, category
ORDER BY gender, category;

--------------------------------------------------------------------------------
/*				                  Question 10           		  	          */
--------------------------------------------------------------------------------

SELECT country, AVG(revenue) AS high_sales
FROM customer_spending
GROUP BY country
ORDER BY AVG(revenue) DESC
LIMIT 1;
