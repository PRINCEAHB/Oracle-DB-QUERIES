----OT_FUNCTION
--Oracle Aggregate Functions
/*Introduction to Oracle aggregate functions
Oracle aggregate functions calculate on a group of rows and return a single value for each group.
We commonly use the aggregate functions together with the GROUP BY clause. The GROUP BY clause divides the rows into groups and an aggregate function calculates and returns a single result for each group.
If you use aggregate functions without a GROUP BY clause, then the aggregate functions apply to all rows of the queried tables or views.
We also use the aggregate functions in the HAVING clause to filter groups from the output based on the results of the aggregate functions.
Oracle aggregate functions can appear in SELECT lists and ORDER BY, GROUP BY, and HAVING clauses.
*/
--All aggregate functions ignore null values except COUNT(*), GROUPING(), and GROUPING_ID().
/* Oracle aggregate function list
The following table illustrates the aggregation functions in Oracle:

Type a function name to search...

Function    Description
APPROX_COUNT_DISTINCT    
AVG    Return the average of values of a set
COLLECT    
CORR    
CORR_*    
COUNT    Return the number of values in a set or number of rows in a table
COVAR_POP    
COVAR_SAMP    
CUME_DIST    
DENSE_RANK    
FIRST    
GROUP_ID    
GROUPING    
GROUPING_ID    
LAST    
LISTAGG    Aggregate strings from multiple rows into a single string by concatenating them
MAX    Return the maximum value in a set of values
MEDIAN    
MIN    Return the minimum value in a set of values
PERCENT_RANK    
PERCENTILE_CONT    
PERCENTILE_DISC    
RANK    
REGR_ (Linear Regression) Functions    
STATS_BINOMIAL_TEST    
STATS_CROSSTAB    
STATS_F_TEST    
STATS_KS_TEST    
STATS_MODE    
STATS_MW_TEST    
STATS_ONE_WAY_ANOVA    
STATS_T_TEST_*    
STATS_WSR_TEST    
STDDEV    
STDDEV_POP    
STDDEV_SAMP    
SUM    Returns the sum of values in a set of values
SYS_OP_ZONE_ID    
SYS_XMLAGG    
VAR_POP    
VAR_SAMP    
VARIANCE    
XMLAGG    
In this tutorial, you have learned about Oracle aggregate functions and how to use them to calculate aggregates.
*/
----Oracle AVG
/*
Oracle AVG() examples
We will use the products table in the sample database for the demonstration
*/
--A) Simple Oracle AVG() example
--The following example calculates the average standard costs of all products:
SELECT   ROUND(AVG( standard_cost ), 2) avg_std_cost
FROM     products;

SELECT
    ROUND(AVG( standard_cost ),2) avg_std_cost,
    ROUND(AVG( list_price ), 2) avg_list_price
FROM   products;
--B) Oracle AGV() with DISTINCT clause
--The following statement calculates the average DISTINCT list prices
SELECT
    ROUND( AVG( DISTINCT list_price ), 2 ) avg_list_price
FROM     products;
--C) Oracle AVG() with GROUP BY clause
--The following example calculates the average list price of products by category:
SELECT  category_id,
    ROUND( AVG( list_price ), 2 ) avg_list_price
FROM     products
GROUP BY  category_id;

--To make the result more readable, you can also retrieve the category name by adding an INNER JOIN clause to the query above:
SELECT  category_name,
    ROUND( AVG( list_price ),2 ) avg_list_price
FROM  products
INNER JOIN product_categories  USING(category_id)
GROUP BY    category_name
ORDER BY    category_name;
--D) Oracle AVG() with HAVING clause
--The following example returns the product categories whose average list prices are greater than 1000 specified by the HAVING clause:
SELECT category_name,
    ROUND(  AVG( list_price ),  2   ) avg_list_price
FROM   products
INNER JOIN product_categories  USING(category_id)
GROUP BY  category_name
HAVING  AVG( list_price )> 1000
ORDER BY  category_name;
--E) Oracle AVG() with subquery
--Consider the following example:
SELECT ROUND( AVG( avg_list_price ), 2) avg_of_avg
FROM (SELECT  AVG( list_price ) avg_list_price
        FROM     products
        GROUP BY  category_id    );

--F) Oracle AVG() with NULL values
--Let’s create a new table named tests for the demonstration.
CREATE TABLE tests2 (
  employee_id NUMBER PRIMARY KEY,
  score NUMBER(3,1));

INSERT INTO tests2(employee_id, score) VALUES(1, 95);
INSERT INTO tests2(employee_id, score) VALUES(2, 70);
INSERT INTO tests2(employee_id, score) VALUES(3, 60);
INSERT INTO tests2(employee_id, score) VALUES(4, null);

SELECT * FROM tests2;

--The following statement calculates the average score of all employees:
SELECT    AVG( score )
FROM    tests2;

--G) Oracle AVG() with NVL() function
--If you want to treat the NULL value as zero for calculating the average, you can use AVG() function together with the NVL() function:
SELECT
    AVG( NVL( score, 0 ))
FROM    tests2;

-----Oracle COUNT
/*The COUNT() function accepts a clause which can be either ALL, DISTINCT, or *:
COUNT(*) function returns the number of items in a group, including NULL and duplicate values.
COUNT(DISTINCT expression) function returns the number of unique and non-null items in a group.
COUNT(ALL expression) evaluates the expression and returns the number of non-null items in a group, including duplicate values.
If you don’t explicitly specify DISTINCT or ALL, the COUNT() function uses the ALL by default.
*/
--A) COUNT(*) vs. COUNT(DISTINCT expr) vs. COUNT(ALL)
--Let’s create a table named items that consists of a val column and insert some sample data into the table for the demonstration.
CREATE TABLE items(val number);

INSERT INTO items(val) VALUES(1);
INSERT INTO items(val) VALUES(1);
INSERT INTO items(val) VALUES(2);
INSERT INTO items(val) VALUES(3);
INSERT INTO items(val) VALUES(NULL);
INSERT INTO items(val) VALUES(4);
INSERT INTO items(val) VALUES(NULL);

SELECT * FROM items;

SELECT     COUNT(*)
FROM    items;

SELECT    COUNT( DISTINCT val )
FROM    items;

SELECT    COUNT( ALL val )
FROM    items;
--B) Simple Oracle COUNT() example
--The following example returns the number of rows in the products table:

SELECT    COUNT(*)
FROM    products;
--C) Oracle COUNT() with WHERE clause example
--If you want to find the number of products in the category id 1, you can add a WHERE clause to the query above
SELECT    COUNT(*)
FROM    products
WHERE    category_id = 1;

/*D) Oracle COUNT() with GROUP BY clause example
To find the number of products in each product category, you use the following statement
*/
SELECT    category_id,    COUNT(*)
FROM    products
GROUP BY    category_id
ORDER BY    category_id;
/*E) Oracle COUNT() with LEFT JOIN clause
The following examples get all category names and the number of products in each category by joining the product_categories with the products table and using the COUNT() function with the GROUP BY clause.
*/
SELECT    category_name,    COUNT( product_id )
FROM    product_categories
LEFT JOIN products        USING(category_id)
GROUP BY    category_name
ORDER BY    category_name;  

/*F) Oracle COUNT() with HAVING clause example
The following statement retrieves category names and the number of products in each. In addition, it uses a HAVING clause to return the only category whose number of products is greater than 50.
*/
SELECT    category_name,    COUNT( product_id )
FROM    product_categories
LEFT JOIN products        USING(category_id)
GROUP BY    category_name
HAVING    COUNT( product_id ) > 50
ORDER BY    category_name;

