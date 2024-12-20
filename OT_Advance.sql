----Advanced Oracle SQL
---How to Find Duplicate Records in Oracle
--https://www.oracletutorial.com/advanced-oracle-sql/find-duplicate-records-oracle/
CREATE TABLE fruits2 (
        fruit_id   NUMBER generated BY DEFAULT AS IDENTITY,
        fruit_name VARCHAR2(100),
        color VARCHAR2(20));
INSERT INTO fruits2(fruit_name,color) VALUES('Apple','Red');
INSERT INTO fruits2(fruit_name,color) VALUES('Apple','Red');
INSERT INTO fruits2(fruit_name,color) VALUES('Orange','Orange');
INSERT INTO fruits2(fruit_name,color) VALUES('Orange','Orange');
INSERT INTO fruits2(fruit_name,color) VALUES('Orange','Orange');
INSERT INTO fruits2(fruit_name,color) VALUES('Banana','Yellow');
INSERT INTO fruits2(fruit_name,color) VALUES('Banana','Green');
--Finding duplicate rows using the aggregate function
SELECT  fruit_name, color, COUNT(*)
FROM   fruits2
GROUP BY  fruit_name, color;

SELECT  fruit_name, color, COUNT(*)
FROM  fruits2
GROUP BY  fruit_name, color
HAVING COUNT(*) > 1; 

SELECT * FROM fruits2
WHERE (fruit_name, color) IN
    (SELECT fruit_name,color
    FROM fruits2
    GROUP BY fruit_name,color
    HAVING COUNT(*) > 1  )
ORDER BY fruit_name, color;
--Finding duplicate records using analytic function

SELECT f.*,    COUNT(*) OVER (PARTITION BY fruit_name, color) c
FROM fruits2 f;

--- with cte
WITH fruit_counts AS (
    SELECT f.*,
        COUNT(*) OVER (PARTITION BY fruit_name, color) c
    FROM fruits2 f)
SELECT * FROM fruit_counts
WHERE c > 1 ;
---inline view
SELECT  * FROM
        (SELECT f.*,
            COUNT(*) OVER (PARTITION BY fruit_name, color) c
        FROM fruits2 f  )
WHERE c > 1;
--https://www.oracletutorial.com/advanced-oracle-sql/how-to-delete-duplicate-records-in-oracle/
--How to Delete Duplicate Records in Oracle
DELETE FROM   fruits2
WHERE  fruit_id NOT IN
  (  SELECT   MAX(fruit_id)
    FROM    fruits2
    GROUP BY   fruit_name,  color );
---3 rows deleted

DROP TABLE fruits2;

CREATE TABLE fruits2 (
        fruit_id   NUMBER,
        fruit_name VARCHAR2(100),
        color VARCHAR2(20)
);

INSERT INTO fruits2(fruit_id,fruit_name,color) VALUES(1,'Apple','Red');
INSERT INTO fruits2(fruit_id,fruit_name,color) VALUES(1,'Apple','Red');
INSERT INTO fruits2(fruit_id,fruit_name,color) VALUES(2,'Orange','Orange');
INSERT INTO fruits2(fruit_id,fruit_name,color) VALUES(2,'Orange','Orange');
INSERT INTO fruits2(fruit_id,fruit_name,color) VALUES(2,'Orange','Orange');
INSERT INTO fruits2(fruit_id,fruit_name,color) VALUES(3,'Banana','Yellow');
INSERT INTO fruits2(fruit_id,fruit_name,color) VALUES(4,'Banana','Green');

SELECT * FROM fruits2;
--delete duplicate rows
DELETE FROM  fruits
WHERE rowid NOT IN
  ( SELECT  MIN(rowid)
    FROM    fruits2
    GROUP BY fruit_id,fruit_name,  color );
---3 duplicate rows deleted
--https://www.oracletutorial.com/advanced-oracle-sql/how-to-compare-two-rows-in-same-table-in-oracle/
--How to Compare Two Rows in the Same Table in Oracle
CREATE TABLE product_prices (
    id  NUMBER generated BY DEFAULT AS identity,
    product_id NUMBER,
    valid_from DATE,
    list_price NUMBER,
    PRIMARY KEY(id),
    UNIQUE (product_id, valid_from, list_price)
);
INSERT INTO product_prices(product_id, valid_from, list_price)
VALUES(100, DATE '2016-01-01', 700);
INSERT INTO product_prices(product_id, valid_from, list_price)
VALUES(100, DATE '2016-06-01', 630);
INSERT INTO product_prices(product_id, valid_from, list_price)
VALUES(100, DATE '2016-08-01', 520);
INSERT INTO product_prices(product_id, valid_from, list_price)
VALUES(100, DATE '2017-01-01', 420);
--
SELECT cur.product_id,cur.valid_from, cur.list_price,
  (cur.list_price - prv.list_price) diff
