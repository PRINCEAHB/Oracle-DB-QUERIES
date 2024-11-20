set SERVEROUTPUT on;

BEGIN
   DBMS_OUTPUT.PUT_LINE('Hello, PL/SQL World!');
END;
/

DECLARE
   message VARCHAR2(100);  -- Declaring a variable of type VARCHAR2
BEGIN
   message := 'Learning PL/SQL is fun!';  -- Assigning a value to the variable
   DBMS_OUTPUT.PUT_LINE(message);  -- Printing the value of the variable
END;
/

DECLARE
   v_first_name VARCHAR2(50);  -- Declare a variable to store the employee's first name
BEGIN
   SELECT first_name INTO v_first_name
   FROM EMPLOYEES
   WHERE employee_id = 102;  -- Fetching the employee whose ID is 100

   DBMS_OUTPUT.PUT_LINE('Employee Name: ' || v_first_name);  -- Display the result
END;
/

SELECT * FROM ALL_OBJECTS  WHERE OBJECT_TYPE = 'TABLE' AND OWNER = 'HR';

select * from EMPLOYEES;

DECLARE
   v_first_name VARCHAR2(50);
   v_last_name VARCHAR2(50);
   v_salary NUMBER(10, 2);
BEGIN
   SELECT first_name, last_name, salary INTO v_first_name, v_last_name, v_salary
   FROM employees
   WHERE employee_id = 105;

   DBMS_OUTPUT.PUT_LINE('Name: ' || v_first_name || ' ' || v_last_name);
   DBMS_OUTPUT.PUT_LINE('Salary: ' || v_salary);
END;
/

DECLARE
   CURSOR emp_cursor IS
      SELECT employee_id, first_name, last_name
      FROM employees
      WHERE department_id = 60;  -- Define a cursor to select employees from department 60

   v_employee_id employees.employee_id%TYPE;
   v_first_name employees.first_name%TYPE;
   v_last_name employees.last_name%TYPE;
BEGIN
   OPEN emp_cursor;  -- Open the cursor

   LOOP
      FETCH emp_cursor INTO v_employee_id, v_first_name, v_last_name;  -- Fetch each row
      EXIT WHEN emp_cursor%NOTFOUND;  -- Exit loop when no more rows

      DBMS_OUTPUT.PUT_LINE('ID: ' || v_employee_id || ', Name: ' || v_first_name || ' ' || v_last_name);  -- Display the result
   END LOOP;

   CLOSE emp_cursor;  -- Close the cursor
END;
/

CREATE TABLE audits (
      audit_id         NUMBER ,
      table_name       VARCHAR2(255),
      transaction_name VARCHAR2(10),
      by_user          VARCHAR2(30),
      transaction_date DATE
);

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
---
select * from hr.CUSTOMERS;

SELECT * FROM hr.audits;

DELETE FROM customers
WHERE customer_id = 6;

UPDATE
   hr.customers
SET
   salary = 80000
WHERE
   customer_id =10;