/*G) Using Oracle COUNT() and HAVING clause to find duplicate values
You can use the COUNT() function and a HAVING clause to find rows with duplicate values in a specified column.
For example, the following statement returns the contacts’ last names that appear more than once:
*/
SELECT    last_name,    COUNT( last_name )
FROM    contacts
GROUP BY    last_name
HAVING    COUNT( last_name )> 1
ORDER BY    last_name;

---Oracle MAX

--The Oracle MAX() function is an aggregate function that returns the maximum value of a set.
-/*A) Simple Oracle MAX() function example
The following example returns the list price of the most expensive (maximum) product:
*/
SELECT    MAX( list_price )
FROM    products;

/*B) Oracle MAX() in subquery
To get the most expensive product information, you use the following query:
*/
SELECT    product_id,    product_name,    list_price
FROM    products
WHERE    list_price =( SELECT  MAX( list_price )
FROM     products    );
--C) Oracle MAX() with GROUP BY clause
--The following statement returns the list price of the most expensive product by product category.
SELECT    category_id,
    MAX( list_price )
FROM    products
GROUP BY    category_id
ORDER BY    category_id;

--D) Oracle MAX() function with HAVING clause
SELECT   category_name,    MAX( list_price )
FROM    products
INNER JOIN product_categories     USING(category_id)
GROUP BY    category_name
--HAVING    MAX( list_price ) BETWEEN 3000 AND 5000
ORDER BY    category_name;

---Oracle SUM
--The Oracle SUM() function is an aggregate function that returns the sum of all or distinct values in a set of values.
--A) Simple Oracle SUM() function example
SELECT    SUM( quantity )
FROM    order_items;
--B) Oracle SUM() with GROUP BY clause
SELECT    product_id,    SUM( quantity )
FROM    order_items
GROUP BY    product_id
ORDER BY    SUM( quantity ) DESC;
--C) Oracle SUM() with HAVING example
SELECT order_id, SUM( quantity * unit_price ) order_total
FROM   order_items
GROUP BY   order_id
HAVING    SUM( quantity * unit_price ) BETWEEN 1000 AND 20000
ORDER BY   order_total DESC;
--D) Oracle SUM() with INNER JOIN clause example
SELECT product_name, SUM( quantity * unit_price ) sales
FROM  order_items
INNER JOIN products  USING(product_id)
GROUP BY  product_name
ORDER BY  sales DESC;

---Oracle MIN
--The Oracle MIN() function is an aggregate function that returns the minimum value of a set.
--A) Simple Oracle MIN() function example
SELECT    MIN( list_price )
FROM    products;
--B) Oracle MIN() in the subquery
SELECT product_id, product_name, list_price
FROM  products
WHERE  list_price =( SELECT MIN( list_price )
FROM   products  );
--C) Oracle MIN() with GROUP BY clause
SELECT  category_id,  MIN( list_price )
FROM   products
GROUP BY   category_id
ORDER BY   category_id;
--To make the result of the query more meaningful, you can get the product category name instead of the category id. To do it, you join the products table with the product_categories table as follows:
SELECT  category_name,  MIN( list_price )
FROM   products
INNER JOIN product_categories   USING(category_id)
GROUP BY    category_name
ORDER BY    category_name;
--D) Oracle MIN() function with HAVING clause

SELECT category_name, MIN( list_price )
FROM  products
INNER JOIN product_categories   USING(category_id)
GROUP BY  category_name
HAVING  MIN( list_price )> 500
ORDER BY  category_name;

---Oracle LISTAGG

--The Oracle LISTAGG() function is an aggregation function that transforms data from multiple rows into a single list of values separated by a specified delimiter. The Oracle LISTAGG() function is typically used to denormalize values from multiple rows into a single value which can be a list of comma-separated values or other human readable format for the reporting purpose.
SELECT  job_title,
 LISTAGG(    first_name,  ',' ) WITHIN GROUP( ORDER BY   first_name  ) AS employees
FROM  employees
GROUP BY    job_title
ORDER BY    job_title;
/*By default, LISTAGG() function uses an ellipsis (…) and the number of overflow characters such as …(120).
The following example shows the category id list and their corresponding product descriptions which are truncated:
*/
SELECT  category_id,
    LISTAGG(   description, ';' ON OVERFLOW TRUNCATE
    ) WITHIN GROUP( ORDER BY  description ) AS products
FROM  products
GROUP BY   category_id
ORDER BY   category_id;
--If you don’t want to use the default ellipsis, you can specify a custom truncation literal by defining it after the ON OVERFLOW TRUNCATE clause as follows
 SELECT category_id, LISTAGG(    description, ';' ON OVERFLOW TRUNCATE '!!!'
    ) WITHIN GROUP( ORDER BY    description ) AS products
FROM   products
GROUP BY    category_id
ORDER BY    category_id;
--To remove the overflow character count, you use the WITHOUT COUNT clause. Note that the LISTAGG() function uses the WITH COUNT clause by default. See the following example:
SELECT  category_id,LISTAGG( description,  ';' ON OVERFLOW TRUNCATE '!!!' WITHOUT COUNT
    ) WITHIN GROUP( ORDER BY   description ) AS products
FROM  products
GROUP BY  category_id
ORDER BY  category_id;

---Oracle Analytic Functions
/*
Oracle analytic functions calculate an aggregate value based on a group of rows and return multiple rows for each group.
Type a function name to search...

Name    Description
CUME_DIST    Calculate the cumulative distribution of a value in a set of values
DENSE_RANK    Calculate the rank of a row in an ordered set of rows with no gaps in rank values.
FIRST_VALUE    Get the value of the first row in a specified window frame.
LAG    Provide access to a row at a given physical offset that comes before the current row without using a self-join.
LAST_VALUE    Get the value of the last row in a specified window frame.
LEAD    Provide access to a row at a given physical offset that follows the current row without using a self-join.
NTH_VALUE    Get the Nth value in a set of values.
NTILE    Divide an ordered set of rows into a number of buckets and assign an appropriate bucket number to each row.
PERCENT_RANK    Calculate the percent rank of a value in a set of values.
RANK    Calculate the rank of a value in a set of values
ROW_NUMBER    Assign a unique sequential integer starting from 1 to each row in a partition or in the whole result
*/
--Oracle CUME_DIST
/*Introduction to Oracle CUME_DIST() function
Sometimes, you want to pull the top or bottom x% values from a data set e.g., top 5% salesman by volume. To do this, you can use the Oracle CUME_DIST() function.

The CUME_DIST() function is an analytic function that calculates the cumulative distribution of a value in a set of values. The result of CUME_DIST() is greater than 0 and less than or equal to 1. Tie values evaluate to the same cumulative distribution value.
*/
--Using Oracle CUME_DIST() function over the result set example
SELECT  salesman_id,  sales,  
    ROUND(cume_dist() OVER (ORDER BY sales DESC) * 100,2) || '%' cume_dist
FROM   salesman_performance
WHERE  YEAR = 2017;
---123456
WITH cte_sales AS (
SELECT  salesman_id,  year, sales, ROUND(CUME_DIST() OVER (PARTITION BY year
        ORDER BY sales DESC
    ),2) cume_dist
FROM   salesman_performance
WHERE    year in (2016,2017))  SELECT   * FROM     cte_sales
WHERE    cume_dist <= 0.30;