FROM  product_prices prv
INNER JOIN product_prices cur
ON  cur.id = prv.id+1
WHERE  cur.product_id = 100;
--https://www.oracletutorial.com/oracle-view/
--Oracle View
SELECT name AS customer,
    SUM( quantity * unit_price ) sales_amount,
    EXTRACT( YEAR FROM  order_date ) YEAR
FROM   orders
INNER JOIN order_items  USING(order_id)
INNER JOIN customers  USING(customer_id)
WHERE   status = 'Shipped'
GROUP BY  name,  EXTRACT(YEAR FROM order_date );
--create a view
CREATE OR REPLACE VIEW customer_sales AS 
SELECT name AS customer,
    SUM( quantity * unit_price ) sales_amount,
    EXTRACT( YEAR FROM  order_date  ) YEAR
FROM  orders
INNER JOIN order_items     USING(order_id)
INNER JOIN customers       USING(customer_id)
WHERE  status = 'Shipped'
GROUP BY  name,EXTRACT( YEAR FROM order_date  );

select * from customer_sales;

SELECT  customer,  sales_amount
FROM  customer_sales
WHERE   YEAR = 2017
ORDER BY    sales_amount DESC;

---https://www.oracletutorial.com/oracle-view/oracle-create-view/
---Oracle CREATE VIEW
--To create a new view in a database, you use the following Oracle CREATE VIEW statement:
CREATE VIEW employee_yos AS
SELECT  employee_id,  first_name || ' ' || last_name full_name,
    FLOOR( months_between( CURRENT_DATE, hire_date )/ 12 ) yos
FROM   employees;
---
CREATE OR REPLACE VIEW customer_credits(
        customer_id,
        name,
        credit
    ) AS 
SELECT
        customer_id,
        name,
        credit_limit
    FROM
        customers WITH READ ONLY;
---
CREATE OR REPLACE VIEW backlogs AS
SELECT  product_name,
    EXTRACT(  YEAR  FROM     order_date  ) YEAR,
    SUM( quantity * unit_price ) amount
FROM    orders
INNER JOIN order_items        USING(order_id)
INNER JOIN products        USING(product_id)
WHERE   status = 'Pending'
GROUP BY   EXTRACT(   YEAR  FROM   order_date  ),
product_name;
--https://www.oracletutorial.com/oracle-view/oracle-drop-view/
--Oracle DROP VIEW
--To remove a view from the database, you use the following DROP VIEW statement:
CREATE VIEW salesman AS 
SELECT    *
FROM    employees
WHERE    job_title = 'Sales Representative';
--
SELECT    * FROM    salesman;
--
CREATE VIEW salesman_contacts AS 
SELECT  first_name, last_name,  email,  phone
FROM    salesman;
DROP VIEW salesman;
--status of view
SELECT  object_name, status
FROM   user_objects
WHERE  object_type = 'VIEW' 
AND object_name = 'SALESMAN_CONTACTS';

DROP VIEW salesman_contacts;

---https://www.oracletutorial.com/oracle-view/oracle-updatable-view/
---Oracle Updatable View
CREATE TABLE brands(
    brand_id NUMBER GENERATED BY DEFAULT AS IDENTITY,
    brand_name VARCHAR2(50) NOT NULL,
    PRIMARY KEY(brand_id)
);

CREATE TABLE cars (
    car_id NUMBER GENERATED BY DEFAULT AS IDENTITY,
    car_name VARCHAR2(255) NOT NULL,
    brand_id NUMBER NOT NULL,
    PRIMARY KEY(car_id),
    FOREIGN KEY(brand_id) 
    REFERENCES brands(brand_id) ON DELETE CASCADE
);

INSERT INTO brands(brand_name)
VALUES('Audi');

INSERT INTO brands(brand_name)
VALUES('BMW');

INSERT INTO brands(brand_name)
VALUES('Ford');

INSERT INTO brands(brand_name)
VALUES('Honda');

INSERT INTO brands(brand_name)
VALUES('Toyota');

INSERT INTO cars (car_name,brand_id)
VALUES('Audi R8 Coupe',1);

INSERT INTO cars (car_name,brand_id)
VALUES('Audi Q2', 1);

INSERT INTO cars (car_name,brand_id)
VALUES('Audi S1', 1);

INSERT INTO cars (car_name,brand_id)
VALUES('BMW 2-serie Cabrio',2);

INSERT INTO cars (car_name,brand_id)
VALUES('BMW i8', 2);

INSERT INTO cars (car_name,brand_id)
VALUES('Ford Edge',3);

INSERT INTO cars (car_name,brand_id)
VALUES('Ford Mustang Fastback', 3);

