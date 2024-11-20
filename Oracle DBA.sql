---Oracle Database Administration
/*
This section covers the common Oracle Database administration tasks.  
If you are an Oracle Database Administrator who wants to get grips with Oracle quickly and effectively, then this section is for you.
This Oracle Database administration section is also highly beneficial 
if you are a developer or project leader who is interested in knowing more about the Oracle Database system. It will enable you to work more closely and cooperatively with your Oracle database administrators.
*/
--Oracle Database Architecture
--https://www.oracletutorial.com/oracle-administration/oracle-database-architecture/
--Oracle Listener
--https://www.oracletutorial.com/oracle-administration/oracle-listener/
--Oracle Listener control commands
lsnctrl
--
LSNRCTL> help
LSNRCTL> status
LSNRCTL> stop
LSNRCTL> start
LSNRCTL> exit
---
lsnrctl status
--Start Oracle Database
--To start up a database instance, you use the STARTUP command:
STARTUP
STARTUP OPEN;
STARTUP stage;
STARTUP NOMOUNT;
ALTER DATABASE MOUNT;
shutdown immediate;
SELECT 
    instance_name, 
    status 
FROM 
    v$instance;

ALTER DATABASE OPEN;

SELECT 
    instance_name, 
    status 
FROM 
    v$instance;
    
---Oracle SHUTDOWN
--https://www.oracletutorial.com/oracle-administration/oracle-shutdown/
SHUTDOWN IMMEDIATE;
---Oracle Tablespace
--https://www.oracletutorial.com/oracle-administration/oracle-tablespace/
--Oracle divides a database into one or more logical storage units called tablespaces.
/*
More on Oracle Tablespaces
Create tablespace – show you how to create a new tablespace in the database.
Drop tablespace – describe the steps of removing a tablespace from the database.
Extend tablespace – how to extend the size of a tablespace.
Temporary tablespace – manipulate temporary tablespace effectively.
Tablespace group – how to use the tablespace group more effectively to optimize internal Oracle operations
*/ 
--Oracle CREATE TABLESPACE
--The CREATE TABLESPACE statement allows you to create a new tablespace. The following illustrates how to create a new tablespace named tbs1 with size 1MB:
CREATE TABLESPACE tbs1 
   DATAFILE 'tbs1_data.dbf' 
   SIZE 1m; 

SELECT 
   tablespace_name, 
   file_name, 
   bytes / 1024/ 1024  MB
FROM
   dba_data_files;
   
CREATE TABLE t1(
   id INT GENERATED ALWAYS AS IDENTITY, 
   c1 VARCHAR2(32)
) TABLESPACE users;

BEGIN
   FOR counter IN 1..10000 loop
      INSERT INTO t1(c1)
      VALUES(sys_guid());
   END loop;
END;
/
select * from t1;

SELECT 
   tablespace_name, 
   bytes / 1024 / 1024 MB
FROM 
   dba_free_space
WHERE 
   tablespace_name = 'USERS';

ALTER DATABASE
   DATAFILE 'USERS01.dbf' 
   RESIZE 100m;
CREATE TABLESPACE tbs1
   DATAFILE 'tbs1.dbf'
   SIZE 1m
   AUTOEXTEND ON 20m;
---DROP TABLESPACE
CREATE TABLESPACE tbs2
    DATAFILE 'tbs1_data.dbf'
    SIZE 10m;
    
DROP TABLESPACE tbs2;
--oracle Extend Tablespace
ALTER TABLESPACE tablespace_name
    ADD DATAFILE 'path_to_datafile'
    SIZE size
    AUTOEXTEND ON;
---https://www.oracletutorial.com/oracle-administration/oracle-extend-tablespace/
--Oracle Temporary Tablespace
--https://www.oracletutorial.com/oracle-administration/oracle-temporary-tablespace/
SELECT     property_name,     property_value 
FROM     database_properties 
WHERE     property_name='DEFAULT_TEMP_TABLESPACE';

SELECT * FROM dba_temp_free_space;

CREATE TEMPORARY TABLESPACE temp2
    TEMPFILE 'temp2.dbf'     SIZE 100m;

SELECT
    tablespace_name, 
    file_name, 
    bytes/1024/1024 MB, 
    status
FROM 
    dba_temp_files;
--https://www.oracletutorial.com/oracle-administration/oracle-tablespace-group/
--Oracle Tablespace Group
SELECT * FROM DBA_TABLESPACE_GROUPS;

---Oracle CREATE USER
---https://www.oracletutorial.com/oracle-administration/oracle-create-user/
--The CREATE USER statement allows you to create a new database user which you can use to log in to the Oracle database.
CREATE USER john IDENTIFIED BY 4321;