--Oracle DENSE_RANK
/*Introduction to Oracle DENSE_RANK() function
The DENSE_RANK() is an analytic function that calculates the rank of a row in an ordered set of rows. The returned rank is an integer starting from 1.

Unlike the RANK() function, the DENSE_RANK() function returns rank values as consecutive integers. It does not skip rank in case of ties. Rows with the same values for the rank criteria will receive the same rank values.
*/
/*Oracle DENSE_RANK() function examples
Let’s take a simple example to understand the DENSE_RANK() function:

Oracle DENSE_RANK() function illustration
First, create a new table named dense_rank_demo for demonstration:
*/
CREATE TABLE dense_rank_demo (
    col VARCHAR2(10) NOT NULL
);
--Next, insert some values into the dense_rank_demo table:
INSERT ALL 
    INTO dense_rank_demo(col) VALUES('A')
    INTO dense_rank_demo(col) VALUES('A')
    INTO dense_rank_demo(col) VALUES('B')
    INTO dense_rank_demo(col) VALUES('C')
    INTO dense_rank_demo(col) VALUES('C')
    INTO dense_rank_demo(col) VALUES('C')
    INTO dense_rank_demo(col) VALUES('D')
SELECT 1 FROM dual; 

SELECT col FROM dense_rank_demo;

SELECT   col,
    DENSE_RANK () OVER (  ORDER BY col )  col
FROM  dense_rank_demo;

--Oracle DENSE_RANK() function examples
--We’ll use the products table from the sample database to demonstrate the DENSE_RANK() function:

SELECT  product_name,  list_price, 
    RANK() OVER(ORDER BY list_price) as my_rank
FROM   products;    
---To get the top-10 cheapest products, you use a common table expression that wraps the above query and selects only 10 products with the lowest prices as follows:
WITH cte_products AS(  
SELECT product_name,list_price, 
    RANK() OVER( ORDER BY list_price ) my_rank
FROM  products)
SELECT * FROM cte_products
WHERE my_rank <= 10;
/*Oracle DENSE_RANK() function with PARTITION BY clause example
The following query returns the top five cheapest products in each category:
*/
WITH cte_products AS(  
SELECT  product_name,  category_id,  list_price, 
    RANK() OVER (PARTITION BY category_id
    ORDER BY list_price  ) my_rank
FROM     products)
SELECT * FROM cte_products
WHERE my_rank <= 5;
---Oracle FIRST_VALUE
--The FIRST_VALUE() is an analytic function that allows you to get the first value in an ordered set of value
--We’ll use the products table from the sample database to demonstrate the FIRST_VALUE() function:
SELECT  product_id,  product_name, list_price, 
    FIRST_VALUE(product_name)  OVER (ORDER BY list_price) first_product
FROM   products
WHERE  category_id = 1;
---To get the lowest price product in each category, you add the query_partition_clause clause and remove the WHERE clause:
SELECT  product_id, product_name,category_id,list_price, 
        FIRST_VALUE(product_name) 
        OVER (  PARTITION BY category_id
            ORDER BY list_price   ) first_product
FROM  products;  

---Oracle LAG
--Oracle LAG() is an analytic function that allows you to access the row at a given offset prior to the current row without using a self-join.
--We will reuse the salesman_performance view created in the LEAD() function tutorial for the demonstration.
SELECT  salesman_id,  year,   sales
FROM     salesman_performance;

WITH cte_sales (
    salesman_id, 
    year, 
    sales,
    py_sales) 
AS (
    SELECT 
        salesman_id,
        year, 
        sales,
        LAG(sales) OVER (
            ORDER BY year
        ) py_sales
    FROM 
        salesman_performance
    WHERE
        salesman_id = 62
)
SELECT  salesman_id, year, sales, py_sales,
    CASE     WHEN py_sales IS NULL THEN 'N/A'
      ELSE     TO_CHAR((sales - py_sales) * 100 / py_sales,'999999.99') || '%'
      END YoY
FROM   cte_sales;

---2
WITH cte_sales (
    salesman_id, 
    year, 
    sales,
    py_sales) 
AS (
    SELECT 
        salesman_id,
        year, 
        sales,
        LAG(sales) OVER (
            PARTITION BY salesman_id
            ORDER BY year
        ) py_sales
    FROM 
        salesman_performance
)
SELECT 
    salesman_id,
    year,
    sales,
    py_sales,
    CASE 
         WHEN py_sales IS NULL THEN 'N/A'
      ELSE
         TO_CHAR((sales - py_sales) * 100 / py_sales,'999999.99') || '%'
      END YoY
FROM 
    cte_sales;
--Oracle LAST_VALUE
--The LAST_VALUE() is an analytic function that allows you to obtain the last value in an ordered set of values.
--We’ll use the products table from the sample database to demonstrate the LAST_VALUE() function.
SELECT  product_id, product_name,list_price,
    LAST_VALUE(product_id) OVER (
        ORDER BY list_price 
        RANGE BETWEEN UNBOUNDED PRECEDING AND 
        UNBOUNDED FOLLOWING) highest_price_product_id
FROM     products;
--Oracle LEAD
--Oracle LEAD() is an analytic function that allows you to access the following row from the current row without using a self-join.
--We will create a view named salesman_performance that returns the sales of the salesman by year based on the orders and order_items tables from the sample database:

CREATE VIEW salesman_performance (salesman_id,  year,  sales
) AS SELECT  salesman_id,  EXTRACT(YEAR FROM order_date), 
    SUM(quantity*unit_price)
FROM     orders
INNER JOIN order_items USING (order_id)
WHERE   salesman_id IS NOT NULL
GROUP BY  salesman_id, EXTRACT(YEAR FROM order_date);
 
SELECT  salesman_id, year, sales
FROM  salesman_performance
ORDER BY  salesman_id, year, sales; 

--The following query uses the LEAD() function to return sales of the following year of the salesman id 55:

SELECT  salesman_id, year, sales,
    LEAD(sales) OVER (   ORDER BY year  ) following_year_sales
FROM   salesman_performance
WHERE  salesman_id = 55;

---The following statement uses the LEAD() function to return sales of the following year for every salesman:
SELECT  salesman_id, year,  sales,
    LEAD(sales) OVER (
        PARTITION BY SALESMAN_ID
        ORDER BY year
    ) following_year_sales
FROM  salesman_performance;
--Oracle NTH_VALUE
--The Oracle NTH_VALUE() function is an analytic function that returns the Nth value in a set of values.
--We will use the products table from the sample database for the demonstration:
SELECT  product_id, product_name, list_price,
    NTH_VALUE(product_name,2) OVER (ORDER BY list_price DESC
        RANGE BETWEEN 
            UNBOUNDED PRECEDING AND 
            UNBOUNDED FOLLOWING  ) AS second_most_expensive_product
FROM    products;
---Oracle NTILE
--Oracle NTILE() function is an analytical function that divides an ordered result set into a number of and assigns an appropriate bucket number to each row.
--We will use the salesman_performance view for the demonstration
CREATE OR REPLACE VIEW salesman_performance ( salesman_id, year, sales
) AS
SELECT salesman_id,  EXTRACT(YEAR FROM order_date),  SUM(quantity*unit_price)
FROM   orders
INNER JOIN order_items USING (order_id)
WHERE    salesman_id IS NOT NULL
GROUP BY   salesman_id,   EXTRACT(YEAR FROM order_date);
---The following statement divides into 4 buckets the values in the sales column of the salesman_performance view from the year of 2017.
SELECT  salesman_id, sales, NTILE(4) OVER(
        ORDER BY sales DESC  ) quartile
FROM    salesman_performance
WHERE    year = 2017;
--The following statement divides into 4 buckets the values in the sales column of the salesman_performance view in the year of 2016 and 2017:
SELECT   salesman_id,  sales,  year,
    NTILE(4) OVER(
        PARTITION BY year
        ORDER BY sales DESC
    ) quartile