INSERT INTO cars (car_name,brand_id)
VALUES('Honda S2000', 4);

INSERT INTO cars (car_name,brand_id)
VALUES('Honda Legend', 4);

INSERT INTO cars (car_name,brand_id)
VALUES('Toyota GT86', 5);

INSERT INTO cars (car_name,brand_id)
VALUES('Toyota C-HR', 5);
--create view
CREATE VIEW cars_master AS 
SELECT  car_id,  car_name
FROM    cars;
--delete row from view

DELETE FROM    cars_master
WHERE    car_id = 1;
--update
UPDATE    cars_master
SET    car_name = 'Audi RS7 Sportback'
WHERE    car_id = 2;
---insert
INSERT INTO cars_master
VALUES('Audi S1 Sportback');
---error with above inserte statment
CREATE VIEW all_cars AS 
SELECT car_id, car_name,  c.brand_id,  brand_name
FROM    cars c
INNER JOIN brands b ON    b.brand_id = c.brand_id; 
---insert
INSERT INTO all_cars(car_name, brand_id )
VALUES('Audi A5 Cabriolet', 1);
--delete 
DELETE FROM    all_cars
WHERE    brand_name = 'Honda';
--Find updatable columns of a join view
SELECT    * FROM
    USER_UPDATABLE_COLUMNS
WHERE    TABLE_NAME = 'ALL_CARS';
--https://www.oracletutorial.com/oracle-view/oracle-viewinline-view-in-oracle/
--The Basics of Inline View in Oracle
--An inline view is not a real view but a subquery in the FROM clause of a SELECT statement. Consider the following SELECT statement:
--A) simple Oracle inline view example
SELECT  * FROM
    (  SELECT    product_id,   product_name,   list_price
        FROM    products
        ORDER BY     list_price DESC   )
WHERE    ROWNUM <= 10;
--inline query
SELECT  category_name, max_list_price
FROM product_categories a,
    ( SELECT category_id,   MAX( list_price ) max_list_price
        FROM   products
        GROUP BY  category_id  ) b
WHERE    a.category_id = b.category_id
ORDER BY    category_name;
--Oracle inline view: data manipulation examples
UPDATE ( SELECT  list_price
        FROM      products
        INNER JOIN product_categories using (category_id)
        WHERE    category_name = 'CPU'  )
SET  list_price = list_price * 1.15; 
---delete
DELETE  ( SELECT   list_price
        FROM      products
        INNER JOIN product_categories
                USING(category_id)
        WHERE      category_name = 'Video Card'
    )
WHERE   list_price < 1000; 
---https://www.oracletutorial.com/oracle-view/oracle-with-check-option/
--Oracle WITH CHECK OPTION
--The WITH CHECK OPTION clause is used for an updatable view to prohibit the changes to the view that would produce rows that are not included in the defining query.
CREATE  VIEW audi_cars AS SELECT
        car_id,   car_name, brand_id
    FROM    cars
    WHERE   brand_id = 1;
 ---insert
INSERT  INTO   audi_cars( car_name,       brand_id     )
VALUES('BMW Z3 coupe', 2  ); 
---update
UPDATE  audi_cars
SET car_name = 'BMW 1-serie Coupe',
    brand_id = 2
WHERE  car_id = 3;
--create view
CREATE  VIEW ford_cars AS SELECT
        car_id,   car_name,   brand_id
FROM    cars
WHERE   brand_id = 3 WITH CHECK OPTION;
UPDATE  ford_cars
SET brand_id = 4,
    car_name = 'Honda NSX'
WHERE    car_id = 6;
---https://www.oracletutorial.com/oracle-index/
--Oracle Index
--Oracle Create Index
drop table members;
CREATE TABLE members(
    member_id INT GENERATED BY DEFAULT AS IDENTITY,
    first_name VARCHAR2(100) NOT NULL,
    last_name VARCHAR2(100) NOT NULL,
    gender CHAR(1) NOT NULL,
    dob DATE NOT NULL,
    email VARCHAR2(255) NOT NULL,
    PRIMARY KEY(member_id)
); 
SELECT   index_name,  index_type,  visibility,   status 
FROM   all_indexes
WHERE   table_name = 'MEMBERS';
--creating index
CREATE INDEX members_last_name_i 
ON members(last_name);

--To check if a query uses the index for lookup or not, you follow these steps:
EXPLAIN PLAN FOR
SELECT * FROM members
WHERE last_name = 'Harse';

SELECT     PLAN_TABLE_OUTPUT 
FROM     TABLE(DBMS_XPLAN.DISPLAY());

CREATE INDEX members_name_i
ON members(last_name,first_name);
--
EXPLAIN PLAN FOR
SELECT * 
FROM members
WHERE last_name LIKE 'A%' 
    AND first_name LIKE 'M%';    
    
