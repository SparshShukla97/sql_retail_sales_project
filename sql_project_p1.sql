--   SQL Retail Sales Analysis Project P1

-- Creating Table 

CREATE TABLE product_sales (transactions_id INT,
                           sale_date DATE,
						   sale_time TIME ,
						   customer_id INT,
						   gender VARCHAR(10),
						   age INT,
						   category VARCHAR(25),
						   quantiy INT ,
						   price_per_unit,
						   cogs,
						   total_sale
						  );