FROM    salesman_performance
WHERE   year = 2016 OR year = 2017;

---Oracle PERCENT_RANK
---link https://www.oracletutorial.com/oracle-analytic-functions/oracle-percent_rank/

/*
The PERCENT_RANK() function is similar to the CUME_DIST() function. The PERCENT_RANK() function calculates the cumulative distribution of a value in a set of values. The result of PERCENT_RANK() function is between 0 and 1, inclusive. Tie values evaluate to the same cumulative distribution value.
*/
--1) Using Oracle PERCENT_RANK() function over the result set example
SELECT  salesman_id, sales,  
    ROUND( PERCENT_RANK() OVER (   
    ORDER BY sales DESC ) * 100) || '%' percent_rank
FROM  salesman_performance
WHERE   YEAR = 2017;
--2) Using Oracle PERCENT_RANK() function over partition example

SELECT salesman_id, year,  sales,  
    ROUND(PERCENT_RANK() OVER (
        PARTITION BY year
        ORDER BY sales DESC  ) * 100.2) || '%' percent_rank
FROM   salesman_performance
WHERE  year in (2016,2017);   
--Oracle RANK
/*
The RANK() function is an analytic function that calculates the rank of a value in a set of values.
The RANK() function returns the same rank for the rows with the same values. It adds the number of tied rows to the tied rank to calculate the next rank. Therefore, the ranks may not be consecutive numbers.
The RANK() function is useful for top-N and bottom-N queries.
*/ 
/*Oracle RANK() function examples
First, create a new table named rank_demo that consists of one column:
*/
CREATE TABLE rank_demo (
col VARCHAR(10) NOT NULL);  

INSERT ALL 
INTO rank_demo(col) VALUES('A')
INTO rank_demo(col) VALUES('A')
INTO rank_demo(col) VALUES('B')
INTO rank_demo(col) VALUES('C')
INTO rank_demo(col) VALUES('C')
INTO rank_demo(col) VALUES('C')
INTO rank_demo(col) VALUES('D')
SELECT 1 FROM dual; 

SELECT col FROM rank_demo; 

 SELECT  col, 
    RANK() OVER (ORDER BY col) my_rank
FROM   rank_demo;
--The following statement calculates the rank of each product by its list price:
SELECT  product_name,   list_price, 
    RANK() OVER(ORDER BY list_price DESC) rank
FROM   products;
--To get the top 10 most expensive products, you use the following statement
WITH cte_products AS (
    SELECT  product_name,     list_price, 
        RANK() OVER(ORDER BY list_price DESC) price_rank
    FROM    products)
SELECT  product_name, list_price, price_rank
    FROM  cte_products
WHERE  price_rank <= 10;
--Using Oracle RANK() function with PARTITION BY example
--The following example returns the top-3 most expensive products for each category:
WITH cte_products AS (
    SELECT  product_name,  list_price, category_id,
        RANK() OVER(   PARTITION BY category_id
        ORDER BY list_price DESC)  price_rank
    FROM   products)
SELECT  product_name,  list_price, category_id, price_rank
FROM    cte_products
WHERE   price_rank <= 3;
----Oracle ROW_NUMBER
/*
The ROW_NUMBER() is an analytic function that assigns a sequential unique integer to each row to which it is applied, either each row in the partition or each row in the result set.
The following illustrates the syntax of the ROW_NUMBER() function:
*/
--We’ll use the products table from the sample database to demonstrate the ROW_NUMBER() function.
--The following statement returns the row number, product name, and list price from the products table. The row number values are assigned based on the order of list prices
SELECT  ROW_NUMBER() OVER(   ORDER BY list_price DESC
    ) row_num,  product_name,  list_price
FROM  products;

/*.
The ROW_NUMBER() function is useful for pagination in applications.

Suppose you want to display products by pages with the list price from high to low, each page has 10 products. To display the third page, you use the ROW_NUMBER() function as follows:
*/
WITH cte_products AS (
    SELECT  row_number() OVER(
     ORDER BY list_price DESC    ) row_num,  product_name,   list_price
    FROM       products)
SELECT * FROM cte_products
WHERE row_num > 30 and row_num <= 40; 

--Using Oracle ROW_NUMBER() function for the top-N query example
--To get a single most expensive product by category, you can use the ROW_NUMBER() function as shown in the following query:
WITH cte_products AS (
SELECT  row_number() OVER(
        PARTITION BY category_id
        ORDER BY list_price DESC
    ) row_num, category_id, product_name, list_price
FROM   products)
SELECT * FROM cte_products
WHERE row_num = 1;
---Oracle Date Functions
---https://www.oracletutorial.com/oracle-date-functions/
select ADD_MONTHS( DATE '2016-02-29', 1 ) days from dual;

SELECT CURRENT_DATE FROM dual;

SELECT CURRENT_TIMESTAMP FROM dual;

SELECT DBTIMEZONE FROM dual;

select EXTRACT(YEAR FROM SYSDATE) Year from dual;

select FROM_TZ(TIMESTAMP '2017-08-08 08:09:10', '-09:00') time from dual;

select LAST_DAY(DATE '2016-02-01') last_day from dual;

SELECT LOCALTIMESTAMP FROM dual;

select MONTHS_BETWEEN( DATE '2017-07-01', DATE '2021-01-01' ) Difference from dual;

select NEW_TIME( TO_DATE( '08-07-2017 01:30:45', 'MM-DD-YYYY HH24:MI:SS' ), 'AST', 'PST' ) as day_time from dual;

select NEXT_DAY( DATE '2000-01-01', 'SUNDAY' ) next_day from dual;

select ROUND(DATE '2017-07-16', 'MM') Round from dual;

SELECT SESSIONTIMEZONE FROM dual;

SELECT SYSTIMESTAMP FROM dual;

select TO_CHAR( DATE'2017-01-01', 'DL' ) to_char from dual;

select TO_DATE( '01 Jan 2017', 'DD MON YYYY' ) to_date from dual;

select  TRUNC(DATE '2017-07-16', 'MM') trunc from dual;

select TZ_OFFSET( 'Europe/London' ) as tz_offset from dual;

---Ooracle-add_months

--https://www.oracletutorial.com/oracle-date-functions/oracle-add_months/

--Oracle ADD_MONTHS() function adds a number of month (n) to a date and returns the same day n of month away.
/*A) Add a number of months to a date

The following example adds 1 month to 29-FEB-2016:
*/
SELECT   ADD_MONTHS( DATE '2016-01-31', 1 )
FROM   dual;
/*
B) Add a negative number of months to a date
The following statement illustrates the effect of using a negative month for the ADD_MONTH() function:
*/
SELECT  ADD_MONTHS( DATE '2016-03-31', -1 )
FROM  dual; 
/*C) Get the last day of the last month
The following statement returns the last day of the last month.
*/
SELECT  LAST_DAY( ADD_MONTHS(SYSDATE , - 1 ) ) date_time
FROM  dual;
--https://www.oracletutorial.com/oracle-date-functions/oracle-current_date/
---Oracle CURRENT_DATE
ALTER SESSION SET NLS_DATE_FORMAT = 'DD-MON-YYYY HH24:MI:SS';

SELECT  SESSIONTIMEZONE
FROM  DUAL;

SELECT  CURRENT_DATE
FROM  DUAL;

SELECT  CURRENT_TIMESTAMP
FROM  dual;