SELECT   PLAN_TABLE_OUTPUT 
FROM TABLE(DBMS_XPLAN.DISPLAY());
--https://www.oracletutorial.com/oracle-index/oracle-drop-index/
--Oracle DROP INDEX
DECLARE index_count INTEGER;
BEGIN
SELECT COUNT(*) INTO index_count
    FROM USER_INDEXES
    WHERE INDEX_NAME = 'index_name';

IF index_count > 0 THEN
    EXECUTE IMMEDIATE 'DROP INDEX index_name';
END IF;
END;
/
DROP INDEX members_name_i;
---https://www.oracletutorial.com/oracle-index/oracle-unique-index/
--Oracle UNIQUE Index
CREATE UNIQUE INDEX members_email_i
ON members(email);
---
CREATE TABLE t4 (
    pk1 INT PRIMARY KEY,
    c1 INT);
SELECT index_name,  index_type,  visibility,   status 
FROM   all_indexes
WHERE  table_name = 'T4';
--https://www.oracletutorial.com/oracle-index/oracle-function-based-index/
--Oracle Function-based Index
--Oracle function-based index example
CREATE INDEX members_last_name_fi
ON members(UPPER(last_name));
--https://www.oracletutorial.com/oracle-index/oracle-bitmap-index/
--Oracle Bitmap Index
CREATE TABLE bitmap_index_demo(
    id INT GENERATED BY DEFAULT AS IDENTITY,
    active NUMBER NOT NULL,
    PRIMARY KEY(id));
CREATE BITMAP INDEX bitmap_index_demo_active_i
ON bitmap_index_demo(active);
---
INSERT INTO bitmap_index_demo(active) 
VALUES(1);

INSERT INTO bitmap_index_demo(active) 
VALUES(0);
--https://www.oracletutorial.com/oracle-synonym/
--Oracle Synonym
--Synonyms provide a level of security by hiding the name and owner of a schema object such as a table or a view. On top of that, they provide location transparency for remote objects of a distributed database.
CREATE PUBLIC SYNONYM sales FOR lion.sales; 
--https://www.oracletutorial.com/oracle-synonym/oracle-create-synonym/
--Oracle CREATE SYNONYM
CREATE SYNONYM stocks
FOR inventories;
SELECT * FROM stocks;
---https://www.oracletutorial.com/oracle-synonym/oracle-drop-synonym/
--Oracle DROP SYNONYM
DROP SYNONYM stocks;
--https://www.oracletutorial.com/oracle-sequence/
---Oracle Sequence
/*A sequence is a list of integers in which their orders are important. For example, the (1,2,3,4,5) and (5,4,3,2,1) are totally different sequences even though they have the same members.
*/
CREATE SEQUENCE item_seq;
SELECT item_seq.NEXTVAL
FROM dual;
SELECT item_seq.CURRVAL
FROM dual;
---
SELECT item_seq.NEXTVAL
FROM   dual
CONNECT BY level <= 5;
--
CREATE TABLE items2(
    item_id NUMBER
);

INSERT INTO items2(item_id) VALUES(item_seq.NEXTVAL);
INSERT INTO items2(item_id) VALUES(item_seq.NEXTVAL);

COMMIT;

SELECT item_id FROM items2;
---
DECLARE
    v_seq NUMBER;
BEGIN
    v_seq  := item_seq.NEXTVAL;
    DBMS_OUTPUT.put_line('v_seq=' || v_seq);
END;
--Modify
ALTER SEQUENCE item_seq MAXVALUE 100;
--remving
DROP SEQUENCE item_seq;
--This statement grants a user the CREATE SEQUENCE privilege:
GRANT CREATE SEQUENCE 
TO user_name;
---
GRANT CREATE ANY SEQUENCE, 
    ALTER ANY SEQUENCE, 
    DROP ANY SEQUENCE, 
    SELECT ANY SEQUENCE 
TO user_name;
--Oracle CREATE SEQUENCE
CREATE SEQUENCE id_seq
    INCREMENT BY 10
    START WITH 10
    MINVALUE 10
    MAXVALUE 100
    CYCLE
    CACHE 2;

---https://www.oracletutorial.com/oracle-sequence/oracle-alter-sequence/
Oracle ALTER SEQUENCE
/*The ALTER SEQUENCE statement allows you to change the increment, minimum value, maximum value, cached numbers, and behavior of a sequence objec
*/
--https://www.oracletutorial.com/oracle-sequence/oracle-drop-sequence/
--Oracle DROP SEQUENCE
--The DROP SEQUENCE statement allows you to remove a sequence from the database.
 CREATE SEQUENCE no_seq;
 DROP SEQUENCE no_seq;
 










    


