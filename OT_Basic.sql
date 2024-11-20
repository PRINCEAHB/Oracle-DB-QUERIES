---create OT user
CREATE USER OT IDENTIFIED BY Orcl1234;
-----Grant previillages
GRANT CONNECT, RESOURCE, DBA TO OT;
----To create tables in the sample database, you need to execute the statements in the ot_schema.sql file from SQL*plus.
@C:\OTDB\ot_schema.sql;

---Once the statement completes, you can verify whether the tables were created successfully or not by listing the tables owned by the OT user. The following is the statement to do so.
SELECT table_name FROM user_tables ORDER BY table_name;

---load data into the tables

@C:\OTDB\ot_data.sql;
---You can also verify whether data has been loaded successfully by using the SELECT statement
 SELECT COUNT(*) FROM contacts;


----select query
SELECT *  FROM   customers;
  
SELECT  customer_id, name, credit_limit
FROM   customers;

SELECT  customer_id, name, address, website, credit_limit
FROM customers;

----oracle dual table
SELECT   UPPER('Abdul hafeez') FROM   dual;
  
SELECT   (10 + 5)/2 FROM   dual;

----Oracle ORDER BY clause
SELECT name,address, credit_limit FROM customers
ORDER BY  name ASC;

SELECT  name, address,credit_limit
FROM   customers
ORDER BY  name DESC;

SELECT first_name,last_name
FROM  contacts ORDER BY  first_name, last_name DESC;

SELECT name, credit_limit
FROM  customers ORDER BY 2 DESC,1;

SELECT  country_id, city, state
FROM locations ORDER BY   city, state;

SELECT  country_id, city,state
FROM   locations ORDER BY  state ASC NULLS FIRST;

SELECT  country_id,city,state 
FROM   locations ORDER BY state ASC NULLS LAST;
 
SELECT customer_id, name
FROM  customers ORDER BY  upper( name ); 

SELECT  order_id, customer_id,status, order_date
FROM   orders ORDER BY  order_date DESC;  

---Oracle SELECT DISTINCT statement

SELECT first_name FROM  contacts
ORDER BY   first_name;
 
SELECT DISTINCT  first_name FROM   contacts
ORDER BY   first_name;

SELECT DISTINCT product_id, quantity FROM   ORDER_ITEMS
ORDER BY     product_id;

SELECT  DISTINCT state FROM  locations
ORDER BY  state NULLS FIRST;

SELECT  TRANSACTION_ID,REGISTRATION_NO,NAME,CELL_NO,EMAIL,NTN,ST_REGISTERED_ON 
FROM REGISTRATION; WHERE ST_REGISTERED_ON IS NULL ;AND EMAIL ='abc@gmail.com'; ---;--AND CELL_NO IS  NULL;--

UPDATE REGISTRATION SET ST_REGISTERED_ON =sysdate---CELL_NO ='00923150593052', EMAIL= 'hafeez_butt@pral.com.pk'
WHERE TRANSACTION_ID IS NULL; AND EMAIL ='abc@gmail.com';

---Oracle WHERE clause
SELECT  product_name, description,list_price, category_id
FROM  products WHERE  product_name = 'Kingston';

SELECT product_name,list_price FROM products
WHERE list_price > 500;

SELECT product_name,list_price FROM products
WHERE list_price BETWEEN 650 AND 680
ORDER BY list_price;

-----Oracle Alias
SELECT first_name AS forename,last_name  AS surname
FROM   employees;

SELECT first_name "Forename",last_name "Surname"
FROM  employees; 

SELECT first_name "First Name",last_name "Family Name"
FROM employees;

SELECT   first_name  || ' '  || last_name AS NAME
FROM  employees;

SELECT  first_name  || ' '  || last_name AS "Full Name"
FROM   employees; 

SELECT  product_name,   list_price - standard_cost AS gross_profit
FROM   products ORDER BY   gross_profit DESC;

SELECT e.first_name employee, m.first_name manager
FROM  employees e INNER JOIN employees m
ON m.employee_id = e.employee_id;

----- LINK   https://www.oracletutorial.com/oracle-basics/oracle-alias/
----Oracle FETCH clause
/*Some RDBMS such as MySQL and PostgreSQL have the LIMIT clause that allows you to retrieve a portion of rows
*/

SELECT product_name,quantity
FROM  inventories
INNER JOIN products USING(product_id)
ORDER BY  quantity DESC 
FETCH NEXT 5 ROWS ONLY;

SELECT product_name,quantity
FROM inventories
INNER JOIN products  USING(product_id)
ORDER BY quantity DESC 
FETCH NEXT 10 ROWS ONLY;
----The following query uses the row limiting clause with 

SELECT product_name,quantity
FROM inventories
INNER JOIN products USING(product_id)
ORDER BY quantity DESC 
FETCH NEXT 10 ROWS WITH TIES;
---Limit by percentage of rows example 

SELECT product_name, quantity
FROM inventories
INNER JOIN products  USING(product_id)
ORDER BY quantity DESC 
FETCH FIRST 5 PERCENT ROWS ONLY;

----OFFSET example
SELECT product_name, quantity
FROM  inventories
INNER JOIN products    USING(product_id)
ORDER BY      quantity DESC 
OFFSET 10 ROWS 
FETCH NEXT 10 ROWS ONLY;
----Oracle AND Operator

SELECT order_id, customer_id,status, order_date
FROM     orders WHERE    status = 'Pending'
AND customer_id = 2 ORDER BY  order_date;

SELECT  order_id, customer_id, status, order_date FROM  orders
WHERE  status = 'Shipped'     AND salesman_id = 60
AND EXTRACT(YEAR FROM order_date) = 2017
ORDER BY  order_date;

----Oracle AND to combine with OR operator example
SELECT     order_id,  customer_id, status, salesman_id, order_date FROM     orders
WHERE     (   status = 'Canceled'   OR status = 'Pending'   )    AND customer_id = 44 ORDER BY     order_date;
    
----Oracle OR Operator
SELECT  order_id, customer_id, status, order_date FROM     orders
WHERE     status = 'Pending'     OR status = 'Canceled'--- OR STATUS ='Shipped'
ORDER BY     order_date DESC;

---Oracle IN
SELECT order_id, customer_id, status,  salesman_id
FROM    orders WHERE    salesman_id IN (  54,  55, 56 )
ORDER BY  order_id;

SELECT    order_id,    customer_id,    status,    salesman_id
FROM    orders WHERE    status IN( 'Pending', 'Canceled'  )
ORDER BY    order_id;

SELECT  employee_id, first_name, last_name FROM employees
WHERE   employee_id IN( SELECT   DISTINCT salesman_id
        FROM    orders
        WHERE   status = 'Canceled' ) ORDER BY   first_Name;
        
----Oracle BETWEEN
SELECT  product_name, standard_cost
FROM  products
WHERE  standard_cost BETWEEN 500 AND 600
ORDER BY standard_cost;
---ORACLE NOT BETWEEN
SELECT  product_name, standard_cost
FROM    products
WHERE   standard_cost NOT BETWEEN 500 AND 600
ORDER BY  product_name;
    
 ----Oracle LIKE  
 ---% wildcard character examples
SELECT first_name,last_name, phone
FROM  contacts
WHERE last_name LIKE 'St%'
ORDER BY  last_name;

SELECT first_name, last_name,email
FROM     contacts
WHERE     UPPER( first_name ) LIKE 'CH%'
ORDER BY     first_name;         

SELECT  first_name, last_name, email,  phone
FROM     contacts
WHERE     first_name LIKE 'Je_i'
ORDER BY     first_name;

CREATE TABLE discounts
  ( product_id NUMBER, 
    discount_message VARCHAR2( 255 ) NOT NULL,
    PRIMARY KEY( product_id )  );


INSERT INTO discounts(product_id, discount_message)
VALUES(1,
       'Buy 1 and Get 25% OFF on 2nd ');

INSERT INTO discounts(product_id, discount_message)
VALUES(2,
       'Buy 2 and Get 50% OFF on 3rd ');


INSERT INTO discounts(product_id, discount_message)
VALUES(3,
       'Buy 3 Get 1 free'); 
          
SELECT     product_id,    discount_message
FROM     discounts
WHERE     discount_message LIKE '%25!%%' ESCAPE '!';

-----Oracle IS NULL
SELECT * FROM orders 
WHERE salesman_id IS NULL
ORDER BY order_date DESC;

SELECT * FROM orders
WHERE salesman_id IS NOT NULL
ORDER BY order_date DESC;

-----Oracle Joins
--Setting up sample tables
--We will create two new tables with the same structure for the demonstration:    
CREATE TABLE palette_a (
    id INT PRIMARY KEY,
    color VARCHAR2 (100) NOT NULL);

CREATE TABLE palette_b (
    id INT PRIMARY KEY,
    color VARCHAR2 (100) NOT NULL
);

INSERT INTO palette_a (id, color)
VALUES (1, 'Red');

INSERT INTO palette_a (id, color)
VALUES (2, 'Green');

INSERT INTO palette_a (id, color)
VALUES (3, 'Blue');

INSERT INTO palette_a (id, color)
VALUES (4, 'Purple');

-- insert data for the palette_b
INSERT INTO palette_b (id, color)
VALUES (1, 'Green');

INSERT INTO palette_b (id, color)
VALUES (2, 'Red');

INSERT INTO palette_b (id, color)
VALUES (3, 'Cyan');

INSERT INTO palette_b (id, color)
VALUES (4, 'Brown');

-----Oracle inner join
SELECT  a.id id_a, a.color color_a, b.id id_b, b.color color_b
FROM   palette_a a INNER JOIN palette_b b ON a.color = b.color;

-----Oracle left join
SELECT  a.id id_a, a.color color_a, b.id id_b, b.color color_b
FROM  palette_a a
LEFT JOIN palette_b b ON a.color = b.color;

SELECT a.id id_a,a.color color_a, b.id id_b, b.color color_b
FROM  palette_a a
LEFT JOIN palette_b b ON a.color = b.color
WHERE b.id IS NULL;

----Oracle right join
SELECT a.id id_a,a.color color_a, b.id id_b, b.color color_b
FROM  palette_a a
RIGHT JOIN palette_b b ON a.color = b.color;

----Oracle full outer join
SELECT a.id id_a, a.color color_a, b.id id_b, b.color color_b
FROM  palette_a a
FULL OUTER JOIN palette_b b ON a.color = b.color;

SELECT a.id id_a, a.color color_a, b.id id_b, b.color color_b
FROM  palette_a a
FULL JOIN palette_b b ON a.color = b.color
WHERE a.id IS NULL OR b.id IS NULL;

----Oracle INNER JOIN
SELECT  * FROM  orders
INNER JOIN order_items ON  order_items.order_id = orders.order_id
ORDER BY  order_date DESC;
    
SELECT * FROM orders 
INNER JOIN order_items USING( order_id )
ORDER BY order_date DESC;

SELECT name AS customer_name,  order_id,  order_date,  item_id,  quantity,  unit_price
FROM orders
INNER JOIN order_items USING(order_id)
INNER JOIN customers USING(customer_id)
ORDER BY order_date DESC,
order_id DESC,item_id ASC;    

---The following example illustrates how to join four tables: orders,  order_items, customers, and products
SELECT name AS customer_name,  order_id, order_date, item_id, product_name, quantity, unit_price
FROM  orders
INNER JOIN order_items      USING(order_id)
INNER JOIN customers        USING(customer_id)
INNER JOIN products         USING(product_id)
ORDER BY order_date DESC,  order_id DESC,  item_id ASC;