---Oracle EXTRACT
--The Oracle EXTRACT() function extracts a specific component (year, month, day, hour, minute, second, etc.,) from a datetime or an interval value.
SELECT  EXTRACT( YEAR FROM TO_DATE( '31-Dec-1999 15:30:20 ',  'DD-Mon-YYYY HH24:MI:SS' ) ) YEAR
FROM  DUAL;
--month
SELECT  EXTRACT( MONTH FROM TO_DATE( '31-Dec-1999 15:30:20 ',  'DD-Mon-YYYY HH24:MI:SS' ) ) MONTH
FROM  DUAL;
--days
SELECT  EXTRACT( DAY FROM TO_DATE( '30-Oct-1999 15:30:20 ',  'DD-Mon-YYYY HH24:MI:SS' ) ) DAY
FROM  DUAL;
--To extract values of HOUR, MINUTE, and SECOND fields, you use TO_CHAR() functi
SELECT
  TO_CHAR( SYSDATE, 'HH24' ) hour, 
  TO_CHAR( SYSDATE, 'MI' ) minute,
  TO_CHAR( SYSDATE, 'SS' ) second
FROM  DUAL;

SELECT  EXTRACT( YEAR FROM INTERVAL '5-2' YEAR TO MONTH )
FROM  DUAL;

SELECT  EXTRACT( MONTH FROM INTERVAL '5-2' YEAR TO MONTH )
FROM  DUAL;

SELECT  EXTRACT( DAY FROM INTERVAL '5 04:30:20.11' DAY TO SECOND )
FROM  dual;

SELECT  EXTRACT( HOUR FROM INTERVAL '5 04:30:20.11' DAY TO SECOND )
FROM  dual;
SELECT  EXTRACT( MINUTE FROM INTERVAL '5 04:30:20.11' DAY TO SECOND )
FROM  dual;
SELECT  EXTRACT( SECOND FROM INTERVAL '5 04:30:20.11' DAY TO SECOND )
FROM  dual;  

SELECT 
    EXTRACT(year FROM order_date) year,
    EXTRACT(month FROM order_date) month,
    COUNT(order_id) order_count
FROM orders
GROUP BY 
     EXTRACT(YEAR FROM order_date),
    EXTRACT(MONTH FROM order_date)
ORDER BY year DESC, month;

SELECT 
    EXTRACT(YEAR FROM :input_date) year,
    EXTRACT(MONTH FROM :input_date) month,
    EXTRACT(DAY FROM :input_date) day
FROM dual;
--error 
SELECT 
    EXTRACT(YEAR FROM TO_DATE(:input_date,'yyyymmdd')) year,
    EXTRACT(MONTH FROM TO_DATE(:input_date,'yyyymmdd')) month,
    EXTRACT(DAY FROM TO_DATE(:input_date,'yyyymmdd')) day
FROM dual;
--Oracle FROM_TZ
SELECT  FROM_TZ(TIMESTAMP '2017-08-08 08:09:10', '-07:00')
FROM  DUAL;
---Oracle DBTIMEZONE
--To get the database time zone, you use the following statement:
SELECT  DBTIMEZONE
FROM  dual;

SELECT t.owner, t.table_name,t.column_name, t.data_type
FROM  dba_tab_cols t
INNER JOIN dba_objects o ON o.owner = t.owner AND t.table_name = o.object_name
WHERE t.data_type LIKE '%WITH LOCAL TIME ZONE' 
   AND o.object_type = 'TABLE' AND  o.owner = 'OT';
----Oracle ROUND
SELECT  TO_CHAR( ROUND( TO_DATE( sysdate,  'DD-Mon-YYYY HH24:MI:SS' ) ), 
  'DD-Mon-YYYY HH24:MI:SS' )  rounded_result
FROM  dual;  
 
--Oracle SESSIONTIMEZONE
SELECT  SESSIONTIMEZONE
FROM  dual;
--Oracle SYSDATE
SELECT     TO_CHAR(SYSDATE, 'MM-DD-YYYY HH24:MI:SS') 
FROM     dual;
---Oracle SYSTIMESTAMP
SELECT  SYSTIMESTAMP
FROM  dual;

SELECT  TO_CHAR(SYSTIMESTAMP,'DD-MON-YYYY HH24:MI:SS.FF2 TZH:TZM') as SYSTIMESTAMP
FROM  dual; 
---Oracle MONTHS_BETWEEN
SELECT  MONTHS_BETWEEN( DATE '2017-07-01', DATE '2017-01-01' ) MONTH_DIFF
FROM  DUAL;
SELECT  MONTHS_BETWEEN( DATE '2017-03-31', DATE '2017-02-28' ) MONTH_DIFF
FROM  DUAL;
---Oracle NEXT_DAY
---https://www.oracletutorial.com/oracle-date-functions/oracle-next_day/
SELECT  NEXT_DAY( DATE '2000-01-01', 'SUNDAY' )
FROM  dual;

SELECT  first_name,last_name, hire_date, 
  NEXT_DAY( hire_date, 'Monday' )  NEXT_MONDAY
FROM  employees
ORDER BY  hire_date DESC; 
---Oracle NEW_TIME
--https://www.oracletutorial.com/oracle-date-functions/oracle-new_time/
SELECT  NEW_TIME( TO_DATE( '08-07-2017 01:30:45', 'MM-DD-YYYY HH24:MI:SS' ),  'AST', 'PST' ) TIME_IN_PST
FROM  DUAL;
---Oracle LOCALTIMESTAMP
--https://www.oracletutorial.com/oracle-date-functions/oracle-localtimestamp/
SELECT  LOCALTIMESTAMP,   CURRENT_TIMESTAMP
FROM  dual;
---Oracle LAST_DAY
---https://www.oracletutorial.com/oracle-date-functions/oracle-last_day/
SELECT  LAST_DAY(SYSDATE)
FROM  dual;

SELECT  LAST_DAY( SYSDATE ) - SYSDATE
FROM  dual;
SELECT  LAST_DAY(ADD_MONTHS(SYSDATE,-1 )) LAST_DAY_LAST_MONTH,
  LAST_DAY(ADD_MONTHS(SYSDATE,1 )) LAST_DAY_NEXT_MONTH
FROM  dual;

SELECT  LAST_DAY( DATE '2000-02-01') LAST_DAY_OF_FEB_2000,
  LAST_DAY( DATE '2016-02-01') LAST_DAY_OF_FEB_2016,
  LAST_DAY( DATE '2017-02-01') LAST_DAY_OF_FEB_2017
FROM  dual;

----https://www.oracletutorial.com/oracle-date-functions/oracle-to_date/
---Oracle TO_DATE
SELECT  TO_DATE( '5 Jan 2017', 'DD MON YYYY' )
FROM  dual;
---https://www.oracletutorial.com/oracle-date-functions/oracle-to_char/
---Oracle TO_CHAR
SELECT  TO_CHAR( sysdate, 'DL' )
FROM  dual;
SELECT  first_name, last_name, 
  TO_CHAR( hire_date, 'Q' ) joined_quarter
FROM  employees
WHERE hire_date BETWEEN DATE  '2016-01-01'  AND date '2016-12-31'
ORDER BY first_name, last_name;
--Oracle TRUNC
--https://www.oracletutorial.com/oracle-date-functions/oracle-trunc/
--The Oracle TRUNC() function returns a DATE value truncated to a specified unit.
SELECT  TO_CHAR( 
    TRUNC(TO_DATE( '04-Aug-2017 15:35:32 ', 'DD-Mon-YYYY HH24:MI:SS' )), 
    'DD-Mon-YYYY HH24:MI:SS'   ) result
FROM  dual; 

SELECT  TRUNC( SYSDATE, 'MM' ) result
FROM  dual;
--Oracle TZ_OFFSET
--The Oracle TZ_OFFSET() function returns the time zone offset from UTC of a valid time zone name or the SESSIONTIMEZONE or DBTIMEZONE function name.
SELECT  TZ_OFFSET( 'Europe/London' )
FROM  DUAL;
SELECT  TZ_OFFSET( DBTIMEZONE )
FROM  DUAL;

