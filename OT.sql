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
SELECT   name  FROM   customers;
  
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
FROM  contacts
ORDER BY  first_name, last_name DESC;

SELECT name, credit_limit
FROM  customers
ORDER BY 2 DESC,1;

SELECT  country_id, city, state
FROM locations
ORDER BY   city, state;

SELECT  country_id, city,state
FROM   locations
ORDER BY  state ASC NULLS FIRST;

SELECT  country_id,city,state 
FROM   locations 
ORDER BY state ASC NULLS LAST;
 
SELECT customer_id, name
FROM  customers
ORDER BY  upper( name ); 

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

SELECT
  first_name  || ' '  || last_name AS "Full Name"
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
----The following query uses the row limiting clause with the

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
WHERE     (
        status = 'Canceled'
        OR status = 'Pending'   )
    AND customer_id = 44 ORDER BY     order_date;
    
----Oracle OR Operator

SELECT  order_id, customer_id, status, order_date FROM     orders
WHERE     status = 'Pending'     OR status = 'Canceled'
ORDER BY     order_date DESC;

---Oracle IN
SELECT order_id, customer_id, status,  salesman_id
FROM    orders WHERE    salesman_id IN (  54,  55, 56 )
ORDER BY  order_id;

SELECT    order_id,    customer_id,    status,    salesman_id
FROM    orders WHERE    status IN( 'Pending', 'Canceled'  )
ORDER BY    order_id;

SELECT  employee_id, first_name, last_name FROM     employees
WHERE     employee_id IN(
        SELECT   DISTINCT salesman_id
        FROM             orders
        WHERE          status = 'Canceled' ) ORDER BY     first_Name;
        
----Oracle BETWEEN
SELECT  product_name, standard_cost
FROM  products
WHERE  standard_cost BETWEEN 500 AND 600
ORDER BY   standard_cost;

SELECT  product_name, standard_cost
FROM     products
WHERE     standard_cost NOT BETWEEN 500 AND 600
ORDER BY     product_name;
    
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
  (
    product_id NUMBER, 
    discount_message VARCHAR2( 255 ) NOT NULL,
    PRIMARY KEY( product_id )
  );


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
    color VARCHAR2 (100) NOT NULL
);

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
FROM     palette_a a
LEFT JOIN palette_b b ON a.color = b.color
WHERE b.id IS NULL;

----Oracle right join
SELECT a.id id_a,a.color color_a, b.id id_b, b.color color_b
FROM     palette_a a
RIGHT JOIN palette_b b ON a.color = b.color;

----Oracle full outer join
SELECT a.id id_a, a.color color_a, b.id id_b, b.color color_b
FROM   palette_a a
FULL OUTER JOIN palette_b b ON a.color = b.color;

SELECT a.id id_a, a.color color_a, b.id id_b, b.color color_b
FROM  palette_a a
FULL JOIN palette_b b ON a.color = b.color
WHERE a.id IS NULL OR b.id IS NULL;

----Oracle INNER JOIN
SELECT  * FROM     orders
INNER JOIN order_items ON
    order_items.order_id = orders.order_id
ORDER BY  order_date DESC;
    
SELECT * FROM   orders 
INNER JOIN order_items USING( order_id )
ORDER BY   order_date DESC;

SELECT   name AS customer_name,  order_id,  order_date,  item_id,  quantity,  unit_price
FROM   orders
INNER JOIN order_items USING(order_id)
INNER JOIN customers USING(customer_id)
ORDER BY   order_date DESC,
order_id DESC,   item_id ASC;    

---The following example illustrates how to join four tables: orders,  order_items, customers, and products
SELECT    name AS customer_name,  order_id, order_date, item_id, product_name, quantity, unit_price
FROM     orders
INNER JOIN order_items         USING(order_id)
INNER JOIN customers         USING(customer_id)
INNER JOIN products         USING(product_id)
ORDER BY     order_date DESC,    order_id DESC,    item_id ASC;