---Oracle LEFT JOIN
SELECT order_id,status,first_name,last_name
FROM   orders LEFT JOIN employees ON employee_id = salesman_id
ORDER BY   order_date DESC;
--The following statement uses LEFT JOIN clauses to join three tables: orders, employees and customers:
SELECT order_id, name AS customer_name, status, first_name, last_name
FROM  orders LEFT JOIN employees ON employee_id = salesman_id
LEFT JOIN customers ON  customers.customer_id = orders.customer_id
ORDER BY     order_date DESC;

--- create two tables
CREATE TABLE projects(
    project_id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    project_name VARCHAR2(100) NOT NULL );

CREATE TABLE members(
    member_id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    member_name VARCHAR2(100) NOT NULL,
    project_id INT,
    FOREIGN KEY (project_id) REFERENCES projects(project_id) );
---insert records
INSERT INTO projects(project_name) 
VALUES('ERP');

INSERT INTO projects(project_name) 
VALUES('Sales CRM');

INSERT INTO members(member_name, project_id)
VALUES('John Doe',1);

INSERT INTO members(member_name, project_id)
VALUES ('Jane Doe',1);

INSERT INTO members(member_name, project_id)
VALUES ('Jack Daniel',null);
    
 SELECT member_name, project_name
FROM   members m
FULL OUTER JOIN projects p ON p.project_id = m.project_id
ORDER BY   member_name;   
 
 SELECT   member_name, project_name
FROM  members m FULL OUTER JOIN projects p 
        ON p.project_id = m.project_id
WHERE  project_name IS NULL
ORDER BY  member_name;  
  
----Oracle CROSS JOIN
SELECT product_id, warehouse_id,
ROUND( dbms_random.value( 10, 100 )) quantity
FROM     products 
CROSS JOIN warehouses;

---Oracle Self Join
SELECT (e.first_name || '  ' || e.last_name) employee,  (m.first_name || '  ' || m.last_name) manager,
    e.job_title  FROM  employees e
LEFT JOIN employees m ON  m.employee_id = e.manager_id
ORDER BY  manager;

SELECT   e1.hire_date,  (e1.first_name || ' ' || e1.last_name) employee1,  (e2.first_name || ' ' || e2.last_name) employee2  
FROM  employees e1
INNER JOIN employees e2 ON
    e1.employee_id > e2.employee_id
    AND e1.hire_date = e2.hire_date
ORDER BY e1.hire_date DESC, employee1, employee2;
---Oracle GROUP BY
---https://www.oracletutorial.com/oracle-basics/oracle-group-by/
SELECT     status
FROM     orders GROUP BY     status;

SELECT  DISTINCT status FROM   orders;

SELECT  customer_id,  COUNT( order_id ) FROM  orders
GROUP BY     customer_id
ORDER BY     customer_id;

SELECT     name,    COUNT( order_id )
FROM     orders
INNER JOIN customers  USING(customer_id)
GROUP BY     name
ORDER BY     name;
----C) Oracle GROUP BY with an expression example
SELECT  EXTRACT(YEAR FROM order_date) YEAR, COUNT( order_id )
FROM     orders
GROUP BY     EXTRACT(YEAR FROM order_date)
ORDER BY     YEAR;
----D) Oracle GROUP BY with WHERE clause example
SELECT   name, COUNT( order_id ) 
FROM orders INNER JOIN customers USING(customer_id) 
WHERE  status = 'Shipped'
GROUP BY    name 
ORDER BY    name;
----E) Oracle GROUP BY with ROLLUP example
SELECT customer_id, status, SUM( quantity * unit_price ) sales
FROM  orders INNER JOIN order_items USING(order_id)
GROUP BY  ROLLUP(  customer_id, status  );
-------Oracle HAVING
---A) Simple Oracle HAVING example
SELECT  order_id,SUM( unit_price * quantity ) order_value
FROM   order_items
GROUP BY order_id ORDER BY  order_value DESC;

SELECT    order_id,    SUM( unit_price * quantity ) order_value
FROM    order_items
GROUP BY    order_id
HAVING    SUM( unit_price * quantity ) > 1000000
ORDER BY    order_value DESC;
---B) Oracle HAVING with complex conditions example
SELECT    order_id,    COUNT( item_id ) item_count,    SUM( unit_price * quantity ) total
FROM    order_items
GROUP BY    order_id
HAVING    SUM( unit_price * quantity ) > 500000 AND COUNT( item_id ) BETWEEN 10 AND 15
ORDER BY    total DESC,    item_count DESC;

-----Oracle UNION
---A) Oracle UNION example
SELECT  first_name, last_name,  email, 'contact'
FROM    contacts
UNION   SELECT   first_name,  last_name, email,  'employee'
FROM     employees;
-----B) Oracle UNION and ORDER BY example
SELECT     first_name || ' ' || last_name name,    email,    'contact'
FROM     contacts
UNION SELECT     first_name || ' ' || last_name name,    email,    'employee'
FROM     employees ORDER BY    name DESC;
---C) Oracle UNION ALL example
SELECT     last_name FROM     employees
UNION SELECT     last_name FROM     contacts
ORDER BY     last_name;
-----union all
SELECT     last_name
FROM     employees
UNION ALL SELECT     last_name
FROM     contacts
ORDER BY     last_name;

-----Oracle INTERSECT
SELECT     last_name
FROM     contacts
INTERSECT SELECT    last_name
FROM    employees ORDER BY    last_name;
----Oracle MINUS
SELECT     last_name
FROM    contacts
MINUS SELECT     last_name
FROM    employees
ORDER BY     last_name;

SELECT  product_id FROM  products
MINUS SELECT   product_id  FROM   inventories;
-------Oracle Subquery
SELECT     product_id,    product_name,    list_price
FROM     products
WHERE     list_price = ( SELECT  MAX( list_price )
FROM     products   );

SELECT     product_name,    list_price,
    ROUND( ( SELECT  AVG( list_price )
            FROM     products p1
            WHERE     p1. category_id = p2.category_id   ),
        2  ) avg_list_price
FROM  products p2 ORDER BY   product_name;

----B) Oracle subquery in the FROM clause example
SELECT  order_id,order_value
FROM  (SELECT  order_id,  SUM( quantity * unit_price ) order_value
        FROM   order_items
        GROUP BY  order_id
        ORDER BY  order_value DESC
)FETCH FIRST 10 ROWS ONLY; 
-----C) Oracle subquery with comparison operators example
SELECT    product_id,    product_name,    list_price
FROM    products
WHERE    list_price > (
        SELECT            AVG( list_price )
        FROM            products
    )  ORDER BY    product_name;
------D) Oracle subquery with IN and NOT IN operators
SELECT  employee_id,  first_name,  last_name
FROM    employees
WHERE    employee_id IN(    SELECT    salesman_id
        FROM  orders
        INNER JOIN order_items      USING(order_id)
        WHERE    status = 'Shipped'
        GROUP BY   salesman_id,    EXTRACT(   YEAR  FROM order_date  )
        HAVING SUM( quantity * unit_price )  >= 1000000  
               AND EXTRACT( YEAR FROM  order_date) = 2017
               AND salesman_id IS NOT NULL
    )ORDER BY   first_name,  last_name;

SELECT   name FROM    customers
WHERE    customer_id NOT IN(
        SELECT    customer_id
        FROM      orders
        WHERE    EXTRACT( YEAR  FROM   order_date) = 2017
 )ORDER BY    name; 
----Oracle Correlated Subquery
--link ;;   https://www.oracletutorial.com/oracle-basics/oracle-correlated-subquery/

SELECT   product_id,  product_name, list_price
FROM     products WHERE     list_price =(
        SELECT    MIN( list_price )
        FROM      products    );
SELECT    product_id,   product_name,    list_price
FROM      products p
WHERE     list_price > ( SELECT  AVG( list_price )
        FROM     products
        WHERE    category_id = p.category_id    );

--------------Oracle EXISTS
--The Oracle EXISTS operator is a Boolean operator that returns either true or false. The EXISTS operator is often used with a subquery to test for the existence of rows:
----The following example uses the EXISTS operator to find all customers who have the order.

SELECT     name
FROM    customers c
WHERE    EXISTS (
        SELECT  1   FROM   orders
        WHERE    customer_id = c.customer_id   )
ORDER BY     name;

---The following statement updates the names of the warehouses located in the US:
UPDATE     warehouses w
SET     warehouse_name = warehouse_name || ', USA'
WHERE    EXISTS (    SELECT    1   FROM    locations
        WHERE   country_id = 'US'
            AND location_id = w.location_id   );
---The following query verifies the update:
SELECT	warehouse_name
FROM	warehouses
INNER JOIN locations
		USING(location_id)
WHERE	country_id = 'US';

---Oracle EXISTS with INSERT statement example
---Suppose, we have to send special appreciation emails to all customers who had orders in 2016. To do this, first, we create a new table to store the data of customers:
CREATE TABLE customers_2016(
    company_id NUMBER GENERATED BY DEFAULT AS IDENTITY,
    company varchar2(255) NOT NULL,
    first_name varchar2(255) NOT NULL,
    last_name varchar2(255) NOT NULL,
    email varchar2(255) NOT NULL,
    sent_email CHAR(1) DEFAULT 'N',
    PRIMARY KEY(company_id));

---Then, we insert customers who had orders in 2016 into the customers_2016 table:
INSERT   INTO  customers_2016(   company,  first_name,  last_name,   email
        ) SELECT   name company,  first_name,   last_name,  email
        FROM   customers c
        INNER JOIN contacts ON
            contacts.customer_id = c.customer_id
        WHERE  EXISTS(  SELECT   *    FROM  orders
                WHERE   customer_id = c.customer_id);
                    AND EXTRACT(  YEAR   FROM   order_date               
            )         ORDER BY          company;

SELECT
    *
FROM
    customers
WHERE
    customer_id IN(NULL);

SELECT  * FROM    customers
WHERE  EXISTS (   SELECT    NULL   FROM    dual   );
----Oracle NOT EXISTS
--The NOT EXISTS operator works the opposite of the EXISTS operator. We often use the NOT EXISTS operator with a subquery to subtract one set of data from another.
---The NOT EXISTS operator returns true if the subquery returns no row. Otherwise, it returns false.
--Note that the NOT EXISTS operator returns false if the subquery returns any rows with a NULL value.
--The following statement finds all customers who have no order:
SELECT  name FROM  customers
WHERE  NOT EXISTS (    SELECT   NULL
        FROM   orders
        WHERE  orders.customer_id = customers.customer_id
    )ORDER BY    name;

CREATE TABLE customers_archive AS
SELECT * FROM
    customers WHERE   NOT EXISTS (
        SELECT   NULL
        FROM     orders
        WHERE    orders.customer_id = customers.customer_id  );
----To update the credit limit of customers who have no order in 2017, you use the following UPDATE statement:
UPDATE  customers
SET  credit_limit = 0
WHERE   NOT EXISTS(
        SELECT    NULL    FROM    orders
        WHERE  orders.customer_id = customers.customer_id);
            AND EXTRACT(  YEAR   FROM   order_date   
    );

---And to delete all customers who had no orders in 2016 and 2017 from the customers table, you use the following DELETE statement:
DELETE FROM  customers
WHERE    NOT EXISTS(    SELECT    NULL
        FROM    orders
        WHERE   orders.customer_id = customers.customer_id
        AND EXTRACT( YEAR FROM order_date ) IN(  2016,  2017   )    );