SELECT  TZ_OFFSET( SESSIONTIMEZONE )
FROM  DUAL;

----Oracle String Functions
--This tutorial provides you the most commonly used Oracle string functions that help you manipulate character strings more effectively.
---CHR() function
SELECT  first_name  || ' '  || last_name  || 
  CHR( 9 )  || ' joined on '  || CHR( 9 )  || 
  to_char(hire_date,'DD-MON-YYYY') first_5_employees
FROM  employees
ORDER BY  hire_date
FETCH  FIRST 5 ROWS ONLY;
--Oracle CONCAT
--The Oracle CONCAT() function concatenates two strings and returns the combined string.
SELECT  CONCAT('Abdul',' Hafeez') As Full_Name
FROM    dual;
--If you want to concatenate more than two strings, you need to apply the CONCAT() function multiple times as shown in the following example:
SELECT  CONCAT( CONCAT( 'Happy', ' coding' ), ' together' ) as Name
FROM  dual;

--In addition to the CONCAT() function, Oracle also provides you with the concatenation operator (||) that allows you to concatenate two or more strings in a more readable fashion:
SELECT  'Happy' || ' coding'  || ' together'
FROM  dual;

----Oracle CONVERT
--The Oracle CONVERT() function converts a string from one character set to another.
--Note that the CONVERT() function is often used to correct data stored in the database with a wrong character set.
SELECT  CONVERT( 'ABC', 'utf8', 'us7ascii' )
FROM  dual;

SELECT  CONVERT( 'Ä Ê Í', 'US7ASCII', 'WE8ISO8859P1' )
FROM  DUAL;

SELECT  value
FROM  V$NLS_VALID_VALUES
WHERE  parameter = 'CHARACTERSET' AND ISDEPRECATED = 'FALSE'
ORDER BY  value;
---Oracle DUMP
---The Oracle DUMP() function allows you to find the data type, length, and internal representation of a value.
/*
1) Basic Oracle DUMP() function examples
The following example uses the DUMP() function to display the type, length, and internal representation of the string
*/
SELECT     DUMP('Oracle DUMP') AS result
FROM     DUAL; 
---
SELECT     DUMP('Oracle DUMP',17) AS result
FROM     DUAL; 
/*2) Using Oracle DUMP() function with table data example
This example uses the DUMP() function to show the data type, length, and internal representation of the customer names from the customers table:
*/
SELECT     name,     DUMP(name) result
FROM     customers
ORDER BY     name;
---Oracle INSTR
--The Oracle INSTR() function searches for a substring in a string and returns the position of the substring in a string.
SELECT  INSTR( 'This is a playlist', 'is' ) substring_location
FROM  dual;
SELECT  INSTR( 'This is a playlist', 'is', 1, 2 ) second_occurrence,
  INSTR( 'This is a playlist', 'is', 1, 3 ) third_occurrence
FROM  dual;
SELECT  INSTR( 'This is a playlist', 'are' ) substring_location
FROM  dual;
SELECT  INSTR( 'This is a playlist', 'is',-1 ) substring_location
FROM  dual;
----Oracle INITCAP
/*The Oracle INITCAP() function converts the first letter of each word to uppercase and other letters to lowercase.

By definition, words are sequences of alphanumeric characters delimited by a space or any other non-alphanumeric letter.
*/
SELECT  INITCAP( 'hi Hafeez' ) Proper_case
FROM  DUAL;
--The following statement selects the first name and last name from the contacts table. In addition, it constructs the full name and converts it to the proper case using the INITCAP() function.
SELECT  INITCAP( first_name || ' ' || last_name ) full_name
FROM  contacts
ORDER BY  full_name; 
---If you want to convert a string to uppercase, you use the UPPER() function.
--- In case you want to convert a string to lowercase, you use the LOWER() function. 
--Oracle LENGTH
---The Oracle LENGTH() function returns the number of characters of a specified string. It measures the length of the string in characters as defined by the input character set.
SELECT   'Oracle LENGTH' string,
  LENGTH('Oracle LENGTH') Len
FROM   dual;

SELECT  first_name,
  LENGTH(first_name)
FROM  employees
ORDER BY     LENGTH(first_name) DESC;
---
SELECT  LENGTH( first_name ) len, 
  COUNT( * )
FROM  employees
GROUP BY   LENGTH( first_name )
ORDER BY len;
/*Suppose, you have to display a list of products with their excerpts on the company’s website.

The following statement uses the LENGTH() function with CONCAT() and SUBSTR() functions to return the excerpts for products.
*/
SELECT  product_name,
  CASE
    WHEN LENGTH( description ) > 50 THEN CONCAT( SUBSTR( description,
      1, 50 ), '...' )
    ELSE description
  END product_excerpt
FROM  products
ORDER BY  product_name; 
---Oracle LOWER
---The Oracle LOWER() function converts all letters in a string to lowercase.
SELECT  LOWER( 'LOWER Function' )
FROM  dual;
SELECT  first_name,   last_name,   email
FROM  contacts
WHERE  LOWER( last_name ) = 'hill';
---Oracle LTRIM
---Oracle LTRIM() function removes from the left-end of a string all characters contained in a set.
SELECT  LTRIM( '  XYZ' )
FROM  dual; 
SELECT  LTRIM( '123456XYZ', '123' )
FROM  dual; 

SELECT  product_name
FROM  products
WHERE  product_name LIKE 'ASRock%'
ORDER BY  product_name;
---
SELECT  product_name, 
  LTRIM( product_name, 'ASRock' ) short_product_name
FROM  products
WHERE  product_name LIKE 'ASRock%'
ORDER BY  product_name;

----Oracle LPAD
------The Oracle LPAD() function returns a string left-padded with specified characters to a certain length.
SELECT LPAD( 'ABC', 5, '*' )
FROM  dual;
---
SELECT  LPAD( '123', 8, '0' ) RESULT
FROM  dual
UNION SELECT
  LPAD( '7553', 8, '0' )
FROM  dual
UNION
SELECT  LPAD( '98753', 8, '0' )
FROM  dual
UNION
SELECT  LPAD( '754226', 8, '0' )
FROM  dual;
---Employee table
SELECT  employee_id, 
  level, 
  LPAD( ' ',( level - 1 ) * 3 ) || last_name ||  ', ' || first_name full_name
FROM  employees
  START WITH manager_id IS NULL
  CONNECT BY manager_id  = prior employee_id;
 
---Oracle REPLACE
--The Oracle REPLACE() function replaces all occurrences of a specified substring in a string with another.

CREATE TABLE articles(
    article_id NUMBER GENERATED BY DEFAULT AS IDENTITY, 
    title VARCHAR2( 255 ),
    article_body VARCHAR2(4000),
    PRIMARY KEY (article_id)
);
INSERT INTO articles( title, article_body)  
VALUES('Sample article','This is a <strong>sample</strong> article');

INSERT INTO articles( title, article_body)  
VALUES('Another article','Another excellent <strong>sample</strong> article');

UPDATE  articles
SET  article_body = REPLACE( article_body, '<strong>', '<b>' );