SELECT   username,   default_tablespace,   profile,   authentication_type
FROM  dba_users
WHERE   account_status = 'OPEN';

GRANT CREATE SESSION TO john;

CREATE USER jane IDENTIFIED BY abcd1234 
PASSWORD EXPIRE;

SELECT   username, default_tablespace, 
    profile,  authentication_type
FROM  dba_users
WHERE account_status = 'OPEN';
---Oracle GRANT
--https://www.oracletutorial.com/oracle-administration/oracle-grant/
--After creating a user, you need to decide which actions the user can do in the Oracle database.
/*The most important system privileges are:

 CREATE SESSION
 CREATE TABLE
 CREATE VIEW
 CREATE PROCEDURE
 SYSDBA
 SYSOPER
 */
/*
Here are some common object privileges:

 INSERT
 UPDATE
 DELETE
 INDEX
 EXECUTE
*/
GRANT CREATE TABLE TO john;
INSERT INTO t1(id) VALUES(10);
ALTER USER john QUOTA UNLIMITED ON USERS;

CREATE USER jack IDENTIFIED BY abcd1234 
    QUOTA UNLIMITED ON users;

GRANT CREATE SESSION TO jack;

GRANT CREATE TABLE TO john WITH ADMIN OPTION;

GRANT CREATE TABLE TO jack;

GRANT SELECT ANY TABLE TO jack;

SELECT * FROM john.t1;

CREATE TABLE t2(id INT);

INSERT INTO t2(id) VALUES(1);
INSERT INTO t2(id) VALUES(2);
INSERT INTO ot.t2(id) VALUES(3);

GRANT INSERT, UPDATE ON ot.t2 TO john;

---Oracle REVOKE
--https://www.oracletutorial.com/oracle-administration/oracle-revoke/
--The Oracle REVOKE statement revokes system and object privileges from a user. Here is the basic syntax of the Oracle REVOKE statement:
CREATE USER bob IDENTIFIED BY abcd1234;
GRANT CREATE SESSION TO bob;
GRANT CREATE TABLE TO bob;
GRANT SELECT, INSERT, UPDATE, DELETE ON ot.customers
TO bob;
--revoke
REVOKE SELECT, INSERT, UPDATE, DELETE ON ot.customers
FROM bob;

REVOKE CREATE TABLE FROM bob;
REVOKE CREATE SESSION FROM bob;

---Oracle ALTER USER.
---https://www.oracletutorial.com/oracle-administration/oracle-alter-user/
--The ALTER USER statement allows you to change the authentication or database resource characteristics of a database user.
CREATE USER dolphin IDENTIFIED BY abcd1234;

GRANT CREATE SESSION TO dolphin;

ALTER USER dolphin IDENTIFIED BY xyz123;
ALTER USER dolphin ACCOUNT LOCK;
ALTER USER dolphin ACCOUNT UNLOCK;
ALTER USER dolphin PASSWORD EXPIRE;
SELECT username, profile 
FROM  dba_users 
WHERE  username ='DOLPHIN';

CREATE PROFILE ocean LIMIT
    SESSIONS_PER_USER          UNLIMITED 
    CPU_PER_SESSION            UNLIMITED 
    CPU_PER_CALL               3000 
    CONNECT_TIME               60;
ALTER USER dolphin
PROFILE ocean;
SELECT * FROM session_roles;
CREATE ROLES rescue;

GRANT CREATE TABLE, CREATE VIEW TO rescue;
GRANT rescue TO dolphin;
SELECT * FROM session_roles;
CREATE ROLE super;

GRANT ALL PRIVILEGES TO super;
GRANT super TO dolphin;
ALTER USER dolphin DEFAULT ROLE super;
--Oracle DROP USER
--https://www.oracletutorial.com/oracle-administration/oracle-drop-user/
--The DROP USER statement allows you to delete a user from the Oracle Database. If the user has schema objects, the DROP USER statement also can remove all the user’s schema objects along with the user.
CREATE USER foo IDENTIFIED BY abcd1234;
DROP USER foo;

CREATE USER bar 
    IDENTIFIED BY abcd1234 
    QUOTA 5m ON users;

GRANT  CREATE SESSION, CREATE TABLE TO bar;

DROP USER bar; ---error
DROP USER bar CASCADE;

---https://www.oracletutorial.com/oracle-administration/oracle-grant-all-privileges-to-a-user/
--How to Grant All Privileges to a User in Oracle
--First, create a new user called super with a password by using the following CREATE USER statement:
CREATE USER super2 IDENTIFIED BY abcd1234;

GRANT ALL PRIVILEGES TO super2;
GRANT ALL PRIVILEGES to alice;
--How to Grant SELECT Object Privilege On One or More Tables to a User
--https://www.oracletutorial.com/oracle-administration/oracle-grant-select/
CREATE USER dw IDENTIFIED BY abcd1234;