----Oracle ANY
---The Oracle ANY operator is used to compare a value to a list of values or result set returned by a subquery.
---When you use the ANY operator to compare a value to a list, Oracle expands the initial condition to all elements of the list and uses the OR operator to combine them.
SELECT  product_name, list_price FROM   products
WHERE  list_price > ANY(    SELECT   list_price
        FROM    products
        WHERE    category_id = 1  )
ORDER BY   product_name;

SELECT  product_name, list_price FROM    products p1
WHERE  EXISTS(  SELECT  list_price  FROM   products p2
        WHERE   category_id = 1
        AND p1.list_price > p2.list_price   )
ORDER BY   product_name;
/*
If the subquery returns rows or a list has value, the following statements apply to the ANY operator:

1) col = ANY ( list )
The expression evaluates to true if the col matches one or more values in the list, for example:
*/
SELECT  product_name, list_price FROM    products
WHERE  list_price = ANY(    2200,   2259.99,   2269.99  )
    AND category_id = 1;

/*
2) col != ANY(list)
The expression evaluates to true if the col does not match one or more values in the list.
*/
SELECT  product_name,  list_price FROM   products
WHERE  list_price != ANY(    2200,   2259.99,   2269.99  )
    AND category_id = 1
ORDER BY    list_price DESC;

/*
3) col > ANY (list)
The expression evaluates to true if the col is greater than the smallest value in the list.
*/

SELECT  product_name,  list_price  FROM   products
WHERE  list_price > ANY(   2200,    2259.99,   2269.99   )
AND category_id = 1  ORDER BY   list_price DESC;
/*
4) col >= ANY (list)
The expression evaluates to true if the col is greater than or equal to the smallest value in the list.
*/
SELECT  product_name, list_price  FROM   products
WHERE    list_price >= ANY(    2200,   2259.99,   2269.99  )
AND category_id = 1
ORDER BY    list_price DESC; 
/*
5) col < ANY (list)
The expression evaluates to true if the col is smaller than the highest value in the list.
*/
SELECT  product_name, list_price  FROM   products
WHERE  list_price < ANY(    2200,    2259.99,   2269.99  )
AND category_id = 1
ORDER BY list_price DESC;
/*
6) col <= ANY (list)
The expression evaluates to true if the col is smaller than or equal to the highest value in the list.
*/
SELECT   product_name, list_price  FROM  products
WHERE   list_price <= ANY(     2200,   2259.99,    2269.99    )
AND category_id = 1
ORDER BY   list_price DESC;
-----Oracle ALL
--link: https://www.oracletutorial.com/oracle-basics/oracle-all/
---The Oracle ALL operator is used to compare a value to a list of values or result set returned by a subquery.
---If you use the ALL operator to compare a value with a result set returned by a subquery, Oracle performs a two-step transformation as shown below:
SELECT product_name,  list_price
FROM products
WHERE list_price > ALL ( SELECT list_price
     FROM products   WHERE category_id = 1 )
ORDER BY product_name;

-- 1st step: transformation that uses ANY

SELECT product_name,   list_price
FROM products p1 WHERE NOT( p1.list_price <= ANY
            (SELECT list_price    FROM products p2
             WHERE category_id = 1 ))
ORDER BY product_name; 


-- 2nd step: transformation that eliminates ANY
SELECT product_name,   list_price
FROM products p1
WHERE NOT EXISTS (SELECT p2.list_price
     FROM products p2
     WHERE p2.category_id = 1
     AND p2.list_price >= p1.list_price )
ORDER BY product_name;
/*
1) col > ALL (list)
The expression evaluates to true if the col is greater than the biggest value in the list.

For example, the following query finds all products whose list prices are greater than the highest price of the average price list:
*/
SELECT product_name, list_price
FROM  products
WHERE  list_price > ALL(
        SELECT  AVG( list_price )
        FROM   products
        GROUP BY  category_id
    )ORDER BY  list_price ASC;
/*
2) col < ALL(list)
The expression evaluates to true if the col is smaller than the smallest value in the list.

For example, the following query finds all products whose list prices are less than the lowest price in the average price list:
*/
SELECT  product_name,  list_price
FROM   products
WHERE  list_price < ALL(
        SELECT  AVG( list_price )
        FROM  products
        GROUP BY  category_id
    )ORDER BY  list_price DESC;
/*
3) col >= ALL(list)
The expression evaluates to true if the col is greater than or equal to the biggest value in the list.
The following statement returns CPU products whose list price is greater than or equal to 2200:
*/
SELECT  product_name, list_price
FROM  products
WHERE list_price >= ALL(    1000,   1500,    2200   )
    AND category_id = 1
ORDER BY  list_price DESC;
/*
3) col <= ALL(list)
The expression evaluates to true if the col is less than or equal to the smallest value in the list.

The following statement returns the CPU products whose list price is less than or equal to 977.99, which is the smallest value in the list.
*/
SELECT product_name,  list_price
FROM  products
WHERE list_price <= ALL(    977.99,   1000,    2200   )
    AND category_id = 1
ORDER BY  list_price DESC;
/*
5) col = ALL ( list)
The expression evaluates to true if the col matches all values in the list.

6) col != ALL (list)
The expression evaluates to true if the col does not match any values in the list.

In this tutorial, you have learned how to use the Oracle ALL operator to compare a value with a list or subquery.
*/
---Oracle GROUPING SETS
---Summary: in this tutorial, you will learn about grouping set concept and how to use the Oracle GROUPING SETS expression to generate multiple grouping sets in a query.
/*Let’s create a view that returns sales amounts by product category and customer. For the demonstration purpose, we will pick only two customers whose identities are 1 and 2.

Here is the statement for creating the view:
*/
CREATE VIEW customer_category_sales AS
SELECT category_name category,  customers.name customer,  SUM(quantity*unit_price) sales_amount
FROM  orders
    INNER JOIN customers USING(customer_id)
    INNER JOIN order_items USING (order_id)
    INNER JOIN products USING (product_id)
    INNER JOIN product_categories USING (category_id)
WHERE  customer_id IN (1,2)
GROUP BY  category_name,  customers.name;

SELECT  customer,  category,  sales_amount 
FROM    customer_category_sales
ORDER BY customer, category;
---For example, this query returns a grouping set that includes the category column, (category) grouping set:
SELECT   category,  SUM(sales_amount) 
FROM   customer_category_sales
GROUP BY  category;
SELECT   customer,  SUM(sales_amount)
FROM   customer_category_sales
GROUP BY  customer;    

---And this query returns a grouping set that includes both columns customer and category, or (customer, category) grouping set:
SELECT customer,  category,  sales_amount 
FROM  customer_category_sales
ORDER BY  customer,  category;
/*
If you want to return four grouping sets in one query, you need to use the UNION ALL operator.

However, the UNION ALL operator requires all involved queries to return the same number of columns.
 Therefore, to make it work, you need to add NULL to the select list of each query as shown in the following query:
*/
SELECT  category,   NULL, SUM(sales_amount) 
FROM   customer_category_sales
GROUP BY   category
UNION ALL    
SELECT customer, NULL,  SUM(sales_amount)
FROM   customer_category_sales
GROUP BY     customer
UNION ALL
SELECT   customer,   category,  sum(sales_amount)
FROM   customer_category_sales
GROUP BY   customer,  category
UNION ALL   
SELECT  NULL, NULL, SUM(sales_amount)
FROM  customer_category_sales;
---Back to our query example that uses the UNION ALL operators above, you can use the GROUPING SETS instead:
SELECT  customer,  category,  SUM(sales_amount)
FROM  customer_category_sales
GROUP BY GROUPING SETS( (customer,category), (customer), (category),()
    )
ORDER BY  customer,  category;     
---Oracle GROUPING() function
/*
The GROUPING() function differentiates the super-aggregate rows from regular grouped rows. 
The following illustrates the basic syntax of the GROUPING() function:

GROUPING(expression)
Code language: SQL (Structured Query Language) (sql)
The expression must match with the expression in the GROUP BY clause.

The GROUPING() function returns a value of 1 when the value of expression in the row is NULL representing the set of all values. Otherwise, it returns 0.

This query uses the GROUPING() function to distinguish super-aggregate rows from the regular grouped rows:
*/
SELECT  customer,  category,
    GROUPING(customer) customer_grouping,
    GROUPING(category) category_grouping,
    SUM(sales_amount) 
FROM customer_category_sales
GROUP BY  GROUPING SETS(  (customer,category),  (customer),  (category), ()
    ) ORDER BY  customer,  category;
---To make the output more readable, you can combine the DECODE() function with the GROUPING() function as shown in the following query:
SELECT 
    DECODE(GROUPING(customer),1,'ALL customers', customer) customer,
    DECODE(GROUPING(category),1,'ALL categories', category) category,
    SUM(sales_amount) 
FROM  customer_category_sales
GROUP BY GROUPING SETS(
        (customer,category),
        (customer),(CATEGORY),()
    )ORDER BY  customer, category;
---Oracle GROUPING_ID() function
/*
The GROUPING_ID() function takes the “group by” columns and returns a number denoting the GROUP BY level. In other words, 
it provides another compact way to identify the subtotal rows.

This statement uses the GROUPING_ID() function to return the GROUP BY level:
*/
SELECT  customer, category,
    GROUPING_ID(customer,category) grouping, SUM(sales_amount) 
FROM customer_category_sales
GROUP BY GROUPING SETS(
        (customer,category),
        (customer),
        (category),
        ()  )
ORDER BY  customer,  category;
---Oracle CUBE
---The CUBE is an extension of the GROUP BY clause that allows you to generate grouping sets for all possible combinations of dimensions.
---This example uses the CUBE to generate subtotals for product category and customer and grand total for these customers (customer id 1 and 2) and all product categories:
SELECT  category, customer, SUM(sales_amount) 
FROM   customer_category_sales
GROUP BY  CUBE(category,customer)
ORDER BY category NULLS LAST,  customer NULLS LAST;

---For example, the following query uses a partial cube that generates subtotals for the product category dimension only:
SELECT  category,  customer,  SUM(sales_amount) 
FROM   customer_category_sales
GROUP BY  category, CUBE(customer)
ORDER BY  category,   customer NULLS LAST; 

---Oracle ROLLUP
---Oracle provides a better and faster way to calculate the grand total by using the ROLLUP
SELECT customer_id, SUM(quantity * unit_price) amount
FROM  orders
INNER JOIN order_items USING (order_id)
WHERE  status      = 'Shipped' AND  salesman_id IS NOT NULL AND 
   EXTRACT(YEAR FROM order_date) = 2017
GROUP BY   ROLLUP(customer_id);
/*
The ROLLUP works as follows:

First, calculate the standard aggregate values in the GROUP BY clause.
Then, progressively create higher-level subtotals of the grouping columns, which are col2 and col1 columns, from right to left.
Finally, calculate the grand total.
The ROLLUP clause generates the number of grouping sets which is the same as the number of grouping columns specified in the ROLLUP plus a grand total.
 In other words, if you have n columns listed in the ROLLUP, you will get n+ 1 level of subtotals with ROLLUP.
In the syntax above, the ROLLUP clause generates the following grouping sets
(col1, col2)
(col2)
(grand total)
The number of rows in the output is derived from the number of unique combinations of values in the grouping columns.
*/
---The following example use ROLLUP to return the sales values by salesman and customer:
SELECT  salesman_id,  customer_id, SUM(quantity * unit_price) amount
FROM orders
INNER JOIN order_items USING (order_id)
WHERE status      = 'Shipped' AND   salesman_id IS NOT NULL AND 
   EXTRACT(YEAR FROM order_date) = 2017