UPDATE  articles
SET  article_body = REPLACE( article_body, '</strong>', '</b>' );
SELECT  article_id, title, article_body
FROM  articles;
---Oracle REGEXP_COUNT
--The REGEXP_COUNT() function complements the functionality of the REGEXP_INSTR() function by returning the number of times a pattern occurs in a string.
SELECT     REGEXP_COUNT('An apple costs 50 cents, a banana costs 10 cents.','\d+') result
FROM     dual;
--Oracle REGEXP_INSTR
--The REGEXP_INSTR() function enhances the functionality of the INSTR() function by allowing you to search for a substring in a string using a regular expression pattern.
SELECT     REGEXP_INSTR(
        'If you have any question please call 123-456-7890 or (123)-456-7891',
        '(\+?( |-|\.)?\d{1,2}( |-|\.)?)?(\(?\d{3}\)?|\d{3})( |-|\.)?(\d{3}( |-|\.)?\d{4})') First_Phone_No
FROM    dual;

---Oracle REGEXP_SUBSTR
--The Oracle REGEXP_SUBSTR() function is an advanced version of the SUBSTR()function that allows you to search for substrings based on a regular expression. Instead of returning the position of the substring, it returns a portion of the source string that matches the regular expression.
SELECT  regexp_substr( 'This is a regexp_substr demo', '[[:alpha:]]+', 1, 4
  ) the_4th_word
FROM  dual;
SELECT  regexp_substr( 'This is a regexp_substr demo', '[[:alpha:]]+', 1,  LEVEL ) regexp_substr
FROM  dual
 CONNECT BY LEVEL <= regexp_count( 'This is a regexp_substr demo',  ' ' ) + 1;
 
 SELECT product_id,product_name,  description
FROM  products
WHERE  category_id = 4
ORDER BY  product_name ;
---
SELECT  product_id,   product_name,   description, 
  REGEXP_SUBSTR( description,  '\d+(GB|TB)' ) max_ram
FROM  products
WHERE  category_id = 4;
---Oracle REGEXP_REPLACE
--The Oracle REGEXP_REPLACE() function replaces a sequence of characters that matches a regular expression pattern with another string.
--https://www.oracletutorial.com/oracle-string-functions/oracle-regexp_replace/
SELECT  regexp_replace(
  'This line    contains    more      than one   spacing      between      words'
  , '( ){2,}', ' ' ) regexp_replace
FROM  dual;
---
SELECT  first_name,   last_name,  REGEXP_REPLACE( phone,  '(\d{3})\.(\d{3})\.(\d{4})',  '(\1) \2-\3' ) phone_number
FROM  employees
ORDER BY  phone_number;
---Oracle REGEXP_LIKE
--The Oracle REGEXP_LIKE() function is an advanced version of the LIKE operator. The REGEXP_LIKE() function returns rows that match a regular expression pattern.
SELECT  first_name
FROM  employees
WHERE  REGEXP_LIKE( first_name, 'c' )
ORDER BY first_name;

SELECT  first_name
FROM  employees
WHERE  REGEXP_LIKE(first_name,'^m|^n','i')
ORDER BY first_name;   

---Oracle RPAD
--The Oracle RPAD() function returns a string right-padded with specified characters to a certain length.
SELECT  RPAD( 'XYZ', 6, '+' )
FROM  dual;
SELECT  RPAD( 'Testing', 4, '-' )
FROM  dual;
--
SELECT  name,   credit_limit,   RPAD( '$', credit_limit / 100, '$' )
FROM  customers
ORDER BY  name;
---Oracle RTRIM
--Oracle RTRIM() function removes all characters that appear in a specified set from the right end of a string.
--https://www.oracletutorial.com/oracle-string-functions/oracle-rtrim/
SELECT  RTRIM( 'ABC  ' )
FROM  dual;  
SELECT  RTRIM( 'ABC12345543', '345' )
FROM  dual;
--
SELECT  product_name,
  RTRIM(product_name,'V12345679') short_name
FROM  products
WHERE  product_name LIKE '%V_'
ORDER BY  product_name; 
---Oracle SUBSTR
--https://www.oracletutorial.com/oracle-string-functions/oracle-substr/
---The Oracle SUBSTR() function extracts a substring from a string with various flexible options.
SELECT  SUBSTR( 'Oracle Substring', 1, 6 ) SUBSTRING
FROM  dual;
---employee table exmple
SELECT  SUBSTR( first_name, 1, 1 ) initials ,
  COUNT( * ) 
FROM  employees
GROUP BY  SUBSTR( first_name, 1, 1 )
ORDER BY  initials;
---Oracle SOUNDEX
--https://www.oracletutorial.com/oracle-string-functions/oracle-soundex/
---The SOUNDEX() function returns a string that contains the phonetic representation of a string.
SELECT     SOUNDEX('see') see, 
    SOUNDEX('sea') sea 
FROM   dual;
---
SELECT     first_name,     last_name 
FROM     contacts 
WHERE     SOUNDEX(last_name) = SOUNDEX('bull') 
ORDER BY     last_name;
---Oracle TRIM
--https://www.oracletutorial.com/oracle-string-functions/oracle-trim/
---Oracle TRIM() function removes spaces or specified characters from the begin, end or both ends of a string.
SELECT  TRIM( '  ABC  ' )
FROM  dual;
SELECT  TRIM( LEADING ' ' FROM  ' ABC ' )
FROM  dual;
SELECT  TRIM( TRAILING ' ' FROM  '  ABC  ' )
FROM  dual;
SELECT  TRIM(LEADING  '0' FROM  '00012345' )
FROM  dual;
---update
UPDATE      contacts
SET    first_name = TRIM(first_name),   last_name = TRIM(last_name);
---Oracle TRANSLATE
---https://www.oracletutorial.com/oracle-string-functions/oracle-translate/
--The Oracle TRANSLATE() function returns a string with all occurrences of each character in a string replaced by its corresponding character in another string.
SELECT  TRANSLATE( '5*[2+6]/{9-3}', '[]{}', '()()' )
FROM  DUAL;
SELECT
  TRANSLATE( '[127.8, 75.6]', '[,]', '( )' ) Point, 
  TRANSLATE( '(127.8 75.6)', '( )', '[,]' ) Coordinates
FROM  dual; 
--Oracle UPPER
--https://www.oracletutorial.com/oracle-string-functions/oracle-upper/
--The Oracle UPPER() function converts all letters in a string to uppercase.
SELECT  UPPER( 'string functions' )
FROM  dual;
---
SELECT  UPPER( SUBSTR( first_name, 1, 1 ) ) initials, 
  COUNT( * )
FROM  contacts
GROUP BY  UPPER( SUBSTR( first_name, 1, 1 ) )
ORDER BY  initials;

UPDATE  contacts
SET  last_name = 'HILL'
WHERE  contact_id = 38;
--
SELECT  contact_id,   first_name,   last_name,   email
FROM  contacts
WHERE  UPPER( last_name ) = 'HILL';
--Oracle Comparison Functions
--https://www.oracletutorial.com/oracle-comparison-functions/
/*
COALESCE – show you how to substitute null with a more meaningful alternative.
DECODE – learn how to add if-then-else logic to a SQL query.
NVL – return the first argument if it is not null, otherwise, returns the second argument.
NVL2 – show you how to substitute a null value with various options.
NULLIF – return a null if the first argument equals the second one, otherwise, returns the first argument.
*/
---Oracle DECODE Function
--https://www.oracletutorial.com/oracle-comparison-functions/oracle-decode/
--The Oracle DECODE() function allows you to add the procedural if-then-else logic to the query
SELECT  DECODE(1, 1, 'One')
FROM  dual;
---
SELECT DECODE(1, 2, 'One','Not one')
FROM  dual; 
---
SELECT
  DECODE(country_id, 'US','United States', 'UK', 'United Kingdom', 'JP','Japan'
  , 'CA', 'Canada', 'CH','Switzerland', 'IT', 'Italy', country_id) country ,
  COUNT(*)