---Oracle LEFT JOIN
SELECT order_id,status,first_name,last_name
FROM   orders LEFT JOIN employees ON employee_id = salesman_id
ORDER BY   order_date DESC;
--The following statement uses LEFT JOIN clauses to join three tables: orders, employees and customers:

SELECT order_id, name AS customer_name, status, first_name, last_name
FROM  orders LEFT JOIN employees ON
employee_id = salesman_id
LEFT JOIN customers ON     customers.customer_id = orders.customer_id
ORDER BY     order_date DESC;

--- create two tables
CREATE TABLE projects(
    project_id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    project_name VARCHAR2(100) NOT NULL
);

CREATE TABLE members(
    member_id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    member_name VARCHAR2(100) NOT NULL,
    project_id INT,
    FOREIGN KEY (project_id) REFERENCES projects(project_id)
);
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
FROM  members m     FULL OUTER JOIN projects p 
        ON p.project_id = m.project_id
WHERE     project_name IS NULL
ORDER BY     member_name;  
  
----Oracle CROSS JOIN
SELECT product_id, warehouse_id,
    ROUND( dbms_random.value( 10, 100 )) quantity
FROM     products 
CROSS JOIN warehouses;

---Oracle Self Join
SELECT (e.first_name || '  ' || e.last_name) employee,  (m.first_name || '  ' || m.last_name) manager,
    e.job_title  FROM     employees e
LEFT JOIN employees m ON
    m.employee_id = e.manager_id
ORDER BY     manager;

SELECT   e1.hire_date,  (e1.first_name || ' ' || e1.last_name) employee1,  (e2.first_name || ' ' || e2.last_name) employee2  
FROM     employees e1
INNER JOIN employees e2 ON
    e1.employee_id > e2.employee_id
    AND e1.hire_date = e2.hire_date
ORDER BY     e1.hire_date DESC,   employee1,    employee2;
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
INNER JOIN customers         USING(customer_id)
GROUP BY     name
ORDER BY     name;
----C) Oracle GROUP BY with an expression example
SELECT     EXTRACT(YEAR FROM order_date) YEAR,     COUNT( order_id )
FROM     orders
GROUP BY     EXTRACT(YEAR FROM order_date)
ORDER BY     YEAR;
----D) Oracle GROUP BY with WHERE clause example
SELECT   name,    COUNT( order_id ) 
FROM orders    INNER JOIN customers USING(customer_id) 
WHERE    status = 'Shipped'
GROUP BY    name 
ORDER BY    name;
----E) Oracle GROUP BY with ROLLUP example
SELECT    customer_id,    status,    SUM( quantity * unit_price ) sales
FROM     orders INNER JOIN order_items         USING(order_id)
GROUP BY     ROLLUP(  customer_id,   status  );
-------Oracle HAVING
---A) Simple Oracle HAVING example
SELECT    order_id,    SUM( unit_price * quantity ) order_value
FROM    order_items
GROUP BY    order_id ORDER BY    order_value DESC;

SELECT    order_id,    SUM( unit_price * quantity ) order_value
FROM    order_items
GROUP BY    order_id
HAVING    SUM( unit_price * quantity ) > 1000000
ORDER BY    order_value DESC;
---B) Oracle HAVING with complex conditions example
SELECT    order_id,    COUNT( item_id ) item_count,    SUM( unit_price * quantity ) total
FROM    order_items
GROUP BY    order_id
HAVING    SUM( unit_price * quantity ) > 500000 AND COUNT( item_id ) BETWEEN 10 AND 12
ORDER BY    total DESC,    item_count DESC;

-----Oracle UNION
---A) Oracle UNION example
SELECT  first_name, last_name,  email, 'contact'
FROM    contacts
UNION SELECT     first_name,     last_name,    email,    'employee'
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
MINUS
SELECT     last_name
FROM    employees
ORDER BY     last_name;

SELECT  product_id FROM  products
MINUS
SELECT   product_id  FROM   inventories;
-------Oracle Subquery
SELECT     product_id,    product_name,    list_price
FROM     products
WHERE     list_price = ( SELECT  MAX( list_price )
FROM     products   );