GROUP BY   ROLLUP(salesman_id,customer_id);

---The following query performs a partial rollup:
SELECT   salesman_id,   customer_id,   SUM(quantity * unit_price) amount
FROM   orders
INNER JOIN order_items USING (order_id)
WHERE    status      = 'Shipped' AND    salesman_id IS NOT NULL AND 
   EXTRACT(YEAR FROM order_date) = 2017
GROUP BY    salesman_id,
   ROLLUP(customer_id);
----Oracle PIVOT
---link: https://www.oracletutorial.com/oracle-basics/oracle-pivot/
/*
Introduction to Oracle PIVOT clause
Oracle 11g introduced the new PIVOT clause that allows you to write cross-tabulation queries which transpose rows into columns, 
aggregating data in the process of the transposing. As a result, the output of a pivot operation returns more columns and fewer rows than the starting data set.
*/
/*
pivot_clause specifies the column(s) that you want to aggregate. The pivot_clause performs an implicitly GROUP BY based on all columns that are not specified in the clause, along with values provided by the pivot_in_clause.
pivot_for_clause specifies the column that you want to group or pivot.
pivot_in_clause defines a filter for column(s) in the pivot_for_clause. The aggregation for each value in the pivot_in_clause will be rotated into a separate column.
*/
---Let’s create a new view named order_stats that includes product category, order status, and order id for demonstration.
CREATE VIEW order_stats AS
SELECT 
    category_name, 
    status, 
    order_id
FROM 
    order_items
INNER JOIN orders USING (order_id)
INNER JOIN products USING (product_id)
INNER JOIN product_categories USING (category_id);
-----https://www.oracletutorial.com/oracle-basics/oracle-pivot/
SELECT * FROM order_stats;
---This example uses the PIVOT clause to return the number of orders for each product category by order status:
SELECT * FROM order_stats
PIVOT( COUNT(order_id) 
    FOR category_name
    IN ( 'CPU',  'Video Card', 'Mother Board', 'Storage' )
)ORDER BY status;
--The following statement uses the query example above with the aliases:
SELECT * FROM order_stats
PIVOT( COUNT(order_id) order_count
    FOR category_name
    IN (    'CPU' CPU,    'Video Card' VideoCard,   'Mother Board' MotherBoard,
        'Storage' Storage   )
)ORDER BY status;
/*
Pivoting multiple columns
In the previous example, you have seen that we used one aggregate function in the pivot_clause. 
In the following example, we will use two aggregate functions.

First, alter the order_stats view to include the order value column
*/
CREATE OR REPLACE VIEW order_stats AS
SELECT 
    category_name, 
    status, 
    order_id, 
    SUM(quantity * list_price) AS order_value
FROM 
    order_items
INNER JOIN orders USING (order_id)
INNER JOIN products USING (product_id)
INNER JOIN product_categories USING (category_id)
GROUP BY 
    order_id, 
    status, 
    category_name;
SELECT * FROM order_stats;

--Third, use PIVOT clause to return the number of orders and order values by product category and order status
SELECT * FROM order_stats
PIVOT(    COUNT(order_id) orders,
    SUM(order_value) sales
    FOR category_name
    IN ( 'CPU' CPU,'Video Card' VideoCard, 'Mother Board' MotherBoard,
        'Storage' Storage   )
) ORDER BY status;

---Finally, use status as the pivot columns and category_name as rows:
SELECT * FROM order_stats
PIVOT( COUNT(order_id) orders,
    SUM(order_value) sales
    FOR status
    IN ( 'Canceled' Canceled,  'Pending' Pending, 'Shipped' Shipped  )
) ORDER BY category_name;   
---Oracle PIVOT with subquery
---You cannot use a subquery in the pivot_in_clause.:
---This restriction is relaxed with the XML option:
SELECT * FROM order_stats
PIVOT XML (COUNT(order_id) orders,
    SUM(order_value) sales
    FOR category_name
    IN (  SELECT category_name    FROM product_categories    )
) ORDER BY status;    
---Oracle UNPIVOT
/*
The Oracle UNPIVOT clause allows you to transpose columns to rows. 
The UNPIVOT clause is opposite to the PIVOT clause except that it does not de-aggregate data during the transposing process.
*/
--First, create a new table called sale_stats for demonstration:
CREATE TABLE sale_stats(
    id INT PRIMARY KEY,
    fiscal_year INT,
    product_a INT,
    product_b INT,
    product_c INT
);
--Second, insert some rows into the sale_stats table
INSERT INTO sale_stats(id, fiscal_year, product_a, product_b, product_c)
VALUES(1,2017, NULL, 200, 300);

INSERT INTO sale_stats(id, fiscal_year, product_a, product_b, product_c)
VALUES(2,2018, 150, NULL, 250);

INSERT INTO sale_stats(id, fiscal_year, product_a, product_b, product_c)
VALUES(3,2019, 150, 220, NULL);

SELECT * FROM sale_stats;
---This statement uses the UNPIVOT clause to rotate columns product_a, product_b, and product_c into rows:
SELECT * FROM sale_stats
UNPIVOT(  quantity  -- unpivot_clause
    FOR product_code --  unpivot_for_clause
    IN ( -- unpivot_in_clause
        product_a AS 'A', 
        product_b AS 'B', 
        product_c AS 'C'
    )
);
/*
By default, the UNPIVOT operation excludes null-valued rows, therefore, you don’t see any NULL in the output.

The following example uses the UNPIVOT clause to transpose values in the columns product_a, product_b, and product_c to rows, but including null-valued rows:

*/
SELECT * FROM sale_stats
UNPIVOT INCLUDE NULLS(
    quantity
    FOR product_code 
    IN (
        product_a AS 'A', 
        product_b AS 'B', 
        product_c AS 'C'
    )
);

/*Oracle unpivot multiple columns
Let’s see an example of unpivoting multiple columns.

First, drop and recreate the sale_stats table
*/
DROP TABLE sale_stats;
    
CREATE TABLE sale_stats(
    id INT PRIMARY KEY,
    fiscal_year INT,
    a_qty INT,
    a_value DEC(19,2),
    b_qty INT,
    b_value DEC(19,2)
);   
---Second, insert rows into the sale_stats table:
INSERT INTO sale_stats(id, fiscal_year, a_qty, a_value, b_qty, b_value)
VALUES(1, 2018, 100, 1000, 2000, 4000);

INSERT INTO sale_stats(id, fiscal_year, a_qty, a_value, b_qty, b_value)
VALUES(2, 2019, 150, 1500, 2500, 5000);

SELECT * FROM sale_stats;
---Finally, use the UNPIVOT clause to transpose the values in the column a_qty, a_value, b_qty, and b_value into rows:
SELECT * FROM sale_stats
UNPIVOT (
    (quantity, amount)
    FOR product_code
    IN (
        (a_qty, a_value) AS 'A', 
        (b_qty, b_value) AS 'B'        
    )
);

---Oracle INSERT

/*
Oracle INSERT statement examples
Let’s create a new table named discounts for inserting data
*/
CREATE TABLE discounts (
    discount_id NUMBER GENERATED BY DEFAULT AS IDENTITY,
    discount_name VARCHAR2(255) NOT NULL,
    amount NUMBER(3,1) NOT NULL,
    start_date DATE NOT NULL,
    expired_date DATE NOT NULL
);

--drop table discounts;
INSERT INTO discounts(discount_name, amount, start_date, expired_date)
VALUES('Summer Promotion', 9.5, DATE '2017-05-01', DATE '2017-08-31');

--The following statement retrieves data from the discounts table to verify the insertion:
SELECT     * FROM     discounts;
---The following example inserts a new row into the discounts table:
INSERT INTO discounts(discount_name, amount, start_date, expired_date)
VALUES('Winter Promotion 2017',  10.5, CURRENT_DATE, DATE '2017-12-31');

----Oracle INSERT INTO SELECT

/*Overview of Oracle INSERT INTO SELECT statement
Sometimes, you want to select data from a table and insert it into another table. 
To do it, you use the Oracle INSERT INTO SELECT statement as follows:
*/
/*The Oracle INSERT INTO SELECTstatement requires the data type of the source and target tables to match.

If you want to copy all rows from the source table to the target table, you remove the WHERE clause. Otherwise, you can specify which rows from the source table should be copied to the target table.
*/
/*
A) Insert all sales data example
Let’s create a table named sales for the demonstration.
*/
CREATE TABLE sales (
    customer_id NUMBER,
    product_id NUMBER,
    order_date DATE NOT NULL,
    total NUMBER(9,2) DEFAULT 0 NOT NULL,
    PRIMARY KEY(customer_id,
                product_id,
                order_date)
);

--The following statement inserts a sales summary from the orders and order_items tables into the sales table
INSERT INTO  sales(customer_id, product_id, order_date, total)
SELECT customer_id,
       product_id,
       order_date,
       SUM(quantity * unit_price) amount
FROM orders
INNER JOIN order_items USING(order_id)
WHERE status = 'Shipped'
GROUP BY customer_id,
         product_id,
         order_date;
         
SELECT * FROM sales
ORDER BY order_date DESC,     total DESC;

--B) Insert partial sales data example
--Suppose, you want to copy only sales summary data in 2017 to a new table. To do so, first, you create a new table named sales_2017 as follows:
CREATE TABLE sales_2017 
AS SELECT
    *
FROM
    sales
WHERE
    1 = 0;
/*The condition in the WHERE clause ensures that the data from the sales table is not copied to the sales_2017 table.

Second, use the Oracle INSERT INTO SELECT with a WHERE clause to copy 2017 sales data to the sales_2017 table:
*/
INSERT INTO  sales_2017
    SELECT customer_id,
           product_id,
           order_date,
           SUM(quantity * unit_price) amount
    FROM orders
    INNER JOIN order_items USING(order_id)
    WHERE status = 'Shipped' AND EXTRACT(year from order_date) = 2017        
    GROUP BY customer_id,
             product_id,
             order_date; 

---C) Insert partial data and literal value example
/*
Suppose, you want to send emails to all customers to announce new products. To do it, you can copy customer data to a separate table and track email sending status.

First, create a new table named customer_lists as follows:
*/
CREATE TABLE customer_lists(
    list_id NUMBER GENERATED BY DEFAULT AS IDENTITY,
    first_name varchar2(255) NOT NULL,
    last_name varchar2(255) NOT NULL,
    email varchar2(255) NOT NULL,
    sent NUMBER(1) NOT NULL,
    sent_date DATE,
    PRIMARY KEY(list_id)
);

---Second, copy data from the contacts table to the customer_lists table:
INSERT INTO
        customer_lists(
            first_name,
            last_name,
            email,
            sent
        ) SELECT
            first_name,
            last_name,
            email,
            0
        FROM
            contacts;
 ---Oracle UPDATE
 /*
 Introduction to the Oracle UPDATE statement
To changes existing values in a table, you use the following Oracle UPDATE statement
 */           

/*
Oracle UPDATE examples
Let’s create a new table with some sample data for the demonstration.

First, the following CREATE TABLE statement creates a new table named parts:
*/
CREATE TABLE parts (
  part_id NUMBER GENERATED BY DEFAULT AS IDENTITY,
  part_name VARCHAR(50) NOT NULL,
  lead_time NUMBER(2,0) NOT NULL,
  cost NUMBER(9,2) NOT NULL,
  status NUMBER(1,0) NOT NULL,
  PRIMARY KEY (part_id)
);