FROM  locations
GROUP BY  country_id
HAVING  COUNT(*) > =2
ORDER BY  country_id;
---
SELECT  first_name,  last_name,  job_title
FROM  employees
ORDER BY  DECODE('J', 'F', first_name, 'L', last_name, 'J', job_title);
---Product table
WITH list_prices AS(
    SELECT
      ROUND(AVG(list_price),2) average
    FROM
      products
)
SELECT
  DECODE( SIGN( (list_price - average ) ), 
  1, '> Average of ' || average , 
  0, 'Average', 
  -1, '< Average of ' || average) list_price,
  COUNT(*)
FROM  products,
  list_prices GROUP BY
  DECODE( SIGN( (list_price - average ) ), 
  1, '> Average of ' || average , 
  0, 'Average', 
  -1, '< Average of ' ||average );

--with sub example
SELECT 
  category_name, 
  SUM(DECODE(GREATEST(list_price, 0), LEAST(list_price, 1000), 1, 0)) "< 1000",
  SUM(DECODE(GREATEST(list_price,1001), LEAST(list_price, 2000), 1, 0)) "1001-2000", 
  SUM(DECODE(GREATEST(list_price,2001), LEAST(list_price,3000), 1, 0)) "2001-3000", 
  SUM(DECODE(GREATEST(list_price,3001), LEAST(list_price,8999), 1, 0)) "3001-8999"
FROM   products 
INNER JOIN product_categories USING (category_id)
GROUP BY   category_name; 
--
SELECT  DECODE(NULL,NULL,'Equal','Not equal')
FROM  dual;
---Oracle COALESCE Function
---https://www.oracletutorial.com/oracle-comparison-functions/oracle-coalesce/
----The Oracle COALESCE() function accepts a list of arguments and returns the first one that evaluates to a non-null value.
SELECT  COALESCE(NULL,1,'A')
FROM  dual;  
--create table
CREATE  TABLE emergency_contacts  (
    contact_id   NUMBER GENERATED BY DEFAULT AS IDENTITY,
    employee_id  NUMBER NOT NULL,
    first_name   VARCHAR2(100) NOT NULL,
    last_name    VARCHAR2(100) NOT NULL,
    relationship VARCHAR2(100),
    home_phone   VARCHAR2(25),
    work_phone   VARCHAR2(25),
    cell_phone   VARCHAR2(25),
    PRIMARY KEY (contact_id),
    FOREIGN KEY (employee_id) 
    REFERENCES employees(employee_id) ON DELETE CASCADE
); 
INSERT INTO emergency_contacts ( employee_id, first_name, last_name, relationship, home_phone, work_phone, cell_phone )
VALUES ( 1,
         'Mary',
         'Bailey',
         'Wife',
         NULL,
         '515.123.4568',
         '515.123.4569' );


INSERT INTO emergency_contacts ( employee_id, first_name, last_name, relationship, home_phone, work_phone, cell_phone )
VALUES ( 2,
         'John',
         'Rivera',
         'Husband',
         NULL,
         NULL,
         '515.123.3563' );


INSERT INTO emergency_contacts ( employee_id, first_name, last_name, relationship, home_phone, work_phone, cell_phone )
VALUES ( 3,
         'Joan',
         'Cooper',
         'Mother',
         NULL,
         NULL,
         NULL );
--
SELECT
  e.first_name  || ' '  || e.last_name employee,
  c.first_name  || ' '  || c.last_name contact,
  relationship,
  COALESCE(home_phone, work_phone, cell_phone, 'N/A') phone
FROM
  emergency_contacts c
INNER JOIN employees e  USING (employee_id); 
--Oracle NULLIF Function
--https://www.oracletutorial.com/oracle-comparison-functions/oracle-nullif/
--The Oracle NULLIF() function accepts two arguments. It returns a null value if the two arguments are equal. In case the arguments are not equal, the NULLIF() function returns the first argument.
CREATE TABLE budgets
(
    salesman_id   NUMBER NOT NULL,
    fiscal_year SMALLINT,
    current_year  NUMBER,
    previous_year NUMBER);
    
INSERT INTO budgets VALUES(54,2017,120000, 100000);  
INSERT INTO budgets VALUES(55,2017,200000, 200000);  
INSERT INTO budgets VALUES(56,2017,NULL, 150000);  
INSERT INTO budgets VALUES(57,2017,175000, 175000);  
INSERT INTO budgets VALUES(59,2017,220000, 200000);
--
SELECT  salesman_id,
  COALESCE(TO_CHAR(NULLIF(current_year, previous_year)), 'Same as last year') budget
FROM  budgets
WHERE  current_year IS NOT NULL;
--case
SELECT  salesman_id,
  CASE
    WHEN current_year = previous_year
    THEN 'Same as last year'
    ELSE TO_CHAR(current_year)
  END
FROM  budgets
WHERE  current_year IS NOT NULL;
---Oracle NVL Function
--https://www.oracletutorial.com/oracle-comparison-functions/oracle-nvl/
--The Oracle NVL() function allows you to replace null with a more meaningful alternative in the results of a query.
SELECT  NVL(100,200)
FROM  dual;
---
SELECT  order_id,  NVL(first_name, 'Not Assigned')
FROM  orders
LEFT JOIN employees
ON  employee_id = salesman_id
WHERE  EXTRACT(YEAR FROM order_date) = 2016
ORDER BY  order_date;
--case
SELECT  order_id,
  CASE
    WHEN first_name IS NOT NULL
    THEN first_name
    ELSE 'Not Assigned'
  END
FROM  orders
LEFT JOIN employees
ON  employee_id = salesman_id
WHERE  EXTRACT(YEAR FROM order_date) = 2016
ORDER BY  order_date;  
--https://www.oracletutorial.com/oracle-comparison-functions/oracle-nvl2/
--Oracle NVL2 Function
/*The Oracle NVL2() function is an extension of the NVL() function with different options based on whether a NULL value exists.

The Oracle NVL2() function accepts three arguments. If the first argument is not null, then it returns the second argument. In case the second argument is null, then it returns the third argument.
*/
SELECT  NVL2(NULL, 1, 2) -- 2
FROM  dual; 
--
SELECT  order_id,  order_date,
  nvl2(first_name, first_name  || ' '  || last_name, 'Not assigned') salesman
FROM  orders
LEFT JOIN employees
ON  employee_id = salesman_id
WHERE  extract(YEAR FROM order_date) = 2017
ORDER BY  order_date DESC;
--crate table
CREATE  TABLE compensations (
    employee_id    NUMBER,
    effective_date DATE,
    salary         NUMBER NOT NULL,
    commission      NUMBER,
    PRIMARY KEY (employee_id, effective_date),
    FOREIGN KEY (employee_id) REFERENCES employees(employee_id)
);
INSERT INTO compensations (employee_id, effective_date, salary, commission)
VALUES(1,DATE '2017-01-01',100000, NULL);

INSERT INTO compensations (employee_id, effective_date, salary, commission)
VALUES(51,DATE '2017-01-01',100000, 20000);

INSERT INTO compensations (employee_id, effective_date, salary, commission)
VALUES(52,DATE '2017-01-01',100000, 10000);

INSERT INTO compensations (employee_id, effective_date, salary, commission)
VALUES(81,DATE '2017-01-01',700000, NULL);

INSERT INTO compensations (employee_id, effective_date, salary, commission)
VALUES(82,DATE '2017-01-01',700000, NULL);
--
SELECT  employee_id,
  NVL2(commission, salary + commission, salary)
FROM  compensations
WHERE  effective_date >= 2017-01-01 ;;
---