SELECT     product_name,    list_price,
    ROUND(        (
            SELECT     AVG( list_price )
            FROM     products p1
            WHERE     p1. category_id = p2.category_id   ),
        3  ) avg_list_price
FROM  products p2 ORDER BY   product_name;

----B) Oracle subquery in the FROM clause example
SELECT     order_id,    order_value
FROM    (        SELECT             order_id,
            SUM( quantity * unit_price ) order_value
        FROM            order_items
        GROUP BY            order_id
        ORDER BY            order_value DESC
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
        HAVING
            SUM( quantity * unit_price )  >= 1000000  
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

SELECT
    product_id,
    product_name,
    list_price
FROM     products
WHERE     list_price =(
        SELECT             MIN( list_price )
        FROM             products    );
SELECT    product_id,   product_name,    list_price
FROM    products p
WHERE    list_price > (
        SELECT            AVG( list_price )
        FROM            products
        WHERE            category_id = p.category_id    );

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
DELETE
FROM
    customers
WHERE
    NOT EXISTS(
        SELECT
            NULL
        FROM
            orders
        WHERE
            orders.customer_id = customers.customer_id
            AND EXTRACT(
                YEAR FROM order_date
            ) IN(
                2016,
                2017
            )
    );

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

---ORALCE TRIGGER EXAMPLES    
CREATE OR REPLACE TRIGGER customers_credit_trg
    BEFORE UPDATE OF credit_limit  
    ON customers
DECLARE
    l_day_of_month NUMBER;
BEGIN
    -- determine the transaction type
    l_day_of_month := EXTRACT(DAY FROM sysdate);

    IF l_day_of_month BETWEEN 28 AND 31 THEN
        raise_application_error(-20100,'Cannot update customer credit from 28th to 31st');
    END IF;
END;

UPDATE 
    customers 
SET 
    credit_limit = credit_limit * 110;
    
    
    CREATE TABLE audits (
      audit_id         NUMBER ,
      table_name       VARCHAR2(255),
      transaction_name VARCHAR2(10),
      by_user          VARCHAR2(30),
      transaction_date DATE
);

select * from CUSTOMERS where customer_id =10;

SELECT * FROM audits;

select * from EMPLOYEES;

UPDATE
   customers
SET
   credit_limit = 2000
WHERE
   customer_id =10;
 
DELETE FROM customers
WHERE customer_id = 10;  

CREATE OR REPLACE TRIGGER customers_audit_trg
    AFTER 
    UPDATE OR DELETE 
    ON customers
    FOR EACH ROW    
DECLARE
   l_transaction VARCHAR2(10);
BEGIN
   -- determine the transaction type
   l_transaction := CASE  
         WHEN UPDATING THEN 'UPDATE'
         WHEN DELETING THEN 'DELETE'
   END;

   -- insert a row into the audit table   
   INSERT INTO audits (table_name, transaction_name, by_user, transaction_date)
   VALUES('CUSTOMERS', l_transaction, USER, SYSDATE);
END;
/


DECLARE
   v_first_name VARCHAR2(50);
   v_last_name VARCHAR2(50);
   BEGIN
   SELECT first_name, last_name  INTO v_first_name, v_last_name, 
   FROM employees
   WHERE employee_id = 105;

   DBMS_OUTPUT.PUT_LINE('Name: ' || v_first_name || ' ' || v_last_name);
   END;
/



CREATE OR REPLACE TRIGGER customers_update_credit_trg 
    BEFORE UPDATE OF credit_limit
    ON customers
    FOR EACH ROW
    WHEN (NEW.credit_limit > 0)
BEGIN
    -- check the credit limit
    IF :NEW.credit_limit >= 2 * :OLD.credit_limit THEN
        raise_application_error(-20101,'The new credit ' || :NEW.credit_limit || 
            ' cannot increase to more than double, the current credit ' || :OLD.credit_limit);
    END IF;
END;

SELECT credit_limit 
FROM customers 
WHERE customer_id = 10;

UPDATE customers
SET credit_limit = 5000
WHERE customer_id = 11;