--Second, the following INSERT statements add sample data to the parts table
INSERT INTO parts (part_name,lead_time,cost,status) VALUES ('sed dictum',5,134,0);
INSERT INTO parts (part_name,lead_time,cost,status) VALUES ('tristique neque',3,62,1);
INSERT INTO parts (part_name,lead_time,cost,status) VALUES ('dolor quam,',16,82,1);
INSERT INTO parts (part_name,lead_time,cost,status) VALUES ('nec, diam.',41,10,1);
INSERT INTO parts (part_name,lead_time,cost,status) VALUES ('vitae erat',22,116,0);
INSERT INTO parts (part_name,lead_time,cost,status) VALUES ('parturient montes,',32,169,1);
INSERT INTO parts (part_name,lead_time,cost,status) VALUES ('metus. In',45,88,1);
INSERT INTO parts (part_name,lead_time,cost,status) VALUES ('at, velit.',31,182,0);
INSERT INTO parts (part_name,lead_time,cost,status) VALUES ('nonummy ultricies',7,146,0);
INSERT INTO parts (part_name,lead_time,cost,status) VALUES ('a, dui.',38,116,0);
INSERT INTO parts (part_name,lead_time,cost,status) VALUES ('arcu et',37,72,1);
INSERT INTO parts (part_name,lead_time,cost,status) VALUES ('sapien. Cras',40,197,1);
INSERT INTO parts (part_name,lead_time,cost,status) VALUES ('et malesuada',24,46,0);
INSERT INTO parts (part_name,lead_time,cost,status) VALUES ('mauris id',4,153,1);
INSERT INTO parts (part_name,lead_time,cost,status) VALUES ('eleifend egestas.',2,146,0);
INSERT INTO parts (part_name,lead_time,cost,status) VALUES ('cursus. Nunc',9,194,1);
INSERT INTO parts (part_name,lead_time,cost,status) VALUES ('vivamus sit',37,93,0);
INSERT INTO parts (part_name,lead_time,cost,status) VALUES ('ac orci.',35,134,0);
INSERT INTO parts (part_name,lead_time,cost,status) VALUES ('arcu. Aliquam',36,154,0);
INSERT INTO parts (part_name,lead_time,cost,status) VALUES ('at auctor',32,56,1);
INSERT INTO parts (part_name,lead_time,cost,status) VALUES ('purus, accumsan',33,12,1);

---Third, we have a parts table with some sample data for practice:
SELECT     * FROM     parts
ORDER BY     part_name;
/*
A) Oracle UPDATE – update one column of a single row
The following UPDATE statement changes the cost of the part with id 1:
*/
UPDATE     parts
SET     cost = 130
WHERE     part_id = 1;

/*
B) Oracle UPDATE – update multiple columns of a single row
The following statement updates the lead time, cost, and status of the part whose id is 5
*/
UPDATE   parts
SET lead_time = 30,
    cost = 120,
    status = 1
WHERE  part_id = 5;

---Oracle DELETE

/*
Oracle DELETE examples
Let’s create a new table named sales, which contains all sales order data, for the demonstration purpose:
*/
CREATE TABLE sales AS
SELECT
    order_id,
    item_id,
    product_id,
    quantity,
    unit_price,
    status,
    order_date,
    salesman_id
FROM
    orders
INNER JOIN order_items
        USING(order_id);
---drop table sales;
/* A) Oracle DELETE – delete one row from a table
The following statement deletes a row whose order id is 1 and item id is 1:
*/
DELETE FROM    sales
WHERE    order_id = 1   AND item_id = 1;
/* B) Oracle DELETE – delete multiple rows from a table
The following statement deletes all rows whose order id is 1:
*/
DELETE FROM     sales
WHERE     order_id = 1;

---Oracle MERGE

/*
Introduction to the Oracle MERGE statement
The Oracle MERGE statement selects data from one or more source tables and updates or inserts it into a target table. 
The MERGE statement allows you to specify a condition to determine whether to update data from or insert data into the target table.

The following illustrates the syntax of the Oracle MERGE statement:
*/
/* Oracle MERGE example
Suppose, we have two tables: members and member_staging.

We insert a new row to the members table whenever we have a new member. Then, 
the data from the members table is merged with the data of the member_staging table.
The following statements create the members and member_staging tables:
*/
CREATE TABLE members (
    member_id NUMBER PRIMARY KEY,
    first_name VARCHAR2(50) NOT NULL,
    last_name VARCHAR2(50) NOT NULL,
    rank VARCHAR2(20)
);
--drop table members; 
--ALTER TABLE members ADD rank VARCHAR2(20);
--drop table member_staging;
CREATE TABLE member_staging AS 
SELECT * FROM members;
/*
The following INSERT statements insert sample data into the members and member_staging tables:
*/
-- insert into members table    
INSERT INTO members(member_id, first_name, last_name, rank) VALUES(1,'Abel','Wolf','Gold');
INSERT INTO members(member_id, first_name, last_name, rank) VALUES(2,'Clarita','Franco','Platinum');
INSERT INTO members(member_id, first_name, last_name, rank) VALUES(3,'Darryl','Giles','Silver');
INSERT INTO members(member_id, first_name, last_name, rank) VALUES(4,'Dorthea','Suarez','Silver');
INSERT INTO members(member_id, first_name, last_name, rank) VALUES(5,'Katrina','Wheeler','Silver');
INSERT INTO members(member_id, first_name, last_name, rank) VALUES(6,'Lilian','Garza','Silver');
INSERT INTO members(member_id, first_name, last_name, rank) VALUES(7,'Ossie','Summers','Gold');
INSERT INTO members(member_id, first_name, last_name, rank) VALUES(8,'Paige','Mcfarland','Platinum');
INSERT INTO members(member_id, first_name, last_name, rank) VALUES(9,'Ronna','Britt','Platinum');
INSERT INTO members(member_id, first_name, last_name, rank) VALUES(10,'Tressie','Short','Bronze');

-- insert into member_staging table
INSERT INTO member_staging(member_id, first_name, last_name, rank) VALUES(1,'Abel','Wolf','Silver');
INSERT INTO member_staging(member_id, first_name, last_name, rank) VALUES(2,'Clarita','Franco','Platinum');
INSERT INTO member_staging(member_id, first_name, last_name, rank) VALUES(3,'Darryl','Giles','Bronze');
INSERT INTO member_staging(member_id, first_name, last_name, rank) VALUES(4,'Dorthea','Gate','Gold');
INSERT INTO member_staging(member_id, first_name, last_name, rank) VALUES(5,'Katrina','Wheeler','Silver');
INSERT INTO member_staging(member_id, first_name, last_name, rank) VALUES(6,'Lilian','Stark','Silver');

---The following is the MERGE statement that performs all of these actions in one shot.

MERGE INTO member_staging x
USING (SELECT member_id, first_name, last_name, rank FROM members) y
ON (x.member_id  = y.member_id)
WHEN MATCHED THEN
    UPDATE SET x.first_name = y.first_name, 
                        x.last_name = y.last_name, 
                        x.rank = y.rank
    WHERE x.first_name <> y.first_name OR 
           x.last_name <> y.last_name OR 
           x.rank <> y.rank 
WHEN NOT MATCHED THEN
    INSERT(x.member_id, x.first_name, x.last_name, x.rank)  
    VALUES(y.member_id, y.first_name, y.last_name, y.rank);
    
---The Ultimate Guide to Oracle INSERT ALL Statement
--The following example demonstrates how to insert multiple rows into a table.
--First, create a new table named fruits:
CREATE TABLE fruits (
    fruit_name VARCHAR2(100) PRIMARY KEY,
    color VARCHAR2(100) NOT NULL
);
---Second, use the Oracle INSERT ALL statement to insert rows into the fruits table:
INSERT ALL 
    INTO fruits(fruit_name, color)
    VALUES ('Apple','Red') 

    INTO fruits(fruit_name, color)
    VALUES ('Orange','Orange') 

    INTO fruits(fruit_name, color)
    VALUES ('Banana','Yellow')
SELECT 1 FROM dual;

SELECT     * FROM     fruits;

/*
Insert multiple rows into multiple tables
Besides inserting multiple rows into a table, you can use the INSERT ALL statement to insert multiple rows into multiple tables as shown in the following syntax:
Conditional Oracle INSERT ALL Statement
The conditional multitable insert statement allows you to insert rows into tables based on specified conditions.

The following shows the syntax of the conditional multitable insert statement:
*/
/*  Conditional Oracle INSERT ALL example
The following CREATE TABLE statements create three tables: small_orders, medium_orders, and big_orders with the same structures:
*/
CREATE TABLE small_orders (
    order_id NUMBER(12) NOT NULL,
    customer_id NUMBER(6) NOT NULL,
    amount NUMBER(8,2) 
);

CREATE TABLE medium_orders AS
SELECT *
FROM small_orders;

CREATE TABLE big_orders AS
SELECT *
FROM small_orders;

/*  The following conditional Oracle INSERT ALL statement inserts order data into the three tables small_orders, medium_orders, and big_orders based on orders’ amounts:
*/
INSERT ALL
   WHEN amount < 10000 THEN
      INTO small_orders
   WHEN amount >= 10000 AND amount <= 30000 THEN
      INTO medium_orders
   WHEN amount > 30000 THEN
      INTO big_orders
      
  SELECT order_id,
         customer_id,
         (quantity * unit_price) amount
  FROM orders
  INNER JOIN order_items USING(order_id);
  
--Conditional Oracle INSERT FIRST example
--Consider the following example:
INSERT FIRST
    WHEN amount > 30000 THEN
        INTO big_orders
    WHEN amount >= 10000 THEN
        INTO medium_orders
    WHEN amount > 0 THEN
        INTO small_orders
 SELECT order_id,
         customer_id,
         (quantity * unit_price) amount
 FROM orders
 INNER JOIN order_items USING(order_id);

---Oracle CASE Expression
--The following query uses the CASE expression to calculate the discount for each product category i.e., CPU 5%, video card 10%, and other product categories 8%
SELECT  product_name, list_price,
  CASE category_id
    WHEN 1
    THEN ROUND(list_price * 0.05,2) -- CPU
    WHEN 2
    THEN ROUND(List_price * 0.1,2)  -- Video Card
    ELSE ROUND(list_price * 0.08,2) -- other categories
  END discount
FROM   products
ORDER BY   product_name;

--Searched CASE expression
--The Oracle searched CASE expression evaluates a list of Boolean expressions to determine the result.
/* Searched CASE expression example
When you use the searched CASE expression within a SELECT statement, you can replace values in the result based on comparison values.
The following example uses the searched CASE expression to classify the products based on their list prices:
*/
SELECT  product_name,  list_price,
  CASE
    WHEN list_price > 0 AND list_price  < 600
        THEN 'Mass'
    WHEN list_price >= 600 AND list_price < 1000
        THEN 'Economy'
    WHEN list_price >= 1000 AND list_price < 2000
        THEN 'Luxury'
    ELSE 
        'Grand Luxury'
  END product_group
FROM  products
WHERE  category_id = 1
ORDER BY  product_name;
--The following query uses the CASE expression in an ORDER BY clause to determine the sort order of rows based on column value:
SELECT  * FROM   locations
WHERE country_id in ('US','CA','UK')
ORDER BY    country_id,
  CASE country_id
    WHEN 'US'
    THEN state
    ELSE city
  END;

