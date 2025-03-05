-- SQL Retail Sales Analysis Project P1

-- Creating Table
DROP TABLE  IF EXISTS retail_sales;

CREATE TABLE retail_sales (transactions_id INT PRIMARY KEY,
                            sale_date DATE,
						    sale_time TIME ,
						    customer_id INT,
						    gender VARCHAR(10),
						    age INT,
						    category VARCHAR(25),
						    quantity INT ,
						    price_per_unit INT,
						    cogs FLOAT,
						    total_sale FLOAT
						   );

-- Checking the table with limit set to 30 

SELECT * FROM retail_sales
LIMIT 30;

-- DATA CLEANING------------------------------------

-- to check all the rows
-- COUNT(*)

SELECT COUNT(*) 
 FROM retail_sales

-- FINDING NULL VALUES IN THE ROWS IN EXCEL
SELECT * FROM retail_sales
WHERE transactions_id IS NULL;

SELECT * FROM retail_sales
WHERE sale_date IS NULL;

SELECT * FROM retail_sales
WHERE sale_time IS NULL;

-- BETTER WAY
-- to check all the null column in the dataset 

SELECT * FROM retail_sales
WHERE transactions_id IS NULL 
   OR sale_date IS NULL 
   OR sale_time IS NULL
   OR customer_id IS NULL 
   OR age IS NULL
   OR category IS NULL 
   OR quantity IS NULL
   OR price_per_unit IS NULL 
   OR cogs IS NULL
   OR total_sale IS NULL;
 


 -- Deleting the null values from the dataset
 DELETE FROM 
 retail_sales
 WHERE age IS NULL;

 DELETE FROM 
 retail_sales
 WHERE quantity IS NULL;

 -- BETTER WAY 
 -- --------------------------------------------------------------------
 DELETE FROM 
 retail_sales 
 WHERE 
 cogs IS NULL  OR quantity IS NULL ;
 -- --------------------------------------------------------------------

--  Data Exploration

-- How many sales do we have ?
SELECT COUNT(*) AS total_sales FROM retail_sales

-- How many  unique customers we have in the dataset ?
--  COUNT() , DISTINCT , AS used
SELECT  COUNT(DISTINCT customer_id) AS customers FROM retail_sales;

--  How many unique category we have in the dataset ?
SELECT DISTINCT category AS categories FROM retail_sales;


-- DATA ANALYSIS / BUSINESS KEY PROBLEMS AND ANSWERS
-- My Analysis & Findings
-- Q.1 Write a SQL query to retrieve all columns for sales made on '2022-11-05
-- Q.2 Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 10 in the month of Nov-2022
-- Q.3 Write a SQL query to calculate the total sales (total_sale) for each category.
-- Q.4 Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.
-- Q.5 Write a SQL query to find all transactions where the total_sale is greater than 1000.
-- Q.6 Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.
-- Q.7 Write a SQL query to calculate the average sale for each month. Find out best selling month in each year
-- Q.8 Write a SQL query to find the top 5 customers based on the highest total sales 
-- Q.9 Write a SQL query to find the number of unique customers who purchased items from each category.
-- Q.10 Write a SQL query to create each shift and number of orders (Example Morning <=12, Afternoon Between 12 & 17, Evening >17)


-- Q.1 Write a SQL query to retrieve all columns for sales made on '2022-11-05'
SELECT *
FROM retail_sales
WHERE sale_date = '2022-11-05';

-- Q.2 Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is 
-- more than equal to 4 in the month of Nov-2022.
-- Method 1
SELECT * 
FROM retail_sales
WHERE category = 'Clothing'
AND quantity >= 4
AND EXTRACT(MONTH FROM sale_date) = 11
AND EXTRACT (MONTH FROM sale_date)= 2022;

-- Method 2
SELECT * 
FROM retail_sales
WHERE category = 'Clothing'
AND quantity >= 4
AND sale_date BETWEEN '2022-11-01' AND '2022-11-30';

-- Method 3
SELECT *
FROM retail_sales 
WHERE category = 'Clothing'
 AND
 TO_CHAR(sale_date,'YYYY-MM') = '2022-11'
 AND 
  quantity >= 4;

-- Q.3 Write a SQL query to calculate the total sales (total_sale) for each category.
SELECT  category AS categories , SUM(total_sale) As total_sales,
 COUNT(*) as total_orders
FROM retail_sales
GROUP BY category;

-- Q.4 Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.
SELECT ROUND(AVG(age),2) FROM retail_sales
WHERE category = 'Beauty';

-- Q.5 Write a SQL query to find all transactions where the total_sale is greater than 1000.
SELECT * FROM retail_sales
WHERE total_sale > 1000;

-- Q.6 Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.
SELECT category ,
       gender   , 
	   COUNT(*) as total_sales
	   FROM retail_sales
GROUP BY category ,gender
ORDER BY 1 ;

-- Q.7 Write a SQL query to calculate the average sale for each month. Find out best selling month in each year.
SELECT year,
       month, 
	   avg_sales
FROM 
(
SELECT 
     EXTRACT (YEAR from sale_date) AS year , 
	 EXTRACT (MONTH FROM sale_date) AS month, 
	 AVG(total_sale) AS avg_sales,
	 RANK() OVER(PARTITION BY EXTRACT(YEAR from sale_date) ORDER BY AVG(total_sale) DESC) as rank
FROM retail_sales
GROUP BY 1,2 
) AS t1
WHERE RANK = 1
	 
-- Q.8 Write a SQL query to find the top 5 customers based on the highest total sales 
SELECT 
       customer_id,
       SUM(total_sale) AS total_sales
 FROM retail_sales
 GROUP BY 1
 ORDER BY 2 DESC
 LIMIT 5
 

-- Q.9 Write a SQL query to find the number of unique customers who purchased items from each category.

SELECT  
	category, COUNT(DISTINCT customer_id) as cnt_unique_cust
FROM retail_sales
GROUP BY category







-- Q.10 Write a SQL query to create each shift and number of orders (Example Morning <=12, Afternoon Between 12 & 17, Evening >17)

SELECT 
    CASE
        WHEN sale_time <= '12:00:00' THEN 'Morning'
        WHEN sale_time > '12:00:00' AND sale_time <= '17:00:00' THEN 'Afternoon'
        ELSE 'Evening'
    END AS SHIFTS, 
    COUNT(*) AS number_of_orders
FROM retail_sales
GROUP BY SHIFTS;



 -- END OF PROJECT--




