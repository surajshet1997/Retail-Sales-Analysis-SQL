-- SQL Retail Sales Analysis - P1
CREATE DATABASE sql_project_p2;

use sql_project_p2;

-- Create TABLE
CREATE TABLE retail_sales
            (
                transaction_id INT PRIMARY KEY,	
                sale_date DATE,	 
                sale_time TIME,	
                customer_id	INT,
                gender	VARCHAR(15),
                age	INT,
                category VARCHAR(15),	
                quantity INT,
                price_per_unit FLOAT,	
                cogs FLOAT,
                total_sale FLOAT
            );

SELECT * from retail_sales;

SELECT TOP 10 *
FROM retail_sales;

SELECT  COUNT(*) 
FROM retail_sales;

-- Data Cleaning
SELECT * FROM retail_sales
WHERE transaction_id IS NULL;

SELECT * FROM retail_sales
WHERE sale_date IS NULL;

SELECT * FROM retail_sales
WHERE sale_time IS NULL;

SELECT * FROM retail_sales
WHERE 
    transaction_id IS NULL
    OR
    sale_date IS NULL
    OR 
    sale_time IS NULL
    OR
    gender IS NULL
    OR
    category IS NULL
    OR
    quantity IS NULL
    OR
    cogs IS NULL
    OR
    total_sale IS NULL;

DELETE FROM retail_sales
WHERE 
    transaction_id IS NULL
    OR
    sale_date IS NULL
    OR 
    sale_time IS NULL
    OR
    gender IS NULL
    OR
    category IS NULL
    OR
    quantity IS NULL
    OR
    cogs IS NULL
    OR
    total_sale IS NULL;

-- Data Exploration

-- How many sales we have?
SELECT COUNT(*) as total_sale FROM retail_sales;

-- How many unique customers we have ?

SELECT COUNT(DISTINCT customer_id) as total_sale FROM retail_sales;

SELECT DISTINCT category FROM retail_sales;

-- Data Analysis & Business Key Problems & Answers

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

-- Q.1 Write a SQL query to retrieve all columns for sales made on '2022-11-05

SELECT * FROM retail_sales where sale_date = '2022-11-05';

-- Q.2 Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 4 in the month of Nov-2022

SELECT *
FROM retail_sales
WHERE category = 'Clothing'
  AND FORMAT(sale_date, 'yyyy-MM') = '2022-11'
  AND quantity >= 4;
  
  -- Q.3 Write a SQL query to calculate the total sales (total_sale) for each category.

  select category,
  sum(total_sale) as net_sale,
  count(*) as total_orders
  from retail_sales
  group by category;

-- Q.4 Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.
 
SELECT round(avg(age),2) from retail_sales
where category = 'Beauty';

-- Q.5 Write a SQL query to find all transactions where the total_sale is greater than 1000.

SELECT * FROM retail_sales
where total_sale > 1000;

-- Q.6 Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.

select category,
gender,
count(*) as total_trans
from retail_sales
group by category, gender
order by category;

-- Q.7 Write a SQL query to calculate the average sale for each month. Find out best selling month in each year

SELECT 
       year,
       month,
    avg_sale
FROM 
(SELECT
Year(sale_date) as year,
month(sale_date) as month,
avg(total_sale) as avg_sale,
RANK() OVER(
PARTITION BY Year(sale_date)
ORDER BY AVG(total_sale) DESC
) as rank
from retail_sales
group by Year(sale_date), month(sale_date)
) as T1
where rank = 1
ORDER BY year;

-- order by Year(sale_date), avg_sale desc;

-- Q.8 Write a SQL query to find the top 5 customers based on the highest total sales