GRANT CREATE SESSION TO dw;
GRANT SELECT ON customers TO dw;

CREATE PROCEDURE grant_select(
    username VARCHAR2, 
    grantee VARCHAR2)
AS   
BEGIN
    FOR r IN (
        SELECT owner, table_name 
        FROM all_tables 
        WHERE owner = username
    )
    LOOP
        EXECUTE IMMEDIATE 
            'GRANT SELECT ON '||r.owner||'.'||r.table_name||' to ' || grantee;
    END LOOP;
END; 

EXEC grant_select('OT','DW');

--How To Unlock a User in Oracle
--https://www.oracletutorial.com/oracle-administration/how-to-unlock-a-user-in-oracle/
 ALTER USER alice IDENTIFIED BY abcd1234 ACCOUNT UNLOCK;

--How to List Users in the Oracle Database
--https://www.oracletutorial.com/oracle-administration/oracle-list-users/
SELECT * FROM all_users;
SELECT * FROM dba_users;
SELECT * FROM user_users;
SELECT * FROM all_users
ORDER BY created;
SELECT * FROM DBA_USERS
ORDER BY created DESC;
--https://www.oracletutorial.com/oracle-administration/oracle-create-role/
--Oracle CREATE ROLE
--A role is a group of privileges. Instead of granting individual privileges to users, you can group related privileges into a role and grant this role to users. Roles help manage privileges more efficiently.
CREATE ROLES mdm;
--grant roles
GRANT SELECT, INSERT, UPDATE, DELETE
ON customers
TO mdm;

GRANT SELECT, INSERT, UPDATE, DELETE
ON contacts
TO mdm;

GRANT SELECT, INSERT, UPDATE, DELETE
ON products
TO mdm;

GRANT SELECT, INSERT, UPDATE, DELETE
ON product_categories
TO mdm;

GRANT SELECT, INSERT, UPDATE, DELETE
ON warehouses
TO mdm;

GRANT SELECT, INSERT, UPDATE, DELETE
ON locations
TO mdm;

GRANT SELECT, INSERT, UPDATE, DELETE
ON employees
TO mdm;

CREATE USER alice IDENTIFIED BY abcd1234;

GRANT CREATE SESSION TO alice;
SELECT * FROM ot.employees;

GRANT mdm TO alice;

CREATE ROLE order_entry IDENTIFIED BY xyz123;

GRANT SELECT, INSERT, UPDATE, DELETE
ON orders
TO order_entry;

GRANT SELECT, INSERT, UPDATE, DELETE
ON order_items
TO order_entry;
GRANT order_entry TO alice;
--Oracle SET ROLE
--https://www.oracletutorial.com/oracle-administration/oracle-set-role/
--The SET ROLE statement allows you to enable and disable roles for your current session

SET ROLE ALL;
SELECT * FROM session_roles;
CREATE USER scott IDENTIFIED BY abcd1234;

GRANT CREATE SESSION TO scott;

CREATE ROLE warehouse_staff;
CREATE ROLE warehouse_manager IDENTIFIED BY xyz123;
GRANT SELECT, INSERT, UPDATE, DELETE
ON inventories
TO warehouse_staff;

GRANT SELECT, INSERT, UPDATE, DELETE
ON warehouses
TO warehouse_manager;

GRANT warehouse_staff to warehouse_manager;

GRANT warehouse_manager TO scott;
SET ROLE warehouse_manager IDENTIFIED BY xyz123;
SELECT * FROM session_roles;
--disable all roles
SET ROLE NONE;
--Oracle ALTER ROLE
--https://www.oracletutorial.com/oracle-administration/oracle-alter-role/
--The ALTER ROLE statement allows you to modify the authorization needed to enable a rol
CREATE ROLE db_designer IDENTIFIED BY abcd1234;
GRANT CREATE TABLE,CREATE VIEW TO db_designer;
CREATE USER michael IDENTIFIED BY xyz123;
GRANT db_designer, connect TO michael;

SELECT * FROM dba_role_privs 
WHERE grantee = 'MICHAEL';

--https://www.oracletutorial.com/oracle-administration/oracle-drop-role/
--Oracle DROP ROLE
---The DROP ROLE statement allows you to remove a role from the database.
CREATE ROLE developer;
SELECT * from dba_roles 
WHERE role = 'DEVELOPER';

CREATE ROLE auditor;
GRANT SELECT ON orders TO auditor;
--create new user
CREATE USER audi IDENTIFIED BY Abcd1234;
GRANT CREATE SESSION TO auditor;
GRANT auditor TO audi;
--https://www.oracletutorial.com/oracle-administration/oracle-create-profile/
--Oracle CREATE PROFILE
--A user profile is a set of limits on the database resources and the user password. Once you assign a profile to a user, then that user cannot exceed the database resource and password limits.
SELECT  username,   profile
FROM   dba_users
WHERE  username = 'OT';