---B) Using CASE expression in a HAVING clause
--In the following query, we use the CASE expression in a HAVING clause to restrict rows returned by the SELECT stateme
SELECT    product_name,    category_id,   COUNT(product_id)
FROM    order_items 
INNER JOIN products USING (product_id)
GROUP BY     product_name,     category_id
HAVING   COUNT(CASE WHEN category_id = 1 THEN product_id ELSE NULL END ) > 5 OR
    COUNT(CASE WHEN category_id = 2 THEN product_id ELSE NULL END) > 2
ORDER BY    product_name;
--C) Using the CASE expression in an UPDATE statement
--The following query finds all products whose gross margins are less than 12%:
SELECT  product_name,  list_price,  standard_cost,
  ROUND((list_price - standard_cost) * 100 / list_price,2) gross_margin
FROM  products
WHERE  ROUND((list_price - standard_cost) * 100 / list_price,2) < 12;

--The following UPDATE statement uses the CASE expression to update the list price of the products whose gross margin is less than 12% to list prices that make their gross margin 12%:
UPDATE  products
SET  list_price =
  CASE
    WHEN ROUND((list_price - standard_cost) * 100 / list_price,2) < 12
    THEN (standard_cost  + 1) * 12
  END
WHERE  ROUND((list_price - standard_cost) * 100 / list_price,2) < 12;
---Oracle CREATE TABLE
--Oracle CREATE TABLE statement example
--The following example shows how to create a new table named persons in the ot schema:
CREATE TABLE ot.persons(
    person_id NUMBER GENERATED BY DEFAULT AS IDENTITY,
    first_name VARCHAR2(50) NOT NULL,
    last_name VARCHAR2(50) NOT NULL,
    PRIMARY KEY(person_id)
);
---Oracle ALTER TABLE
/*
Oracle ALTER TABLE examples
We will use the persons table that we created in the previous tutorial for the demonstration.

Oracle ALTER TABLE ADD column examples
To add a new column to a table, you use the following syntax:
*/
ALTER TABLE table_name
ADD column_name type constraint;

--For example, the following statement adds a new column named birthdate to the persons table:
ALTER TABLE persons 
ADD birthdate DATE NOT NULL;
DESC persons;

--To add multiple columns to a table at the same time, you place the new columns inside the parenthesis as follows:
ALTER TABLE persons 
ADD (
    phone VARCHAR(20),
    email VARCHAR(100)
);
--Oracle ALTER TABLE MODIFY column examples
--For example, the following statement changes the birthdate column to a null-able column:
ALTER TABLE persons MODIFY birthdate DATE NULL;
/* For example, the following statement changes the phone and email column to NOT NULLcolumns and extends the length of the email column to 255 characters:
*/
ALTER TABLE persons MODIFY(
    phone VARCHAR2(20) NOT NULL,
    email VARCHAR2(255) NOT NULL
);
--Oracle ALTER TABLE DROP COLUMN example
--The following example removes the birthdate column from the persons table:
ALTER TABLE persons
DROP  COLUMN birthdate;
--Oracle ALTER TABLE RENAME column example
ALTER TABLE persons 
RENAME COLUMN first_name TO forename;
--Oracle ALTER TABLE RENAME table example
--For example, the statement below renames the persons table people:
ALTER TABLE persons 
RENAME TO people;

---Oracle ALTER TABLE ADD Column By Examples
---link: https://www.oracletutorial.com/oracle-basics/oracle-basicsoracle-alter-table-add-column/
--Oracle ALTER TABLE ADD column examples
--Let’s create a table named members for the demonstration.
CREATE TABLE members2(
    member_id NUMBER GENERATED BY DEFAULT AS IDENTITY,
    first_name VARCHAR2(50),
    last_name VARCHAR2(50),
    PRIMARY KEY(member_id) ); --this table already exists

--select * from members;
--The following statement adds a new column named birth_date to the members table:
ALTER TABLE members2 
ADD birth_date DATE NOT NULL;

--Suppose, you want to record the time at which a row is created and updated. To do so, you need to add two columns created_at and updated_at as follows:
ALTER TABLE
    members2 ADD(
        created_at TIMESTAMP WITH TIME ZONE NOT NULL,
        updated_at TIMESTAMP WITH TIME ZONE NOT NULL
    );
--To check whether a column exists in a table, you query the data from the user_tab_cols view. For example, the following statement checks whether the members table has the first_name column.    
SELECT  COUNT(*)
FROM   user_tab_cols
WHERE  column_name = 'FIRST_NAME'
AND table_name = 'MEMBERS2';
--This query comes in handy when you want to check whether a column exists in a table before adding it.
--For example, the following PL/SQL block checks whether the members table has effective_date column before adding it.
SET SERVEROUTPUT ON SIZE 1000000
DECLARE
  v_col_exists NUMBER ;
BEGIN
  SELECT count(*) INTO v_col_exists
    FROM user_tab_cols
    WHERE column_name = 'EFFECTIVE_DATE'
      AND table_name = 'MEMBERS';

   IF (v_col_exists = 0) THEN
      EXECUTE IMMEDIATE 'ALTER TABLE members ADD effective_date DATE';
   ELSE
    DBMS_OUTPUT.PUT_LINE('The column effective_date already exists');
  END IF;
END;
/
---Oracle Virtual Column
/* Introduction to the Oracle virtual column
A virtual column is a table column whose values are calculated automatically using other column values, or another deterministic expression.
*/
column_name [data_type] [GENERATED ALWAYS] AS (expression) [VIRTUAL];
/*
In this syntax:

First, specify the name ( column_name) of the virtual column.
Second, specify the virtual column’s data type. If you omit the data type, the virtual column will take the data type of the result of the expression.
Third, specify an expression in parentheses after the AS keyword. The values of the virtual column will derive from the expression.
*/
--Note that the GENERATED ALWAYS and VIRTUAL keywords are for clarity only.
--This statement shows how to define a virtual column in the CREATE TABLE statement:
CREATE TABLE table_name (
    ...,
    virtual_column_name AS (expression)
);
/*
Oracle virtual column examples
Let’s take some examples of using virtual columns.

1) Creating a table with a virtual column example
First, create a table named parts which has a virtual column:
*/
CREATE TABLE parts2(
    part_id INT GENERATED ALWAYS AS IDENTITY,
    part_name VARCHAR2(50) NOT NULL,
    capacity INT NOT NULL,
    cost DEC(15,2) NOT NULL,
    list_price DEC(15,2) NOT NULL,
    gross_margin AS ((list_price - cost) / cost),
    PRIMARY KEY(part_id)
);

---Second, insert some rows into the parts table:
INSERT INTO parts2(part_name, capacity, cost, list_price)
VALUES('G.SKILL TridentZ RGB Series 16GB (2 x 8GB)', 16, 95,105);

INSERT INTO parts2(part_name, capacity, cost, list_price)
VALUES('G.SKILL TridentZ RGB Series 32GB (4x8GB)', 32, 205,220);

INSERT INTO parts2(part_name, capacity, cost, list_price)
VALUES('G.SKILL TridentZ RGB Series 16GB (1 x 8GB)', 8, 50,70);

SELECT * FROM parts2;

/* 2) Adding a virtual column to an existing table example
First, add a new column named capacity_description to the parts table using the ALTER TABLE column:
*/
ALTER TABLE parts2
ADD (
    capacity_description AS (
            CASE 
                WHEN capacity <= 8 THEN 'Small' 
                WHEN capacity > 8 AND capacity <= 16 THEN 'Medium'
                WHEN capacity > 16 THEN 'Large'
            END)
);
SELECT * FROM parts2;
/* Advantages and disadvantages of virtual columns
Virtual columns provide the following advantages:

Virtual columns consume minimal space. Oracle only stores the metadata, not the data of the virtual columns.
Virtual columns ensure the values are always in sync with the source columns. For example, if you have a date column as the normal column and have the month, quarter, and year columns as the virtual columns. The values in the month, quarter, and year are always in sync with the date column.
Virtual columns help avoid using views to display derived values from other columns.
The disadvantage of virtual columns is:

Virtual columns may reduce query performance because their values are calculated at run-time.
*/
/* Virtual column limitations
These are the limitations of virtual columns:

Virtual columns are only supported in relational heap tables, but not in index-organized, external, object, cluster, or temporary tables.
The virtual column cannot be an Oracle-supplied datatype, a user-defined type, or LOB or LONG RAW.
The expression in the virtual column has the following restrictions:

It cannot refer to other virtual columns.
It cannot refer to normal columns of other tables.
It must return a scalar value.
It may refer to a deterministic user-defined function, however, if it does, the virtual column cannot be used as a partitioning key column.
*/
SELECT 
    column_name, 
    virtual_column,
    data_default
FROM 
    all_tab_cols
WHERE owner = '<owner_name>' 
AND table_name = '<table_name>';
--The following statement lists all columns of the parts table, including the virtual columns:
SELECT     column_name,     virtual_column,    data_default
FROM     all_tab_cols
WHERE owner = 'OT' 
AND table_name = 'PARTS';
--Oracle ALTER TABLE MODIFY Column
--To change the definition of a column in a table, you use the ALTER TABLE MODIFY column syntax as follows:
--Oracle ALTER TABLE MODIFY column examples
--First, create a new table named accounts for the demonstration:
CREATE TABLE accounts (
    account_id NUMBER GENERATED BY DEFAULT AS IDENTITY,
    first_name VARCHAR2(25) NOT NULL,
    last_name VARCHAR2(25) NOT NULL,
    email VARCHAR2(100),
    phone VARCHAR2(12) ,
    full_name VARCHAR2(51) GENERATED ALWAYS AS( 
            first_name || ' ' || last_name
    ),
    PRIMARY KEY(account_id)
);
--Second, insert some rows into the accounts table:
INSERT INTO accounts(first_name,last_name,phone)
VALUES('Trinity',
       'Knox',
       '410-555-0197');


INSERT INTO accounts(first_name,last_name,phone)
VALUES('Mellissa',
       'Porter',
       '410-555-0198');


INSERT INTO accounts(first_name,last_name,phone)
VALUES('Leeanna',
       'Bowman',
       '410-555-0199');

---Third, verify the insert operation by using the following SELECT statement
SELECT   * FROM   accounts;
--For example, the following statement makes the full_name column invisible
ALTER TABLE accounts 
MODIFY full_name INVISIBLE;
SELECT *FROM     accounts; 
ALTER TABLE accounts 
MODIFY full_name VISIBLE;

UPDATE
    accounts
SET
    phone = REPLACE(
        phone,
        '+1-',
        ''
    );
--The REPLACE() function replaces a substring with a new substring. In this case, it replaces the ‘+1-‘ with an empty string.
ALTER TABLE accounts 
MODIFY full_name VARCHAR2(52) 
GENERATED ALWAYS AS (first_name || ', ' || last_name);
--The following statement verifies the modification:
SELECT     * FROM    accounts;

---Oracle Drop Column
--Oracle SET UNUSED COLUMN example
--Let’s create a table named suppliers for the demonstration:
CREATE TABLE suppliers (
    supplier_id NUMBER GENERATED BY DEFAULT AS IDENTITY,
    contact_name VARCHAR2(255) NOT NULL,
    company_name VARCHAR2(255),
    phone VARCHAR2(100) NOT NULL,
    email VARCHAR2(255) NOT NULL,
    fax VARCHAR2(100) NOT NULL,
    PRIMARY KEY(supplier_id)
);
--The following statements insert sample data into the suppliers tabl
INSERT INTO suppliers (contact_name,company_name,phone,email,fax)
VALUES ('Solomon F. Zamora',
        'Elit LLP',
        '1-245-616-6781',
        'enim.condimentum@pellentesqueeget.org',
        '1-593-653-6421');


INSERT INTO suppliers (contact_name,company_name,phone,email,fax)
VALUES ('Haley Franco',
        'Ante Vivamus Limited',
        '1-754-597-2827',
        'Nunc@ac.com',
        '1-167-362-9592');


INSERT INTO suppliers (contact_name,company_name,phone,email,fax)
VALUES ('Gail X. Tyson',
        'Vulputate Velit Eu Inc.',
        '1-331-448-8406',
        'sem@gravidasit.edu',
        '1-886-556-8494');


INSERT INTO suppliers (contact_name,company_name,phone,email,fax)
VALUES ('Alec N. Strickland',
        'In At Associates',
        '1-467-132-4527',
        'Lorem@sedtortor.com',
        '1-735-818-0914');


INSERT INTO suppliers (contact_name,company_name,phone,email,fax)
VALUES ('Britanni Holt',
        'Magna Cras Convallis Corp.',
        '1-842-554-5106',
        'varius@seddictumeleifend.ca',
        '1-381-532-1632');


INSERT INTO suppliers (contact_name,company_name,phone,email,fax)
VALUES ('Audra O. Ingram',
        'Commodo LLP',
        '1-934-490-5667',
        'dictum.augue.malesuada@idmagnaet.net',
        '1-225-217-4699');


INSERT INTO suppliers (contact_name,company_name,phone,email,fax)
VALUES ('Cody K. Chapman',
        'Tempor Arcu Inc.',
        '1-349-383-6623',
        'non.arcu.Vivamus@rutrumnon.co.uk',
        '1-824-229-3521');


INSERT INTO suppliers (contact_name,company_name,phone,email,fax)
VALUES ('Tobias Merritt',
        'Amet Risus Company',
        '1-457-675-2547',
        'felis@ut.net',
        '1-404-101-9940');


INSERT INTO suppliers (contact_name,company_name,phone,email,fax)
VALUES ('Ryder G. Vega',
        'Massa LLC',
        '1-655-465-4319',
        'dui.nec@convalliserateget.co.uk',
        '1-282-381-9477');


INSERT INTO suppliers (contact_name,company_name,phone,email,fax)
VALUES ('Arthur Woods',
        'Donec Elementum Lorem Foundation',
        '1-406-810-9583',
        'eros.turpis.non@anteMaecenasmi.co.uk',
        '1-462-765-8157');


INSERT INTO suppliers (contact_name,company_name,phone,email,fax)
VALUES ('Lael Snider',
        'Ultricies Adipiscing Enim Corporation',
        '1-252-634-4780',
        'natoque.penatibus@in.com',
        '1-986-508-6373');
---To logically drop the fax column from the suppliers table, you use the following statement:
ALTER TABLE suppliers 
SET UNUSED COLUMN fax;

SELECT * FROM  suppliers;
--You can view the number of unused columns per table from the DBA_UNUSED_COL_TABS view:

SELECT  * FROM  DBA_UNUSED_COL_TABS;
--To drop all unused columns from the suppliers table, you use the following statement:
ALTER TABLE suppliers 
DROP UNUSED COLUMNS;

SELECT * FROM DBA_UNUSED_COL_TABS;

---Oracle DROP TABLE
--Introduction to Oracle DROP TABLE statement
--To move a table to the recycle bin or remove it entirely from the database, you use the DROP TABLE statement:

DROP TABLE schema_name.table_name
[CASCADE CONSTRAINTS | PURGE];

--Basic Oracle DROP TABLE example
--The following CREATE TABLE statement creates persons table for the demonstration:

CREATE TABLE persons2 (
    person_id NUMBER,
    first_name VARCHAR2(50) NOT NULL,
    last_name VARCHAR2(50) NOT NULL,
    PRIMARY KEY(person_id)
);  
--The following example drops the persons table from the database:
DROP TABLE persons2;

/*
Oracle DROP TABLE CASCADE CONSTRAINTS example
The following statements create two new tables named brands and cars:
*/
CREATE TABLE brands(
    brand_id NUMBER PRIMARY KEY,
    brand_name varchar2(50)
);

CREATE TABLE cars(
    car_id NUMBER PRIMARY KEY,
    make VARCHAR(50) NOT NULL,
    model VARCHAR(50) NOT NULL,
    year NUMBER NOT NULL,
    plate_number VARCHAR(25),
    brand_id NUMBER NOT NULL,

    CONSTRAINT fk_brand 
    FOREIGN KEY (brand_id) 
    REFERENCES brands(brand_id) ON DELETE CASCADE
);

DROP TABLE brands;
--The following statement returns all foreign key constraints of the cars table:
SELECT  a.table_name,  a.column_name,  a.constraint_name,
    c.owner,  c.r_owner, c_pk.table_name r_table_name,
    c_pk.constraint_name r_pk
FROM   all_cons_columns a
JOIN all_constraints c ON
    a.owner = c.owner
    AND a.constraint_name = c.constraint_name
JOIN all_constraints c_pk ON
    c.r_owner = c_pk.owner
    AND c.r_constraint_name = c_pk.constraint_name
WHERE
    c.constraint_type = 'R'
    AND a.table_name = 'CARS';
--To drop the brands table, you must use the CASCADE CONSTRAINTS clause as follows:
DROP TABLE brands CASCADE CONSTRAINTS;
 --The following statement drops the cars table using the PURGE clause:
 DROP TABLE cars purge;

--Drop multiple tables at once
--Oracle provides no direct way to drop multiple tables at once. However, you can use the following PL/SQL block to do it
BEGIN
  FOR rec IN
    (
      SELECT
        table_name
      FROM
        all_tables
      WHERE
        table_name LIKE 'TEST_%'
    )
  LOOP
    EXECUTE immediate 'DROP TABLE  '||rec.table_name || ' CASCADE CONSTRAINTS';
  END LOOP;
END;
/
--This block deletes all tables whose names start with TEST_.
--To test this code, you can first create three tables: test_1, test_2 and test_3 as follow
CREATE TABLE test_1(c1 VARCHAR2(50));
CREATE TABLE test_2(c1 VARCHAR2(50));
CREATE TABLE test_3(c1 VARCHAR2(50)); 
--Then, execute the PL/SQL block above.

----Oracle TRUNCATE TABLE
/*
Introduction to Oracle TRUNCATE TABLE statement
When you want to delete all data from a table, you use the DELETE statement without theWHERE clause as follows:

DELETE FROM table_name;
Code language: SQL (Structured Query Language) (sql)
For a table with a small number of rows, the DELETE statement does a good job. However, when you have a table with a large number of rows, using the DELETE statement to remove all data is not efficient.

Oracle introduced the TRUNCATE TABLE statement that allows you to delete all rows from a big table.

The following illustrates the syntax of the Oracle TRUNCATE TABLE statement:

TRUNCATE TABLE schema_name.table_name
[CASCADE]
[[ PRESERVE | PURGE] MATERIALIZED VIEW LOG ]]
[[ DROP | REUSE]] STORAGE ]
*/ 

/* Oracle TRUNCATE TABLE examples
Let’s look at some examples of using the TRUNCATE TABLE statement.

A) Oracle TRUNCATE TABLE simple example
The following statement creates a table named customers_copy and copies data from the customers table in the sample database:
*/  
CREATE TABLE customers_copy2 
AS SELECT   * FROM  customers; 
--To delete all rows from the customers_copy table you use the following TRUNCATE TABLE statement:
TRUNCATE TABLE customers_copy2;
/* B) Oracle TRUNCATE TABLE CASCADE example
First, let’s create quotations and quotation_items tables for the demonstration:
*/
CREATE TABLE quotations (
    quotation_no NUMERIC GENERATED BY DEFAULT AS IDENTITY,
    customer_id NUMERIC NOT NULL,
    valid_from DATE NOT NULL,
    valid_to DATE NOT NULL,
    PRIMARY KEY(quotation_no)
);

CREATE TABLE quotation_items (
    quotation_no NUMERIC,
    item_no NUMERIC ,
    product_id NUMERIC NOT NULL,
    qty NUMERIC NOT NULL,
    price NUMERIC(9 , 2 ) NOT NULL,
    PRIMARY KEY (quotation_no , item_no),
    CONSTRAINT fk_quotation FOREIGN KEY (quotation_no)
        REFERENCES quotations
        ON DELETE CASCADE
);

---Next, insert some rows into these two tables:
INSERT INTO quotations(customer_id, valid_from, valid_to)
VALUES(100, DATE '2017-09-01', DATE '2017-12-01');

INSERT INTO quotation_items(quotation_no, item_no, product_id, qty, price)
VALUES(1,1,1001,10,90.5);

INSERT INTO quotation_items(quotation_no, item_no, product_id, qty, price)
VALUES(1,2,1002,20,200.5);

INSERT INTO quotation_items(quotation_no, item_no, product_id, qty, price)
VALUES(1,3,1003,30, 150.5);

--Then, truncate the quotation table
TRUNCATE TABLE quotations;
TRUNCATE TABLE quotations CASCADE;

SELECT   * FROM   quotations;

SELECT  * FROM  quotation_items;

----Oracle RENAME Table
/*Introduction to the Oracle RENAME table statement
To rename a table, you use the following Oracle RENAME table statement as follows:

RENAME table_name TO new_name;
*/
--Oracle RENAME table example
--Let’s create a table named promotions for the demonstration.
CREATE TABLE promotions(
    promotion_id NUMBER GENERATED BY DEFAULT AS IDENTITY,
    promotion_name varchar2(255),
    start_date DATE NOT NULL,
    end_date DATE NOT NULL,
    PRIMARY KEY(promotion_id),
    CHECK (end_date > start_date)
);
--The following PL/SQL function returns the number of promotions by querying data from the promotions table:
CREATE OR REPLACE FUNCTION count_promotions
  RETURN NUMBER
IS
  v_count NUMBER;
BEGIN
  SELECT     COUNT( * )  INTO    v_count
  FROM    promotions;
  RETURN v_count;
END;

--To rename the promotions table to campaigns table, you use the following statement:
RENAME promotions TO campaigns;

SELECT
    constraint_name,
    search_condition
FROM
    all_constraints
WHERE
    table_name = 'CAMPAIGNS'
    AND constraint_type = 'C';
    
--To find the invalid objects in the current schema, you query data from the all_objects view as follows:
SELECT    owner,    object_type,    object_name
FROM    all_objects
WHERE    status = 'INVALID'
ORDER BY     object_type,    object_name;
---Oracle PRIMARY KEY
/*
Oracle PRIMARY KEY constraint examples
Typically, you create a primary key for a table when you create that table. In addition, you can add a primary key to a table after the fact by using the ALTER TABLE statement.

Creating a primary key that consists of one column
The following CREATE TABLE statement creates the purchase_orderstable:
*/
CREATE TABLE purchase_orders (
    po_nr NUMBER PRIMARY KEY,
    vendor_id NUMBER NOT NULL,
    po_status NUMBER(1,0) NOT NULL,
    created_at TIMESTAMP WITH TIME ZONE NOT NULL 
);
--Creating a primary key that consists of multiple columns
--The following statement creates the purchase order line items table:
CREATE TABLE purchase_order_items (
    po_nr NUMBER NOT NULL,
    item_nr NUMBER NOT NULL,
    product_id NUMBER NOT NULL,  
    quantity NUMBER NOT NULL,
    purchase_unit NUMBER NOT NULL,
    buy_price NUMBER (9,2) NOT NULL,
    delivery_date DATE,
    PRIMARY KEY (po_nr, item_nr)
);
--The following example creates the vendors table first and then adds a primary key constraint to it:
CREATE TABLE vendors (
    vendor_id NUMBER,
    vendor_name VARCHAR2(255) NOT NULL,
    address VARCHAR2(255) NOT NULL
);