SELECT  * FROM   dba_profiles
WHERE   PROFILE = 'DEFAULT'
ORDER BY  resource_type, resource_name;
--create user profile
CREATE PROFILE CRM_USERS LIMIT 
    SESSIONS_PER_USER          UNLIMITED
    CPU_PER_SESSION            UNLIMITED 
    CPU_PER_CALL               3000 
    CONNECT_TIME               15;

CREATE USER crm IDENTIFIED BY abcd1234
PROFILE crm_users;
--
SELECT   username,  profile
FROM    dba_users
WHERE    username = 'CRM';
--First, create a new profile called erp_users with password limits:
CREATE PROFILE erp_users LIMIT
    FAILED_LOGIN_ATTEMPTS 5
    PASSWORD_LIFE_TIME 90;
    
CREATE USER sap IDENTIFIED BY abcd1234
PROFILE erp_users;
--https://www.oracletutorial.com/oracle-administration/oracle-alter-profile/
--Oracle ALTER PROFILE
--The ALTER PROFILE statement allows you to add, change, or delete a resource limit or password management parameter in a user profile.
--create new profile
CREATE PROFILE super LIMIT
FAILED_LOGIN_ATTEMPTS UNLIMITED;
CREATE USER joe IDENTIFIED BY abcd1234;

GRANT connect, super TO joe;

ALTER PROFILE super LIMIT
FAILED_LOGIN_ATTEMPTS 3
PASSWORD_LOCK_TIME 1;
ALTER PROFILE super LIMIT 
SESSIONS_PER_USER 5; 
--https://www.oracletutorial.com/oracle-administration/oracle-drop-profile/
--Oracle DROP PROFILE
--The DROP PROFILE statement allows you to delete a profile from the Oracle database. Here is the basic syntax of the DROP PROFILE statement:
CREATE PROFILE mobile_app LIMIT 
PASSWORD_LIFE_TIME UNLIMITED;

--delete
DROP PROFILE mobile_app;

CREATE PROFILE db_manager LIMIT
    FAILED_LOGIN_ATTEMPTS 5
    PASSWORD_LIFE_TIME 1;
CREATE USER peter IDENTIFIED BY abcd1234
    PROFILE db_manager;
 --https://www.oracletutorial.com/oracle-administration/oracle-show-tables/
 --Oracle Show Tables
SELECT table_name
FROM user_tables
ORDER BY table_name;
--
SELECT table_name
FROM all_tables
ORDER BY table_name;

SELECT *
FROM all_tables
WHERE OWNER = 'OT'
ORDER BY table_name;

SELECT table_name 
FROM dba_tables;
--https://www.oracletutorial.com/oracle-administration/oracle-external-table/
--Oracle External Table


---Oracle SQL*Loader
--https://www.oracletutorial.com/oracle-administration/oracle-sqlloader/
--SQL*Loader allows you to load data from an external file into a table in the database. It can parse many delimited file formats such as CSV, tab-delimited, and pipe-delimited.
CREATE TABLE emails(
email_id NUMBER PRIMARY KEY,
email VARCHAR2(150) NOT NULL);
--https://www.oracletutorial.com/oracle-administration/oracle-expdp/
--Oracle expdp
--Oracle Data Pump Export is a built-in utility program for unloading data and metadata into a set of dump files. The dump file set then can be imported by the Data Pump Import utility on the same or another Oracle Database system
CREATE DIRECTORY ot_external AS 'C:\export';
--https://www.oracletutorial.com/oracle-administration/oracle-impdp/
--Oracle impdp
--The Data Pump Import program is a tool that allows you to load an export dump file set into a target Oracle database system. The Data Pump Import utility comes with the Oracle Installation by default.
--How To Fix the “ORACLE initialization or shutdown in progress” Error
--https://www.oracletutorial.com/oracle-administration/fix-oracle-initialization-shutdown-progress-error/
--Sometimes, you may encounter the following error when you connect to an Oracle pluggable database in Oracle Database 12c:
---First, launch the SQL*Plus program and login to the database instance as a SYSDBA user:
--Second, issue the following statement to check the status of the current instance:
select status, database_status from v$instance;
alter database open;
/*
The instance status is open and available to all users for normal operations.
Now, you should be able to connect to the OT pluggable database without any issue.
*/
--https://www.oracletutorial.com/oracle-administration/oracle-create-database-link/
--Oracle CREATE DATABASE LINK
--A database link is a connection from the Oracle database to another remote database. The remote database can be an Oracle Database or any ODBC-compliant database such as SQL Server or MySQL.



















       