ALTER TABLE vendors 
ADD CONSTRAINT pk_vendors PRIMARY KEY (vendor_id);

--Dropping an Oracle PRIMARY KEY constraint
--You will rarely drop a PRIMARY KEY constraint from a table. If you have to do so, you use the following ALTER TABLE statement
ALTER TABLE vendors
DROP CONSTRAINT pk_vendors;
--Enable / Disable an Oracle PRIMARY KEY constraint
/*To improve the performance when loading a large amount of data into a table or updating mass data, you can temporarily disable the PRIMARY KEY constraint.

To disable a PRIMARY KEYconstraint of a table, you use the ALTER TABLE statement:
*/
ALTER TABLE table_name
DISABLE CONSTRAINT primary_key_constraint_name;
--or
ALTER TABLE table_name
DISABLE PRIMARY KEY;
---To enable a primary key constraint, you use the following ALTER TABLE statement:
ALTER TABLE table_name
ENABLE CONSTRAINT primary_key_constraint_name;
--or
ALTER TABLE table_name
ENABLE PRIMARY KEY;

---Oracle Foreign Key
/*Introduction to Oracle foreign key constraint
A foreign key is all about the relationship. Let’s start with an example to clearly understand its concept.

Suppose, we have two tables supplier_groups and suppliers:
*/
CREATE TABLE supplier_groups(
    group_id NUMBER GENERATED BY DEFAULT AS IDENTITY,
    group_name VARCHAR2(255) NOT NULL,
    PRIMARY KEY (group_id)  
);

CREATE TABLE suppliers2 (
    supplier_id NUMBER GENERATED BY DEFAULT AS IDENTITY,
    supplier_name VARCHAR2(255) NOT NULL,
    group_id NUMBER NOT NULL,
    PRIMARY KEY(supplier_id)
);
---Assuming that the supplier_groups table contains the following data:
INSERT INTO supplier_groups(group_name) 
VALUES('One-time Supplier');

INSERT INTO supplier_groups(group_name) 
VALUES('Third-party Supplier');

INSERT INTO supplier_groups(group_name)
VALUES('Inter-co Supplier');

SELECT    * FROM     supplier_groups;

INSERT INTO suppliers(supplier_name, group_id)
VALUES('WD',4);

---Oracle Check Constraint
--- https://www.oracletutorial.com/oracle-basics/oracle-check-constraint/
/* Introduction to Oracle Check constraint
An Oracle check constraint allows you to enforce domain integrity by limiting the values accepted by one or more columns.

To create a check constraint, you define a logical expression that returns true or false. Oracle uses this expression to validate the data that is being inserted or updated. If the expression evaluates to true, Oracle accepts the data and carry the insert or update. Otherwise, Oracle will reject the data and does not insert or update at all.
You can apply a check constraint to a column or a group of columns. A column may have one or more check constraints.
When you apply multiple check constraints to a column, make sure that they are not mutually exclusive. In addition, you should not assume any particular order of evaluation of the expressions.
*/
--Creating Oracle Check constraint examples
--The following example creates the parts table whose buy prices are positive:

CREATE TABLE parts (
    part_id NUMBER GENERATED BY DEFAULT AS IDENTITY,
    part_name VARCHAR2(255) NOT NULL,
    buy_price NUMBER(9,2) CHECK(buy_price > 0),
    PRIMARY KEY(part_id)
);
--Attempting to insert 0 or negative buy price will cause an error:

INSERT INTO parts(part_name, buy_price)
VALUES('HDD',0);
--Oracle issued the following error:
--SQL Error: ORA-02290: check constraint (OT.SYS_C0010681)
---Oracle Unique Constraint
--Oracle unique constraint examples
--Let’s create a table named clients for the demonstration:
CREATE TABLE clients (
    client_id NUMBER GENERATED BY DEFAULT AS IDENTITY,
    first_name VARCHAR2(50) NOT NULL,
    last_name VARCHAR2(50) NOT NULL,
    company_name VARCHAR2(255) NOT NULL,
    email VARCHAR2(255) NOT NULL UNIQUE,
    phone VARCHAR(25)
);
--The email column has a unique constraint that ensures there will be no duplicate emails.
--The following statement inserts a row into the clients table:
INSERT INTO clients(first_name,last_name, email, company_name, phone)
VALUES('Christene','Snider','christene.snider@abc.com', 'ABC Inc', '408-875-6075');
--Now, we attempt to insert a new row whose email value already exists in the email colum
INSERT INTO clients(first_name,last_name, email, company_name, phone)
VALUES('Sherly','Snider','christene.snider@abc.com', 'ABC Inc', '408-875-6076');
--SQL Error: ORA-00001: unique constraint (OT.SYS_C0010726) violated
---Oracle NOT NULL
/* Introduction to Oracle NOT NULL constraint
An Oracle NOT NULL constraint specifies that a column cannot contain NULL values. 
The Oracle NOT NULL constraints are inline constraints which are typically used in the column definition of the CREATE TABLE statement.
*/
--Oracle NOT NULL constraint examples
--The following statement creates the surcharges table:
CREATE TABLE surcharges (
  surcharge_id NUMBER GENERATED BY DEFAULT AS IDENTITY,
  surcharge_name VARCHAR2(255) NOT NULL,
  amount NUMBER(9,2),
  PRIMARY KEY (surcharge_id)
);
INSERT INTO surcharges(surcharge_name, amount)
VALUES('Late order placement',10);

--The following statement displays all constraints of the surcharges table:
SELECT table_name, constraint_name, search_condition
FROM  user_constraints
WHERE  table_name = 'SURCHARGES'; 

--https://www.oracletutorial.com/oracle-basics/oracle-data-types/
---Oracle Data types

SELECT   10.2d, 32.7f FROM    dual;

CREATE TABLE t (
    x CHAR(10),
    y VARCHAR2(10)
);
:
INSERT INTO t(x, y )
VALUES('Oracle', 'Oracle');
--In this example, we used the DUMP() function to return the detailed information on x and y columns
SELECT
    x,
    DUMP(x),
    y,
    DUMP(y)
FROM
    t;
--It is more clear if you use the LENGTHB() function to get the number of bytes used by the x and y columns
SELECT     LENGTHB(x),    LENGTHB(y)
FROM     t;

variable v varchar2(10);
exec :v := 'Oracle';

--PL/SQL procedure successfully completed.

--https://www.oracletutorial.com/oracle-basics/oracle-date/
CREATE TABLE my_events (
    event_id NUMBER GENERATED BY DEFAULT AS IDENTITY,
    event_name VARCHAR2 ( 255 ) NOT NULL,
    location VARCHAR2 ( 255 ) NOT NULL,
    start_date DATE NOT NULL,
    end_date DATE NOT NULL,
    PRIMARY KEY ( event_id ) 
);
INSERT INTO my_events
            (event_name,
             location,
             start_date,
             end_date)
VALUES     ( 'TechEd Europe',
        'Barcelona, Spain',
            DATE '2017-11-14',
            DATE '2017-11-16' ); 
            INSERT INTO my_events
            (event_name,
             location,
             start_date,
             end_date)
VALUES     ( 'Oracle OpenWorld',
        'San Francisco, CA, USA',
            TO_DATE( 'October 01, 2017', 'MONTH DD, YYYY' ),
            TO_DATE( 'October 05, 2017', 'MONTH DD, YYYY')); 
 
INSERT INTO my_events
                (event_name,
                 location,
                 start_date,
                 end_date)
    VALUES     ( 'TechEd US',
            'Las Vegas, NV, USA',
                DATE '2017-09-25',
                DATE '2017-09-29' );           
SELECT  *  FROM  my_events;  

SELECT
  event_name, 
  location,
  TO_CHAR( start_date, 'FMMonth DD, YYYY' )  start_date, 
  TO_CHAR( end_date, 'FMMonth DD, YYYY' ) end_date 
from
  my_events;

--Oracle TIMESTAMP 
--First, create a new table named logs that has a TIMESTAMP column for the demonstration.
CREATE TABLE logs (
    log_id NUMBER GENERATED BY DEFAULT AS IDENTITY,
    message VARCHAR(50) NOT NULL,
    logged_at TIMESTAMP (2) NOT NULL,
    PRIMARY KEY (log_id)
);

--Second, insert new rows into to the logs table:
INSERT INTO logs (
    message,
    logged_at
    )
VALUES (
    'Invalid username/password for root user',
    LOCALTIMESTAMP(2)
    );

INSERT INTO logs (
    message,
    logged_at
    )
VALUES (
    'User root logged in successfully',
    LOCALTIMESTAMP(2)
    );

SELECT log_id,
       message,
       logged_at
FROM logs;

SELECT message,
    TO_CHAR(logged_at, 'MONTH DD, YYYY "at" HH24:MI')
FROM logs;

--Extract TIMESTAMP components
SELECT 
    message,
    EXTRACT(year FROM logged_at) year,
    EXTRACT(month FROM logged_at) month,
    EXTRACT(day FROM logged_at) day,
    EXTRACT(hour FROM logged_at) hour,
    EXTRACT(minute FROM logged_at) minute,
    EXTRACT(second FROM logged_at) second
FROM 
    logs;
    
INSERT INTO logs (
    message,
    logged_at
    )
VALUES (
    'Test default Oracle ',
    TO_TIMESTAMP('03-AUG-17 11:20:30.45 AM')
    );
--Oracle INTERVAL YEAR TO MONTH example
--First, let’s create a new table named candidates for the demonstration:
CREATE TABLE candidates (
    candidate_id NUMBER(2,10),
    first_name VARCHAR2(50) NOT NULL,
    last_name VARCHAR2(50) NOT NULL,
    job_title VARCHAR2(255) NOT NULL,
    year_of_experience INTERVAL YEAR TO MONTH,
    PRIMARY KEY (candidate_id)
);
--Second, insert data into the candidates table:
INSERT INTO candidates (candidate_id,
    first_name,
    last_name,
    job_title,
    year_of_experience
    )
VALUES (2,
    'Camila',
    'Kramer',
    'SCM Manager',
    INTERVAL '10-2' YEAR TO MONTH
    );

INSERT INTO candidates (candidate_id,
    first_name,
    last_name,
    job_title,
    year_of_experience
    )
VALUES (3,
    'Keila',
    'Doyle',
    'SCM Staff',
    INTERVAL '9' MONTH
    );

SELECT * FROM candidates; 

---Oracle Global Temporary Table
--1) Creating a transaction-specific global temporary table example
---First, create a transaction-specific global temporary table using the ON COMMIT DELETE ROWS option:
CREATE GLOBAL TEMPORARY TABLE temp1(
    id INT,
    description VARCHAR2(100)
) ON COMMIT DELETE ROWS;

INSERT INTO temp1(id,description)
VALUES(1,'Transaction specific global temp table');

SELECT id, description 
FROM temp1;

---2) Creating a session-specific global temporary table exampl
--First, create a session-specific global temporary table:

CREATE GLOBAL TEMPORARY TABLE temp2(
    id INT,
    description VARCHAR2(100)
) ON COMMIT PRESERVE ROWS;
INSERT INTO temp2(id,description)
VALUES(1,'Session specific global temp table');

SELECT id, description 
FROM temp2;

----Oracle Private Temporary Table
---https://www.oracletutorial.com/oracle-basics/oracle-private-temporary-table/





















