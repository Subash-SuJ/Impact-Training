--Employees Table

CREATE TABLE employees
  (
    EMPLOYEE_ID NUMBER PRIMARY KEY,
    FIRST_NAME VARCHAR( 255 ) NOT NULL,
    LAST_NAME  VARCHAR( 255 ) NOT NULL,
    EMAIL      VARCHAR( 255 ) NOT NULL,
    PHONE      VARCHAR( 50 ) NOT NULL ,
    HIRE_DATE  DATE NOT NULL          ,
    MANAGER_ID NUMBER( 12, 0 )        , -- fk
    JOB_TITLE  VARCHAR( 255 ) NOT NULL,
    SALARY NUMBER(20,5),
    CONSTRAINT fk_employees_manager 
        FOREIGN KEY( manager_id )
        REFERENCES employees( employee_id )
        ON DELETE CASCADE
  );

-- Add Salary column to employees table

ALTER TABLE employees ADD COLUMN SALARY NUMBER(10,5);

--Customers Table

CREATE TABLE customers
  (
    CUSTOMER_ID NUMBER PRIMARY KEY,
    NAME         VARCHAR2( 255 ) NOT NULL,
    ADDRESS      VARCHAR2( 255 )         ,
    WEBSITE      VARCHAR2( 255 )         ,
    CREDIT_LIMIT NUMBER( 8, 2 )
  );

-- Contacts Table
CREATE TABLE contacts
  (
    contact_id NUMBER PRIMARY KEY,
    first_name  VARCHAR2( 255 ) NOT NULL,
    last_name   VARCHAR2( 255 ) NOT NULL,
    email       VARCHAR2( 255 ) NOT NULL,
    phone       VARCHAR2( 20 )          ,
    customer_id NUMBER                  ,
    CONSTRAINT fk_contacts_customers 
      FOREIGN KEY( customer_id )
      REFERENCES customers( customer_id ) 
      ON DELETE CASCADE
  );
  
-- Orders Table

CREATE TABLE orders
  (
    order_id NUMBER PRIMARY KEY,
    customer_id NUMBER( 6, 0 ) NOT NULL, -- fk
    status      VARCHAR( 20 ) NOT NULL ,
    salesman_id NUMBER( 6, 0 )         , -- fk
    order_date  DATE NOT NULL          ,
    CONSTRAINT fk_orders_customers 
      FOREIGN KEY( customer_id )
      REFERENCES customers( customer_id )
      ON DELETE CASCADE,
    CONSTRAINT fk_orders_employees 
      FOREIGN KEY( salesman_id )
      REFERENCES employees( employee_id ) 
      ON DELETE SET NULL
  );
-- Product_categories Table
CREATE TABLE product_categories
  (
    category_id NUMBER PRIMARY KEY,
    category_name VARCHAR2( 255 ) NOT NULL
  );
-- Products Table

CREATE TABLE products
  (
    product_id NUMBER PRIMARY KEY,
    product_name  VARCHAR2( 255 ) NOT NULL,
    description   VARCHAR2( 2000 )        ,
    standard_cost NUMBER( 9, 2 )          ,
    list_price    NUMBER( 9, 2 )          ,
    category_id   NUMBER NOT NULL         ,
    CONSTRAINT fk_products_categories 
      FOREIGN KEY( category_id )
      REFERENCES product_categories( category_id ) 
      ON DELETE CASCADE
  );
  
--Order_Items Table

CREATE TABLE order_items
  (
    order_id   NUMBER( 12, 0 )                                , -- fk
    item_id    NUMBER( 12, 0 )                                ,
    product_id NUMBER( 12, 0 ) NOT NULL                       , -- fk
    quantity   NUMBER( 8, 2 ) NOT NULL                        ,
    unit_price NUMBER( 8, 2 ) NOT NULL                        ,
    CONSTRAINT pk_order_items 
      PRIMARY KEY( order_id, item_id ),
    CONSTRAINT fk_order_items_products 
      FOREIGN KEY( product_id )
      REFERENCES products( product_id ) 
      ON DELETE CASCADE,
    CONSTRAINT fk_order_items_orders 
      FOREIGN KEY( order_id )
      REFERENCES orders( order_id ) 
      ON DELETE CASCADE
  );
  
-- Regions Table

CREATE TABLE regions
  (
    region_id NUMBER PRIMARY KEY,
    region_name VARCHAR2( 50 ) NOT NULL
  );
  
-- Countries Table
CREATE TABLE countries
  (
    country_id   CHAR( 2 ) PRIMARY KEY  ,
    country_name VARCHAR2( 40 ) NOT NULL,
    region_id    NUMBER                 , -- fk
    CONSTRAINT fk_countries_regions FOREIGN KEY( region_id )
      REFERENCES regions( region_id ) 
      ON DELETE CASCADE
  );
  
-- Locations Table
CREATE TABLE locations
  (
    location_id NUMBER PRIMARY KEY      ,
    address     VARCHAR2( 255 ) NOT NULL,
    postal_code VARCHAR2( 20 )          ,
    city        VARCHAR2( 50 )          ,
    state       VARCHAR2( 50 )          ,
    country_id  CHAR( 2 )               , -- fk
    CONSTRAINT fk_locations_countries 
      FOREIGN KEY( country_id )
      REFERENCES countries( country_id ) 
      ON DELETE CASCADE
  );

-- Warehouses Table
CREATE TABLE warehouses
  (
    warehouse_id NUMBER PRIMARY KEY,
    warehouse_name VARCHAR( 255 ) ,
    location_id    NUMBER( 12, 0 ), -- fk
    CONSTRAINT fk_warehouses_locations 
      FOREIGN KEY( location_id )
      REFERENCES locations( location_id ) 
      ON DELETE CASCADE
  );

-- Inventories Table

CREATE TABLE inventories
  (
    product_id   NUMBER( 12, 0 )        , -- fk
    warehouse_id NUMBER( 12, 0 )        , -- fk
    quantity     NUMBER( 8, 0 ) NOT NULL,
    CONSTRAINT pk_inventories 
      PRIMARY KEY( product_id, warehouse_id ),
    CONSTRAINT fk_inventories_products 
      FOREIGN KEY( product_id )
      REFERENCES products( product_id ) 
      ON DELETE CASCADE,
    CONSTRAINT fk_inventories_warehouses 
      FOREIGN KEY( warehouse_id )
      REFERENCES warehouses( warehouse_id ) 
      ON DELETE CASCADE
  );
  
  -- UPTO THIS TABLE CREATION COMPLETED
  
REM INSERTING into REGIONS
SET DEFINE OFF;
Insert into REGIONS (REGION_ID,REGION_NAME) values (1,'Europe');
Insert into REGIONS (REGION_ID,REGION_NAME) values (2,'Americas');
Insert into REGIONS (REGION_ID,REGION_NAME) values (3,'Asia');
Insert into REGIONS (REGION_ID,REGION_NAME) values (4,'Middle East and Africa');
  
REM INSERTING into COUNTRIES
SET DEFINE OFF;
Insert into COUNTRIES (COUNTRY_ID,COUNTRY_NAME,REGION_ID) values ('AR','Argentina',2);
Insert into COUNTRIES (COUNTRY_ID,COUNTRY_NAME,REGION_ID) values ('AU','Australia',3);
Insert into COUNTRIES (COUNTRY_ID,COUNTRY_NAME,REGION_ID) values ('BE','Belgium',1);
Insert into COUNTRIES (COUNTRY_ID,COUNTRY_NAME,REGION_ID) values ('BR','Brazil',2);
Insert into COUNTRIES (COUNTRY_ID,COUNTRY_NAME,REGION_ID) values ('CA','Canada',2);
Insert into COUNTRIES (COUNTRY_ID,COUNTRY_NAME,REGION_ID) values ('CH','Switzerland',1);
Insert into COUNTRIES (COUNTRY_ID,COUNTRY_NAME,REGION_ID) values ('CN','China',3);
Insert into COUNTRIES (COUNTRY_ID,COUNTRY_NAME,REGION_ID) values ('DE','Germany',1);
Insert into COUNTRIES (COUNTRY_ID,COUNTRY_NAME,REGION_ID) values ('DK','Denmark',1);
Insert into COUNTRIES (COUNTRY_ID,COUNTRY_NAME,REGION_ID) values ('EG','Egypt',4);
Insert into COUNTRIES (COUNTRY_ID,COUNTRY_NAME,REGION_ID) values ('FR','France',1);
Insert into COUNTRIES (COUNTRY_ID,COUNTRY_NAME,REGION_ID) values ('IL','Israel',4);
Insert into COUNTRIES (COUNTRY_ID,COUNTRY_NAME,REGION_ID) values ('IN','India',3);
Insert into COUNTRIES (COUNTRY_ID,COUNTRY_NAME,REGION_ID) values ('IT','Italy',1);
Insert into COUNTRIES (COUNTRY_ID,COUNTRY_NAME,REGION_ID) values ('JP','Japan',3);
Insert into COUNTRIES (COUNTRY_ID,COUNTRY_NAME,REGION_ID) values ('KW','Kuwait',4);
Insert into COUNTRIES (COUNTRY_ID,COUNTRY_NAME,REGION_ID) values ('ML','Malaysia',3);
Insert into COUNTRIES (COUNTRY_ID,COUNTRY_NAME,REGION_ID) values ('MX','Mexico',2);
Insert into COUNTRIES (COUNTRY_ID,COUNTRY_NAME,REGION_ID) values ('NG','Nigeria',4);
Insert into COUNTRIES (COUNTRY_ID,COUNTRY_NAME,REGION_ID) values ('NL','Netherlands',1);
Insert into COUNTRIES (COUNTRY_ID,COUNTRY_NAME,REGION_ID) values ('SG','Singapore',3);
Insert into COUNTRIES (COUNTRY_ID,COUNTRY_NAME,REGION_ID) values ('UK','United Kingdom',1);
Insert into COUNTRIES (COUNTRY_ID,COUNTRY_NAME,REGION_ID) values ('US','United States of America',2);
Insert into COUNTRIES (COUNTRY_ID,COUNTRY_NAME,REGION_ID) values ('ZM','Zambia',4);
Insert into COUNTRIES (COUNTRY_ID,COUNTRY_NAME,REGION_ID) values ('ZW','Zimbabwe',4);
  
REM INSERTING into LOCATIONS
SET DEFINE OFF;
Insert into LOCATIONS (LOCATION_ID,ADDRESS,POSTAL_CODE,CITY,STATE,COUNTRY_ID) values (1,'1297 Via Cola di Rie','00989','Roma',null,'IT');
Insert into LOCATIONS (LOCATION_ID,ADDRESS,POSTAL_CODE,CITY,STATE,COUNTRY_ID) values (2,'93091 Calle della Testa','10934','Venice',null,'IT');
Insert into LOCATIONS (LOCATION_ID,ADDRESS,POSTAL_CODE,CITY,STATE,COUNTRY_ID) values (3,'2017 Shinjuku-ku','1689','Tokyo','Tokyo Prefecture','JP');
Insert into LOCATIONS (LOCATION_ID,ADDRESS,POSTAL_CODE,CITY,STATE,COUNTRY_ID) values (4,'9450 Kamiya-cho','6823','Hiroshima',null,'JP');
Insert into LOCATIONS (LOCATION_ID,ADDRESS,POSTAL_CODE,CITY,STATE,COUNTRY_ID) values (5,'2014 Jabberwocky Rd','26192','Southlake','Texas','US');
Insert into LOCATIONS (LOCATION_ID,ADDRESS,POSTAL_CODE,CITY,STATE,COUNTRY_ID) values (6,'2011 Interiors Blvd','99236','South San Francisco','California','US');
Insert into LOCATIONS (LOCATION_ID,ADDRESS,POSTAL_CODE,CITY,STATE,COUNTRY_ID) values (7,'2007 Zagora St','50090','South Brunswick','New Jersey','US');
Insert into LOCATIONS (LOCATION_ID,ADDRESS,POSTAL_CODE,CITY,STATE,COUNTRY_ID) values (8,'2004 Charade Rd','98199','Seattle','Washington','US');
Insert into LOCATIONS (LOCATION_ID,ADDRESS,POSTAL_CODE,CITY,STATE,COUNTRY_ID) values (9,'147 Spadina Ave','M5V 2L7','Toronto','Ontario','CA');
Insert into LOCATIONS (LOCATION_ID,ADDRESS,POSTAL_CODE,CITY,STATE,COUNTRY_ID) values (10,'6092 Boxwood St','YSW 9T2','Whitehorse','Yukon','CA');
Insert into LOCATIONS (LOCATION_ID,ADDRESS,POSTAL_CODE,CITY,STATE,COUNTRY_ID) values (11,'40-5-12 Laogianggen','190518','Beijing',null,'CN');
Insert into LOCATIONS (LOCATION_ID,ADDRESS,POSTAL_CODE,CITY,STATE,COUNTRY_ID) values (12,'1298 Vileparle (E)','490231','Bombay','Maharashtra','IN');
Insert into LOCATIONS (LOCATION_ID,ADDRESS,POSTAL_CODE,CITY,STATE,COUNTRY_ID) values (13,'12-98 Victoria Street','2901','Sydney','New South Wales','AU');
Insert into LOCATIONS (LOCATION_ID,ADDRESS,POSTAL_CODE,CITY,STATE,COUNTRY_ID) values (14,'198 Clementi North','540198','Singapore',null,'SG');
Insert into LOCATIONS (LOCATION_ID,ADDRESS,POSTAL_CODE,CITY,STATE,COUNTRY_ID) values (15,'8204 Arthur St',null,'London',null,'UK');
Insert into LOCATIONS (LOCATION_ID,ADDRESS,POSTAL_CODE,CITY,STATE,COUNTRY_ID) values (16,'Magdalen Centre, The Oxford Science Park','OX9 9ZB','Oxford','Oxford','UK');
Insert into LOCATIONS (LOCATION_ID,ADDRESS,POSTAL_CODE,CITY,STATE,COUNTRY_ID) values (17,'9702 Chester Road','09629850293','Stretford','Manchester','UK');
Insert into LOCATIONS (LOCATION_ID,ADDRESS,POSTAL_CODE,CITY,STATE,COUNTRY_ID) values (18,'Schwanthalerstr. 7031','80925','Munich','Bavaria','DE');
Insert into LOCATIONS (LOCATION_ID,ADDRESS,POSTAL_CODE,CITY,STATE,COUNTRY_ID) values (19,'Rua Frei Caneca 1360 ','01307-002','Sao Paulo','Sao Paulo','BR');
Insert into LOCATIONS (LOCATION_ID,ADDRESS,POSTAL_CODE,CITY,STATE,COUNTRY_ID) values (20,'20 Rue des Corps-Saints','1730','Geneva','Geneve','CH');
Insert into LOCATIONS (LOCATION_ID,ADDRESS,POSTAL_CODE,CITY,STATE,COUNTRY_ID) values (21,'Murtenstrasse 921','3095','Bern','BE','CH');
Insert into LOCATIONS (LOCATION_ID,ADDRESS,POSTAL_CODE,CITY,STATE,COUNTRY_ID) values (22,'Pieter Breughelstraat 837','3029SK','Utrecht','Utrecht','NL');
Insert into LOCATIONS (LOCATION_ID,ADDRESS,POSTAL_CODE,CITY,STATE,COUNTRY_ID) values (23,'Mariano Escobedo 9991','11932','Mexico City','Distrito Federal,','MX');

REM INSERTING into WAREHOUSES
SET DEFINE OFF;
Insert into WAREHOUSES (WAREHOUSE_ID,WAREHOUSE_NAME,LOCATION_ID) values (1,'Southlake, Texas',5);
Insert into WAREHOUSES (WAREHOUSE_ID,WAREHOUSE_NAME,LOCATION_ID) values (2,'San Francisco',6);
Insert into WAREHOUSES (WAREHOUSE_ID,WAREHOUSE_NAME,LOCATION_ID) values (3,'New Jersey',7);
Insert into WAREHOUSES (WAREHOUSE_ID,WAREHOUSE_NAME,LOCATION_ID) values (4,'Seattle, Washington',8);
Insert into WAREHOUSES (WAREHOUSE_ID,WAREHOUSE_NAME,LOCATION_ID) values (5,'Toronto',9);
Insert into WAREHOUSES (WAREHOUSE_ID,WAREHOUSE_NAME,LOCATION_ID) values (6,'Sydney',13);
Insert into WAREHOUSES (WAREHOUSE_ID,WAREHOUSE_NAME,LOCATION_ID) values (7,'Mexico City',23);
Insert into WAREHOUSES (WAREHOUSE_ID,WAREHOUSE_NAME,LOCATION_ID) values (8,'Beijing',11);
Insert into WAREHOUSES (WAREHOUSE_ID,WAREHOUSE_NAME,LOCATION_ID) values (9,'Bombay',12);

REM INSERTING into EMPLOYEES
SET DEFINE OFF;
Insert into EMPLOYEES (EMPLOYEE_ID,FIRST_NAME,LAST_NAME,EMAIL,PHONE,HIRE_DATE,MANAGER_ID,JOB_TITLE,SALARY) values (1,'Tommy','Bailey','tommy.bailey@example.com','515.123.4567',to_date('17-JUN-16','DD-MON-RR'),null,'President',10000);
Insert into EMPLOYEES (EMPLOYEE_ID,FIRST_NAME,LAST_NAME,EMAIL,PHONE,HIRE_DATE,MANAGER_ID,JOB_TITLE,SALARY) values (2,'Blake','Cooper','blake.cooper@example.com','515.123.4569',to_date('13-JAN-16','DD-MON-RR'),1,'Administration Vice President',9500);
Insert into EMPLOYEES (EMPLOYEE_ID,FIRST_NAME,LAST_NAME,EMAIL,PHONE,HIRE_DATE,MANAGER_ID,JOB_TITLE,SALARY) values (3,'Jude','Rivera','jude.rivera@example.com','515.123.4568',to_date('21-SEP-16','DD-MON-RR'),1,'Administration Vice President',9700);
Insert into EMPLOYEES (EMPLOYEE_ID,FIRST_NAME,LAST_NAME,EMAIL,PHONE,HIRE_DATE,MANAGER_ID,JOB_TITLE,SALARY) values (4,'Louie','Richardson','louie.richardson@example.com','590.423.4567',to_date('03-JAN-16','DD-MON-RR'),3,'Programmer',9800);
Insert into EMPLOYEES (EMPLOYEE_ID,FIRST_NAME,LAST_NAME,EMAIL,PHONE,HIRE_DATE,MANAGER_ID,JOB_TITLE,SALARY) values (5,'Nathan','Cox','nathan.cox@example.com','590.423.4568',to_date('21-MAY-16','DD-MON-RR'),4,'Programmer',8700);
Insert into EMPLOYEES (EMPLOYEE_ID,FIRST_NAME,LAST_NAME,EMAIL,PHONE,HIRE_DATE,MANAGER_ID,JOB_TITLE,SALARY) values (6,'Bobby','Torres','bobby.torres@example.com','590.423.5567',to_date('07-FEB-16','DD-MON-RR'),4,'Programmer',9600);
Insert into EMPLOYEES (EMPLOYEE_ID,FIRST_NAME,LAST_NAME,EMAIL,PHONE,HIRE_DATE,MANAGER_ID,JOB_TITLE,SALARY) values (7,'Charles','Ward','charles.ward@example.com','590.423.4560',to_date('05-FEB-16','DD-MON-RR'),4,'Programmer',8260);
Insert into EMPLOYEES (EMPLOYEE_ID,FIRST_NAME,LAST_NAME,EMAIL,PHONE,HIRE_DATE,MANAGER_ID,JOB_TITLE,SALARY) values (8,'Gabriel','Howard','gabriel.howard@example.com','590.423.4569',to_date('25-JUN-16','DD-MON-RR'),4,'Programmer',9852);
Insert into EMPLOYEES (EMPLOYEE_ID,FIRST_NAME,LAST_NAME,EMAIL,PHONE,HIRE_DATE,MANAGER_ID,JOB_TITLE,SALARY) values (11,'Tyler','Ramirez','tyler.ramirez@example.com','515.124.4269',to_date('28-SEP-16','DD-MON-RR'),9,'Accountant',6520);
Insert into EMPLOYEES (EMPLOYEE_ID,FIRST_NAME,LAST_NAME,EMAIL,PHONE,HIRE_DATE,MANAGER_ID,JOB_TITLE,SALARY) values (10,'Ryan','Gray','ryan.gray@example.com','515.124.4169',to_date('16-AUG-16','DD-MON-RR'),9,'Accountant',9630);
Insert into EMPLOYEES (EMPLOYEE_ID,FIRST_NAME,LAST_NAME,EMAIL,PHONE,HIRE_DATE,MANAGER_ID,JOB_TITLE,SALARY) values (14,'Elliot','Brooks','elliot.brooks@example.com','515.124.4567',to_date('07-DEC-16','DD-MON-RR'),9,'Accountant',9630);
Insert into EMPLOYEES (EMPLOYEE_ID,FIRST_NAME,LAST_NAME,EMAIL,PHONE,HIRE_DATE,MANAGER_ID,JOB_TITLE,SALARY) values (12,'Elliott','James','elliott.james@example.com','515.124.4369',to_date('30-SEP-16','DD-MON-RR'),9,'Accountant',9823);
Insert into EMPLOYEES (EMPLOYEE_ID,FIRST_NAME,LAST_NAME,EMAIL,PHONE,HIRE_DATE,MANAGER_ID,JOB_TITLE,SALARY) values (13,'Albert','Watson','albert.watson@example.com','515.124.4469',to_date('07-MAR-16','DD-MON-RR'),9,'Accountant',9530);
Insert into EMPLOYEES (EMPLOYEE_ID,FIRST_NAME,LAST_NAME,EMAIL,PHONE,HIRE_DATE,MANAGER_ID,JOB_TITLE,SALARY) values (9,'Mohammad','Peterson','mohammad.peterson@example.com','515.124.4569',to_date('17-AUG-16','DD-MON-RR'),2,'Finance Manager',10000);
Insert into EMPLOYEES (EMPLOYEE_ID,FIRST_NAME,LAST_NAME,EMAIL,PHONE,HIRE_DATE,MANAGER_ID,JOB_TITLE,SALARY) values (15,'Frederick','Price','frederick.price@example.com','515.127.4563',to_date('24-DEC-16','DD-MON-RR'),15,'Purchasing Clerk',8530);
Insert into EMPLOYEES (EMPLOYEE_ID,FIRST_NAME,LAST_NAME,EMAIL,PHONE,HIRE_DATE,MANAGER_ID,JOB_TITLE,SALARY) values (16,'Alex','Sanders','alex.sanders@example.com','515.127.4562',to_date('18-MAY-16','DD-MON-RR'),15,'Purchasing Clerk',8530);
Insert into EMPLOYEES (EMPLOYEE_ID,FIRST_NAME,LAST_NAME,EMAIL,PHONE,HIRE_DATE,MANAGER_ID,JOB_TITLE,SALARY) values (17,'Ollie','Bennett','ollie.bennett@example.com','515.127.4564',to_date('24-JUL-16','DD-MON-RR'),15,'Purchasing Clerk',8530);
Insert into EMPLOYEES (EMPLOYEE_ID,FIRST_NAME,LAST_NAME,EMAIL,PHONE,HIRE_DATE,MANAGER_ID,JOB_TITLE,SALARY) values (18,'Louis','Wood','louis.wood@example.com','515.127.4565',to_date('15-NOV-16','DD-MON-RR'),15,'Purchasing Clerk',8530);
Insert into EMPLOYEES (EMPLOYEE_ID,FIRST_NAME,LAST_NAME,EMAIL,PHONE,HIRE_DATE,MANAGER_ID,JOB_TITLE,SALARY) values (19,'Dexter','Barnes','dexter.barnes@example.com','515.127.4566',to_date('10-AUG-16','DD-MON-RR'),15,'Purchasing Clerk',8530);
Insert into EMPLOYEES (EMPLOYEE_ID,FIRST_NAME,LAST_NAME,EMAIL,PHONE,HIRE_DATE,MANAGER_ID,JOB_TITLE,SALARY) values (20,'Rory','Kelly','rory.kelly@example.com','515.127.4561',to_date('07-DEC-16','DD-MON-RR'),1,'Purchasing Manager',8530);
Insert into EMPLOYEES (EMPLOYEE_ID,FIRST_NAME,LAST_NAME,EMAIL,PHONE,HIRE_DATE,MANAGER_ID,JOB_TITLE,SALARY) values (25,'Ronnie','Perry','ronnie.perry@example.com','650.123.5234',to_date('16-NOV-16','DD-MON-RR'),1,'Stock Manager',9666);
Insert into EMPLOYEES (EMPLOYEE_ID,FIRST_NAME,LAST_NAME,EMAIL,PHONE,HIRE_DATE,MANAGER_ID,JOB_TITLE,SALARY) values (24,'Callum','Jenkins','callum.jenkins@example.com','650.123.4234',to_date('10-OCT-16','DD-MON-RR'),1,'Stock Manager',9666);
Insert into EMPLOYEES (EMPLOYEE_ID,FIRST_NAME,LAST_NAME,EMAIL,PHONE,HIRE_DATE,MANAGER_ID,JOB_TITLE,SALARY) values (23,'Jackson','Coleman','jackson.coleman@example.com','650.123.3234',to_date('01-MAY-16','DD-MON-RR'),1,'Stock Manager',9666);
Insert into EMPLOYEES (EMPLOYEE_ID,FIRST_NAME,LAST_NAME,EMAIL,PHONE,HIRE_DATE,MANAGER_ID,JOB_TITLE,SALARY) values (22,'Liam','Henderson','liam.henderson@example.com','650.123.2234',to_date('10-APR-16','DD-MON-RR'),1,'Stock Manager',9666);
Insert into EMPLOYEES (EMPLOYEE_ID,FIRST_NAME,LAST_NAME,EMAIL,PHONE,HIRE_DATE,MANAGER_ID,JOB_TITLE,SALARY) values (21,'Jaxon','Ross','jaxon.ross@example.com','650.123.1234',to_date('18-JUL-16','DD-MON-RR'),1,'Stock Manager',9666);
Insert into EMPLOYEES (EMPLOYEE_ID,FIRST_NAME,LAST_NAME,EMAIL,PHONE,HIRE_DATE,MANAGER_ID,JOB_TITLE,SALARY) values (33,'Reggie','Simmons','reggie.simmons@example.com','650.124.8234',to_date('10-APR-16','DD-MON-RR'),22,'Stock Clerk',6900);
Insert into EMPLOYEES (EMPLOYEE_ID,FIRST_NAME,LAST_NAME,EMAIL,PHONE,HIRE_DATE,MANAGER_ID,JOB_TITLE,SALARY) values (44,'Emily','Hamilton','emily.hamilton@example.com','650.121.2874',to_date('15-MAR-16','DD-MON-RR'),25,'Stock Clerk',6900);
Insert into EMPLOYEES (EMPLOYEE_ID,FIRST_NAME,LAST_NAME,EMAIL,PHONE,HIRE_DATE,MANAGER_ID,JOB_TITLE,SALARY) values (43,'Olivia','Ford','olivia.ford@example.com','650.121.2994',to_date('29-JAN-16','DD-MON-RR'),25,'Stock Clerk',6900);
Insert into EMPLOYEES (EMPLOYEE_ID,FIRST_NAME,LAST_NAME,EMAIL,PHONE,HIRE_DATE,MANAGER_ID,JOB_TITLE,SALARY) values (42,'Amelia','Myers','amelia.myers@example.com','650.121.8009',to_date('17-OCT-16','DD-MON-RR'),25,'Stock Clerk',6900);
Insert into EMPLOYEES (EMPLOYEE_ID,FIRST_NAME,LAST_NAME,EMAIL,PHONE,HIRE_DATE,MANAGER_ID,JOB_TITLE,SALARY) values (41,'Connor','Hayes','connor.hayes@example.com','650.121.1834',to_date('06-APR-16','DD-MON-RR'),24,'Stock Clerk',6900);
Insert into EMPLOYEES (EMPLOYEE_ID,FIRST_NAME,LAST_NAME,EMAIL,PHONE,HIRE_DATE,MANAGER_ID,JOB_TITLE,SALARY) values (26,'Leon','Powell','leon.powell@example.com','650.124.1214',to_date('16-JUL-16','DD-MON-RR'),21,'Stock Clerk',6900);
Insert into EMPLOYEES (EMPLOYEE_ID,FIRST_NAME,LAST_NAME,EMAIL,PHONE,HIRE_DATE,MANAGER_ID,JOB_TITLE,SALARY) values (27,'Kai','Long','kai.long@example.com','650.124.1224',to_date('28-SEP-16','DD-MON-RR'),21,'Stock Clerk',6900);
Insert into EMPLOYEES (EMPLOYEE_ID,FIRST_NAME,LAST_NAME,EMAIL,PHONE,HIRE_DATE,MANAGER_ID,JOB_TITLE,SALARY) values (28,'Aaron','Patterson','aaron.patterson@example.com','650.124.1334',to_date('14-JAN-16','DD-MON-RR'),21,'Stock Clerk',6900);
Insert into EMPLOYEES (EMPLOYEE_ID,FIRST_NAME,LAST_NAME,EMAIL,PHONE,HIRE_DATE,MANAGER_ID,JOB_TITLE,SALARY) values (29,'Roman','Hughes','roman.hughes@example.com','650.124.1434',to_date('08-MAR-16','DD-MON-RR'),21,'Stock Clerk',6900);
Insert into EMPLOYEES (EMPLOYEE_ID,FIRST_NAME,LAST_NAME,EMAIL,PHONE,HIRE_DATE,MANAGER_ID,JOB_TITLE,SALARY) values (30,'Austin','Flores','austin.flores@example.com','650.124.5234',to_date('20-AUG-16','DD-MON-RR'),22,'Stock Clerk',6900);
Insert into EMPLOYEES (EMPLOYEE_ID,FIRST_NAME,LAST_NAME,EMAIL,PHONE,HIRE_DATE,MANAGER_ID,JOB_TITLE,SALARY) values (31,'Ellis','Washington','ellis.washington@example.com','650.124.6234',to_date('30-OCT-16','DD-MON-RR'),22,'Stock Clerk',6900);
Insert into EMPLOYEES (EMPLOYEE_ID,FIRST_NAME,LAST_NAME,EMAIL,PHONE,HIRE_DATE,MANAGER_ID,JOB_TITLE,SALARY) values (32,'Jamie','Butler','jamie.butler@example.com','650.124.7234',to_date('16-FEB-16','DD-MON-RR'),22,'Stock Clerk',6900);
Insert into EMPLOYEES (EMPLOYEE_ID,FIRST_NAME,LAST_NAME,EMAIL,PHONE,HIRE_DATE,MANAGER_ID,JOB_TITLE,SALARY) values (45,'Isla','Graham','isla.graham@example.com','650.121.2004',to_date('09-JUL-16','DD-MON-RR'),25,'Stock Clerk',6900);
Insert into EMPLOYEES (EMPLOYEE_ID,FIRST_NAME,LAST_NAME,EMAIL,PHONE,HIRE_DATE,MANAGER_ID,JOB_TITLE,SALARY) values (34,'Seth','Foster','seth.foster@example.com','650.127.1934',to_date('14-JUN-16','DD-MON-RR'),23,'Stock Clerk',6900);
Insert into EMPLOYEES (EMPLOYEE_ID,FIRST_NAME,LAST_NAME,EMAIL,PHONE,HIRE_DATE,MANAGER_ID,JOB_TITLE,SALARY) values (35,'Carter','Gonzales','carter.gonzales@example.com','650.127.1834',to_date('26-AUG-16','DD-MON-RR'),23,'Stock Clerk',6900);
Insert into EMPLOYEES (EMPLOYEE_ID,FIRST_NAME,LAST_NAME,EMAIL,PHONE,HIRE_DATE,MANAGER_ID,JOB_TITLE,SALARY) values (36,'Felix','Bryant','felix.bryant@example.com','650.127.1734',to_date('12-DEC-16','DD-MON-RR'),23,'Stock Clerk',6900);
Insert into EMPLOYEES (EMPLOYEE_ID,FIRST_NAME,LAST_NAME,EMAIL,PHONE,HIRE_DATE,MANAGER_ID,JOB_TITLE,SALARY) values (37,'Ibrahim','Alexander','ibrahim.alexander@example.com','650.127.1634',to_date('06-FEB-16','DD-MON-RR'),23,'Stock Clerk',6900);
Insert into EMPLOYEES (EMPLOYEE_ID,FIRST_NAME,LAST_NAME,EMAIL,PHONE,HIRE_DATE,MANAGER_ID,JOB_TITLE,SALARY) values (38,'Sonny','Russell','sonny.russell@example.com','650.121.1234',to_date('14-JUL-16','DD-MON-RR'),24,'Stock Clerk',6900);
Insert into EMPLOYEES (EMPLOYEE_ID,FIRST_NAME,LAST_NAME,EMAIL,PHONE,HIRE_DATE,MANAGER_ID,JOB_TITLE,SALARY) values (39,'Kian','Griffin','kian.griffin@example.com','650.121.2034',to_date('26-OCT-16','DD-MON-RR'),24,'Stock Clerk',6900);
Insert into EMPLOYEES (EMPLOYEE_ID,FIRST_NAME,LAST_NAME,EMAIL,PHONE,HIRE_DATE,MANAGER_ID,JOB_TITLE,SALARY) values (40,'Caleb','Diaz','caleb.diaz@example.com','650.121.2019',to_date('12-FEB-16','DD-MON-RR'),24,'Stock Clerk',6900);
Insert into EMPLOYEES (EMPLOYEE_ID,FIRST_NAME,LAST_NAME,EMAIL,PHONE,HIRE_DATE,MANAGER_ID,JOB_TITLE,SALARY) values (85,'Holly','Shaw','holly.shaw@example.com','650.509.1876',to_date('27-JAN-16','DD-MON-RR'),22,'Shipping Clerk',7500);
Insert into EMPLOYEES (EMPLOYEE_ID,FIRST_NAME,LAST_NAME,EMAIL,PHONE,HIRE_DATE,MANAGER_ID,JOB_TITLE,SALARY) values (86,'Emilia','Holmes','emilia.holmes@example.com','650.509.2876',to_date('20-FEB-16','DD-MON-RR'),22,'Shipping Clerk',7500);
Insert into EMPLOYEES (EMPLOYEE_ID,FIRST_NAME,LAST_NAME,EMAIL,PHONE,HIRE_DATE,MANAGER_ID,JOB_TITLE,SALARY) values (87,'Molly','Rice','molly.rice@example.com','650.509.3876',to_date('24-JUN-16','DD-MON-RR'),22,'Shipping Clerk',7500);
Insert into EMPLOYEES (EMPLOYEE_ID,FIRST_NAME,LAST_NAME,EMAIL,PHONE,HIRE_DATE,MANAGER_ID,JOB_TITLE,SALARY) values (88,'Ellie','Robertson','ellie.robertson@example.com','650.509.4876',to_date('07-FEB-16','DD-MON-RR'),22,'Shipping Clerk',7500);
Insert into EMPLOYEES (EMPLOYEE_ID,FIRST_NAME,LAST_NAME,EMAIL,PHONE,HIRE_DATE,MANAGER_ID,JOB_TITLE,SALARY) values (89,'Jasmine','Hunt','jasmine.hunt@example.com','650.505.1876',to_date('14-JUN-16','DD-MON-RR'),23,'Shipping Clerk',7500);
Insert into EMPLOYEES (EMPLOYEE_ID,FIRST_NAME,LAST_NAME,EMAIL,PHONE,HIRE_DATE,MANAGER_ID,JOB_TITLE,SALARY) values (90,'Eliza','Black','eliza.black@example.com','650.505.2876',to_date('13-AUG-16','DD-MON-RR'),23,'Shipping Clerk',7500);
Insert into EMPLOYEES (EMPLOYEE_ID,FIRST_NAME,LAST_NAME,EMAIL,PHONE,HIRE_DATE,MANAGER_ID,JOB_TITLE,SALARY) values (91,'Lilly','Daniels','lilly.daniels@example.com','650.505.3876',to_date('11-JUL-16','DD-MON-RR'),23,'Shipping Clerk',7500);
Insert into EMPLOYEES (EMPLOYEE_ID,FIRST_NAME,LAST_NAME,EMAIL,PHONE,HIRE_DATE,MANAGER_ID,JOB_TITLE,SALARY) values (92,'Abigail','Palmer','abigail.palmer@example.com','650.505.4876',to_date('19-DEC-16','DD-MON-RR'),23,'Shipping Clerk',7500);
Insert into EMPLOYEES (EMPLOYEE_ID,FIRST_NAME,LAST_NAME,EMAIL,PHONE,HIRE_DATE,MANAGER_ID,JOB_TITLE,SALARY) values (93,'Georgia','Mills','georgia.mills@example.com','650.501.1876',to_date('04-FEB-16','DD-MON-RR'),24,'Shipping Clerk',7500);
Insert into EMPLOYEES (EMPLOYEE_ID,FIRST_NAME,LAST_NAME,EMAIL,PHONE,HIRE_DATE,MANAGER_ID,JOB_TITLE,SALARY) values (94,'Maisie','Nichols','maisie.nichols@example.com','650.501.2876',to_date('03-MAR-16','DD-MON-RR'),24,'Shipping Clerk',7500);
Insert into EMPLOYEES (EMPLOYEE_ID,FIRST_NAME,LAST_NAME,EMAIL,PHONE,HIRE_DATE,MANAGER_ID,JOB_TITLE,SALARY) values (95,'Eleanor','Grant','eleanor.grant@example.com','650.501.3876',to_date('01-JUL-16','DD-MON-RR'),24,'Shipping Clerk',7500);
Insert into EMPLOYEES (EMPLOYEE_ID,FIRST_NAME,LAST_NAME,EMAIL,PHONE,HIRE_DATE,MANAGER_ID,JOB_TITLE,SALARY) values (96,'Hannah','Knight','hannah.knight@example.com','650.501.4876',to_date('17-MAR-16','DD-MON-RR'),24,'Shipping Clerk',7500);
Insert into EMPLOYEES (EMPLOYEE_ID,FIRST_NAME,LAST_NAME,EMAIL,PHONE,HIRE_DATE,MANAGER_ID,JOB_TITLE,SALARY) values (97,'Harriet','Ferguson','harriet.ferguson@example.com','650.507.9811',to_date('24-APR-16','DD-MON-RR'),25,'Shipping Clerk',7500);
Insert into EMPLOYEES (EMPLOYEE_ID,FIRST_NAME,LAST_NAME,EMAIL,PHONE,HIRE_DATE,MANAGER_ID,JOB_TITLE,SALARY) values (98,'Amber','Rose','amber.rose@example.com','650.507.9822',to_date('23-MAY-16','DD-MON-RR'),25,'Shipping Clerk',7500);
Insert into EMPLOYEES (EMPLOYEE_ID,FIRST_NAME,LAST_NAME,EMAIL,PHONE,HIRE_DATE,MANAGER_ID,JOB_TITLE,SALARY) values (99,'Bella','Stone','bella.stone@example.com','650.507.9833',to_date('21-JUN-16','DD-MON-RR'),25,'Shipping Clerk',7500);
Insert into EMPLOYEES (EMPLOYEE_ID,FIRST_NAME,LAST_NAME,EMAIL,PHONE,HIRE_DATE,MANAGER_ID,JOB_TITLE,SALARY) values (100,'Thea','Hawkins','thea.hawkins@example.com','650.507.9844',to_date('13-JAN-16','DD-MON-RR'),25,'Shipping Clerk',7500);
Insert into EMPLOYEES (EMPLOYEE_ID,FIRST_NAME,LAST_NAME,EMAIL,PHONE,HIRE_DATE,MANAGER_ID,JOB_TITLE,SALARY) values (81,'Lola','Ramos','lola.ramos@example.com','650.507.9876',to_date('24-JAN-16','DD-MON-RR'),21,'Shipping Clerk',7500);
Insert into EMPLOYEES (EMPLOYEE_ID,FIRST_NAME,LAST_NAME,EMAIL,PHONE,HIRE_DATE,MANAGER_ID,JOB_TITLE,SALARY) values (82,'Willow','Reyes','willow.reyes@example.com','650.507.9877',to_date('23-FEB-16','DD-MON-RR'),21,'Shipping Clerk',7500);
Insert into EMPLOYEES (EMPLOYEE_ID,FIRST_NAME,LAST_NAME,EMAIL,PHONE,HIRE_DATE,MANAGER_ID,JOB_TITLE,SALARY) values (83,'Ivy','Burns','ivy.burns@example.com','650.507.9878',to_date('21-JUN-16','DD-MON-RR'),21,'Shipping Clerk',7500);
Insert into EMPLOYEES (EMPLOYEE_ID,FIRST_NAME,LAST_NAME,EMAIL,PHONE,HIRE_DATE,MANAGER_ID,JOB_TITLE,SALARY) values (84,'Erin','Gordon','erin.gordon@example.com','650.507.9879',to_date('03-FEB-16','DD-MON-RR'),21,'Shipping Clerk',7500);
Insert into EMPLOYEES (EMPLOYEE_ID,FIRST_NAME,LAST_NAME,EMAIL,PHONE,HIRE_DATE,MANAGER_ID,JOB_TITLE,SALARY) values (1007,'Summer','Payne','summer.payne@example.com','515.123.8181',to_date('07-JUN-16','DD-MON-RR'),100,'Public Accountant',1025);
Insert into EMPLOYEES (EMPLOYEE_ID,FIRST_NAME,LAST_NAME,EMAIL,PHONE,HIRE_DATE,MANAGER_ID,JOB_TITLE,SALARY) values (1006,'Rose','Stephens','rose.stephens@example.com','515.123.8080',to_date('07-JUN-16','DD-MON-RR'),2,'Accounting Manager',1050);
Insert into EMPLOYEES (EMPLOYEE_ID,FIRST_NAME,LAST_NAME,EMAIL,PHONE,HIRE_DATE,MANAGER_ID,JOB_TITLE,SALARY) values (1001,'Annabelle','Dunn','annabelle.dunn@example.com','515.123.4444',to_date('17-SEP-16','DD-MON-RR'),2,'Administration Assistant',10500);
Insert into EMPLOYEES (EMPLOYEE_ID,FIRST_NAME,LAST_NAME,EMAIL,PHONE,HIRE_DATE,MANAGER_ID,JOB_TITLE,SALARY) values (122,'Emma','Perkins','emma.perkins@example.com','515.123.5555',to_date('17-FEB-16','DD-MON-RR'),1,'Marketing Manager',10900);
Insert into EMPLOYEES (EMPLOYEE_ID,FIRST_NAME,LAST_NAME,EMAIL,PHONE,HIRE_DATE,MANAGER_ID,JOB_TITLE,SALARY) values (123,'Amelie','Hudson','amelie.hudson@example.com','603.123.6666',to_date('17-AUG-16','DD-MON-RR'),22,'Marketing Representative',1862);
Insert into EMPLOYEES (EMPLOYEE_ID,FIRST_NAME,LAST_NAME,EMAIL,PHONE,HIRE_DATE,MANAGER_ID,JOB_TITLE,SALARY) values (124,'Gracie','Gardner','gracie.gardner@example.com','515.123.8888',to_date('07-JUN-16','DD-MON-RR'),2,'Public Relations Representative',8600);

REM INSERTING into CUSTOMERS
SET DEFINE OFF;

Insert into CUSTOMERS (CUSTOMER_ID,NAME,ADDRESS,CREDIT_LIMIT,WEBSITE) values (1,'Raytheon','514 W Superior St, Kokomo, IN',100,'http://www.raytheon.com');
Insert into CUSTOMERS (CUSTOMER_ID,NAME,ADDRESS,CREDIT_LIMIT,WEBSITE) values (2,'Plains GP Holdings','2515 Bloyd Ave, Indianapolis, IN',100,'http://www.plainsallamerican.com');
Insert into CUSTOMERS (CUSTOMER_ID,NAME,ADDRESS,CREDIT_LIMIT,WEBSITE) values (3,'US Foods Holding','8768 N State Rd 37, Bloomington, IN',100,'http://www.usfoods.com');
Insert into CUSTOMERS (CUSTOMER_ID,NAME,ADDRESS,CREDIT_LIMIT,WEBSITE) values (4,'AbbVie','6445 Bay Harbor Ln, Indianapolis, IN',100,'http://www.abbvie.com');
Insert into CUSTOMERS (CUSTOMER_ID,NAME,ADDRESS,CREDIT_LIMIT,WEBSITE) values (5,'Centene','4019 W 3Rd St, Bloomington, IN',100,'http://www.centene.com');
Insert into CUSTOMERS (CUSTOMER_ID,NAME,ADDRESS,CREDIT_LIMIT,WEBSITE) values (6,'Community Health Systems','1608 Portage Ave, South Bend, IN',100,'http://www.chs.net');
Insert into CUSTOMERS (CUSTOMER_ID,NAME,ADDRESS,CREDIT_LIMIT,WEBSITE) values (7,'Alcoa','23943 Us Highway 33, Elkhart, IN',100,'http://www.alcoa.com');
Insert into CUSTOMERS (CUSTOMER_ID,NAME,ADDRESS,CREDIT_LIMIT,WEBSITE) values (8,'International Paper','136 E Market St # 800, Indianapolis, IN',100,'http://www.internationalpaper.com');
Insert into CUSTOMERS (CUSTOMER_ID,NAME,ADDRESS,CREDIT_LIMIT,WEBSITE) values (9,'Emerson Electric','1905 College St, South Bend, IN',100,'http://www.emerson.com');
Insert into CUSTOMERS (CUSTOMER_ID,NAME,ADDRESS,CREDIT_LIMIT,WEBSITE) values (10,'Union Pacific','3512 Rockville Rd # 137C, Indianapolis, IN',200,'http://www.up.com');
Insert into CUSTOMERS (CUSTOMER_ID,NAME,ADDRESS,CREDIT_LIMIT,WEBSITE) values (11,'Amgen','1303 E University St, Bloomington, IN',200,'http://www.amgen.com');
Insert into CUSTOMERS (CUSTOMER_ID,NAME,ADDRESS,CREDIT_LIMIT,WEBSITE) values (12,'U.S. Bancorp','115 N Weinbach Ave, Evansville, IN',200,'http://www.usbank.com');
Insert into CUSTOMERS (CUSTOMER_ID,NAME,ADDRESS,CREDIT_LIMIT,WEBSITE) values (13,'Staples','2067 Rollett Ln, Evansville, IN',200,'http://www.staples.com');
Insert into CUSTOMERS (CUSTOMER_ID,NAME,ADDRESS,CREDIT_LIMIT,WEBSITE) values (14,'Danaher','1105 E Allendale Dr, Bloomington, IN',200,'http://www.danaher.com');
Insert into CUSTOMERS (CUSTOMER_ID,NAME,ADDRESS,CREDIT_LIMIT,WEBSITE) values (15,'Whirlpool','18305 Van Dyke St, Detroit, MI',200,'http://www.whirlpoolcorp.com');
Insert into CUSTOMERS (CUSTOMER_ID,NAME,ADDRESS,CREDIT_LIMIT,WEBSITE) values (16,'Aflac','Lucas Dr Bldg 348, Detroit, MI',200,'http://www.aflac.com');
Insert into CUSTOMERS (CUSTOMER_ID,NAME,ADDRESS,CREDIT_LIMIT,WEBSITE) values (17,'AutoNation','1801 Monroe Ave Nw, Grand Rapids, MI',200,'http://www.autonation.com');
Insert into CUSTOMERS (CUSTOMER_ID,NAME,ADDRESS,CREDIT_LIMIT,WEBSITE) values (18,'Progressive','4925 Kendrick St Se, Grand Rapids, MI',200,'http://www.progressive.com');
Insert into CUSTOMERS (CUSTOMER_ID,NAME,ADDRESS,CREDIT_LIMIT,WEBSITE) values (19,'Abbott Laboratories','3310 Dixie Ct, Saginaw, MI',200,'http://www.abbott.com');
Insert into CUSTOMERS (CUSTOMER_ID,NAME,ADDRESS,CREDIT_LIMIT,WEBSITE) values (20,'Dollar General','113 Washington Sq N, Lansing, MI',200,'http://www.dollargeneral.com');
Insert into CUSTOMERS (CUSTOMER_ID,NAME,ADDRESS,CREDIT_LIMIT,WEBSITE) values (21,'Tenet Healthcare','2500 S Pennsylvania Ave, Lansing, MI',200,'http://www.tenethealth.com');
Insert into CUSTOMERS (CUSTOMER_ID,NAME,ADDRESS,CREDIT_LIMIT,WEBSITE) values (22,'Eli Lilly','3213 S Cedar St, Lansing, MI',200,'http://www.lilly.com');
Insert into CUSTOMERS (CUSTOMER_ID,NAME,ADDRESS,CREDIT_LIMIT,WEBSITE) values (24,'Southwest Airlines','6654 W Lafayette St, Detroit, MI',200,'http://www.southwest.com');
Insert into CUSTOMERS (CUSTOMER_ID,NAME,ADDRESS,CREDIT_LIMIT,WEBSITE) values (25,'Penske Automotive Group','27 Benton Rd, Saginaw, MI',200,'http://www.penskeautomotive.com');
Insert into CUSTOMERS (CUSTOMER_ID,NAME,ADDRESS,CREDIT_LIMIT,WEBSITE) values (26,'ManpowerGroup','8201 Livernois Ave, Detroit, MI',300,'http://www.manpowergroup.com');
Insert into CUSTOMERS (CUSTOMER_ID,NAME,ADDRESS,CREDIT_LIMIT,WEBSITE) values (28,'Kohl?s','3100 E Eisenhower Pky # 100, Ann Arbor, MI',300,'http://www.kohlscorporation.com');
Insert into CUSTOMERS (CUSTOMER_ID,NAME,ADDRESS,CREDIT_LIMIT,WEBSITE) values (29,'Starbucks','952 Vassar Dr, Kalamazoo, MI',400,'http://www.starbucks.com');
Insert into CUSTOMERS (CUSTOMER_ID,NAME,ADDRESS,CREDIT_LIMIT,WEBSITE) values (30,'Paccar','150 W Jefferson Ave # 2500, Detroit, MI',400,'http://www.paccar.com');
Insert into CUSTOMERS (CUSTOMER_ID,NAME,ADDRESS,CREDIT_LIMIT,WEBSITE) values (31,'Cummins','40 Pearl St Nw # 1020, Grand Rapids, MI',400,'http://www.cummins.com');
Insert into CUSTOMERS (CUSTOMER_ID,NAME,ADDRESS,CREDIT_LIMIT,WEBSITE) values (33,'Altria Group','301 E Genesee Ave, Saginaw, MI',400,'http://www.altria.com');
Insert into CUSTOMERS (CUSTOMER_ID,NAME,ADDRESS,CREDIT_LIMIT,WEBSITE) values (34,'Xerox','9936 Dexter Ave, Detroit, MI',400,'http://www.xerox.com');
Insert into CUSTOMERS (CUSTOMER_ID,NAME,ADDRESS,CREDIT_LIMIT,WEBSITE) values (35,'Kimberly-Clark','1660 University Ter, Ann Arbor, MI',400,'http://www.kimberly-clark.com');
Insert into CUSTOMERS (CUSTOMER_ID,NAME,ADDRESS,CREDIT_LIMIT,WEBSITE) values (36,'Hartford Financial Services Group','15713 N East St, Lansing, MI',400,'http://www.thehartford.com');
Insert into CUSTOMERS (CUSTOMER_ID,NAME,ADDRESS,CREDIT_LIMIT,WEBSITE) values (38,'Kraft Heinz','10315 Hickman Rd, Des Moines, IA',500,'http://www.kraftheinzcompany.com');
Insert into CUSTOMERS (CUSTOMER_ID,NAME,ADDRESS,CREDIT_LIMIT,WEBSITE) values (40,'Fluor','1928 Sherwood Dr, Council Bluffs, IA',500,'http://www.fluor.com');
Insert into CUSTOMERS (CUSTOMER_ID,NAME,ADDRESS,CREDIT_LIMIT,WEBSITE) values (41,'AECOM','2102 E Kimberly Rd, Davenport, IA',500,'http://www.aecom.com');
Insert into CUSTOMERS (CUSTOMER_ID,NAME,ADDRESS,CREDIT_LIMIT,WEBSITE) values (44,'Jabil Circuit','221 3Rd Ave Se # 300, Cedar Rapids, IA',500,'http://www.jabil.com');
Insert into CUSTOMERS (CUSTOMER_ID,NAME,ADDRESS,CREDIT_LIMIT,WEBSITE) values (45,'CenturyLink','2120 Heights Dr, Eau Claire, WI',500,'http://www.centurylink.com');
Insert into CUSTOMERS (CUSTOMER_ID,NAME,ADDRESS,CREDIT_LIMIT,WEBSITE) values (47,'General Mills','6555 W Good Hope Rd, Milwaukee, WI',600,'http://www.generalmills.com');
Insert into CUSTOMERS (CUSTOMER_ID,NAME,ADDRESS,CREDIT_LIMIT,WEBSITE) values (48,'Southern','1314 N Stoughton Rd, Madison, WI',600,'http://www.southerncompany.com');
Insert into CUSTOMERS (CUSTOMER_ID,NAME,ADDRESS,CREDIT_LIMIT,WEBSITE) values (50,'Thermo Fisher Scientific','6161 N 64Th St, Milwaukee, WI',700,'http://www.thermofisher.com');

REM INSERTING into CONTACTS
SET DEFINE OFF;
Insert into CONTACTS (CONTACT_ID,FIRST_NAME,LAST_NAME,EMAIL,PHONE,CUSTOMER_ID) values (1,'Flor','Stone','flor.stone@raytheon.com','+1 317 123 4104',1);
Insert into CONTACTS (CONTACT_ID,FIRST_NAME,LAST_NAME,EMAIL,PHONE,CUSTOMER_ID) values (2,'Lavera','Emerson','lavera.emerson@plainsallamerican.com','+1 317 123 4111',2);
Insert into CONTACTS (CONTACT_ID,FIRST_NAME,LAST_NAME,EMAIL,PHONE,CUSTOMER_ID) values (3,'Fern','Head','fern.head@usfoods.com','+1 812 123 4115',3);
Insert into CONTACTS (CONTACT_ID,FIRST_NAME,LAST_NAME,EMAIL,PHONE,CUSTOMER_ID) values (4,'Shyla','Ortiz','shyla.ortiz@abbvie.com','+1 317 123 4126',4);
Insert into CONTACTS (CONTACT_ID,FIRST_NAME,LAST_NAME,EMAIL,PHONE,CUSTOMER_ID) values (5,'Jeni','Levy','jeni.levy@centene.com','+1 812 123 4129',5);
Insert into CONTACTS (CONTACT_ID,FIRST_NAME,LAST_NAME,EMAIL,PHONE,CUSTOMER_ID) values (6,'Matthias','Hannah','matthias.hannah@chs.net','+1 219 123 4136',6);
Insert into CONTACTS (CONTACT_ID,FIRST_NAME,LAST_NAME,EMAIL,PHONE,CUSTOMER_ID) values (7,'Matthias','Cruise','matthias.cruise@alcoa.com','+1 219 123 4138',7);
Insert into CONTACTS (CONTACT_ID,FIRST_NAME,LAST_NAME,EMAIL,PHONE,CUSTOMER_ID) values (8,'Meenakshi','Mason','meenakshi.mason@internationalpaper.com','+1 317 123 4141',8);
Insert into CONTACTS (CONTACT_ID,FIRST_NAME,LAST_NAME,EMAIL,PHONE,CUSTOMER_ID) values (9,'Christian','Cage','christian.cage@emerson.com','+1 219 123 4142',9);
Insert into CONTACTS (CONTACT_ID,FIRST_NAME,LAST_NAME,EMAIL,PHONE,CUSTOMER_ID) values (10,'Charlie','Sutherland','charlie.sutherland@up.com','+1 317 123 4146',10);
Insert into CONTACTS (CONTACT_ID,FIRST_NAME,LAST_NAME,EMAIL,PHONE,CUSTOMER_ID) values (11,'Charlie','Pacino','charlie.pacino@amgen.com','+1 812 123 4150',11);
Insert into CONTACTS (CONTACT_ID,FIRST_NAME,LAST_NAME,EMAIL,PHONE,CUSTOMER_ID) values (12,'Guillaume','Jackson','guillaume.jackson@usbank.com','+1 812 123 4151',12);
Insert into CONTACTS (CONTACT_ID,FIRST_NAME,LAST_NAME,EMAIL,PHONE,CUSTOMER_ID) values (13,'Daniel','Costner','daniel.costner@staples.com','+1 812 123 4153',13);
Insert into CONTACTS (CONTACT_ID,FIRST_NAME,LAST_NAME,EMAIL,PHONE,CUSTOMER_ID) values (14,'Dianne','Derek','dianne.derek@danaher.com','+1 812 123 4157',14);
Insert into CONTACTS (CONTACT_ID,FIRST_NAME,LAST_NAME,EMAIL,PHONE,CUSTOMER_ID) values (15,'Geraldine','Schneider','geraldine.schneider@whirlpoolcorp.com','+1 313 123 4159',15);
Insert into CONTACTS (CONTACT_ID,FIRST_NAME,LAST_NAME,EMAIL,PHONE,CUSTOMER_ID) values (16,'Geraldine','Martin','geraldine.martin@aflac.com','+1 313 123 4160',16);
Insert into CONTACTS (CONTACT_ID,FIRST_NAME,LAST_NAME,EMAIL,PHONE,CUSTOMER_ID) values (17,'Guillaume','Edwards','guillaume.edwards@autonation.com','+1 616 123 4162',17);
Insert into CONTACTS (CONTACT_ID,FIRST_NAME,LAST_NAME,EMAIL,PHONE,CUSTOMER_ID) values (18,'Maurice','Mahoney','maurice.mahoney@progressive.com','+1 616 123 4181',18);
Insert into CONTACTS (CONTACT_ID,FIRST_NAME,LAST_NAME,EMAIL,PHONE,CUSTOMER_ID) values (19,'Maurice','Hasan','maurice.hasan@abbott.com','+1 517 123 4191',19);
Insert into CONTACTS (CONTACT_ID,FIRST_NAME,LAST_NAME,EMAIL,PHONE,CUSTOMER_ID) values (20,'Diane','Higgins','diane.higgins@dollargeneral.com','+1 517 123 4199',20);
Insert into CONTACTS (CONTACT_ID,FIRST_NAME,LAST_NAME,EMAIL,PHONE,CUSTOMER_ID) values (21,'Dianne','Sen','dianne.sen@tenethealth.com','+1 517 123 4201',21);
Insert into CONTACTS (CONTACT_ID,FIRST_NAME,LAST_NAME,EMAIL,PHONE,CUSTOMER_ID) values (22,'Maurice','Daltrey','maurice.daltrey@lilly.com','+1 517 123 4206',22);
Insert into CONTACTS (CONTACT_ID,FIRST_NAME,LAST_NAME,EMAIL,PHONE,CUSTOMER_ID) values (23,'Tess','Roth','tess.roth@dteenergy.com','+1 313 123 4219',23);
Insert into CONTACTS (CONTACT_ID,FIRST_NAME,LAST_NAME,EMAIL,PHONE,CUSTOMER_ID) values (24,'Ka','Kaufman','ka.kaufman@southwest.com','+1 313 123 4222',24);
Insert into CONTACTS (CONTACT_ID,FIRST_NAME,LAST_NAME,EMAIL,PHONE,CUSTOMER_ID) values (25,'Sharyl','Montoya','sharyl.montoya@penskeautomotive.com','+1 517 123 4225',25);
Insert into CONTACTS (CONTACT_ID,FIRST_NAME,LAST_NAME,EMAIL,PHONE,CUSTOMER_ID) values (26,'Daniel','Glass','daniel.glass@manpowergroup.com','+1 313 123 4226',26);
Insert into CONTACTS (CONTACT_ID,FIRST_NAME,LAST_NAME,EMAIL,PHONE,CUSTOMER_ID) values (27,'Rena','Arnold','rena.arnold@assurant.com','+1 517 123 4228',27);
Insert into CONTACTS (CONTACT_ID,FIRST_NAME,LAST_NAME,EMAIL,PHONE,CUSTOMER_ID) values (28,'Arlyne','Ingram','arlyne.ingram@kohlscorporation.com','+1 313 123 4230',28);
Insert into CONTACTS (CONTACT_ID,FIRST_NAME,LAST_NAME,EMAIL,PHONE,CUSTOMER_ID) values (29,'Willie','Barrera','willie.barrera@starbucks.com','+1 616 123 4234',29);
Insert into CONTACTS (CONTACT_ID,FIRST_NAME,LAST_NAME,EMAIL,PHONE,CUSTOMER_ID) values (30,'Mireya','Cochran','mireya.cochran@paccar.com','+1 313 123 4242',30);
Insert into CONTACTS (CONTACT_ID,FIRST_NAME,LAST_NAME,EMAIL,PHONE,CUSTOMER_ID) values (31,'Marlene','Odom','marlene.odom@cummins.com','+1 616 123 4245',31);
Insert into CONTACTS (CONTACT_ID,FIRST_NAME,LAST_NAME,EMAIL,PHONE,CUSTOMER_ID) values (32,'Jaclyn','Atkinson','jaclyn.atkinson@globalp.com','+1 313 123 4248',32);
Insert into CONTACTS (CONTACT_ID,FIRST_NAME,LAST_NAME,EMAIL,PHONE,CUSTOMER_ID) values (33,'Al','Schultz','al.schultz@altria.com','+1 517 123 4253',33);
Insert into CONTACTS (CONTACT_ID,FIRST_NAME,LAST_NAME,EMAIL,PHONE,CUSTOMER_ID) values (34,'Felicitas','Riley','felicitas.riley@xerox.com','+1 313 123 4255',34);
Insert into CONTACTS (CONTACT_ID,FIRST_NAME,LAST_NAME,EMAIL,PHONE,CUSTOMER_ID) values (35,'Cora','Calhoun','cora.calhoun@kimberly-clark.com','+1 313 123 4263',35);
Insert into CONTACTS (CONTACT_ID,FIRST_NAME,LAST_NAME,EMAIL,PHONE,CUSTOMER_ID) values (36,'Trula','Buckley','trula.buckley@thehartford.com','+1 517 123 4265',36);
Insert into CONTACTS (CONTACT_ID,FIRST_NAME,LAST_NAME,EMAIL,PHONE,CUSTOMER_ID) values (37,'Sasha','Wallace','sasha.wallace@huntsman.com','+1 319 123 4271',37);
Insert into CONTACTS (CONTACT_ID,FIRST_NAME,LAST_NAME,EMAIL,PHONE,CUSTOMER_ID) values (38,'Caitlin','Hill','caitlin.hill@kraftheinzcompany.com','+1 515 123 4273',38);
Insert into CONTACTS (CONTACT_ID,FIRST_NAME,LAST_NAME,EMAIL,PHONE,CUSTOMER_ID) values (39,'Gino','Pickett','gino.pickett@lear.com','+1 319 123 4278',39);
Insert into CONTACTS (CONTACT_ID,FIRST_NAME,LAST_NAME,EMAIL,PHONE,CUSTOMER_ID) values (40,'Amira','Macdonald','amira.macdonald@fluor.com','+1 712 123 4280',40);
Insert into CONTACTS (CONTACT_ID,FIRST_NAME,LAST_NAME,EMAIL,PHONE,CUSTOMER_ID) values (41,'Mack','Morse','mack.morse@aecom.com','+1 319 123 4282',41);
Insert into CONTACTS (CONTACT_ID,FIRST_NAME,LAST_NAME,EMAIL,PHONE,CUSTOMER_ID) values (42,'Eboni','Jarvis','eboni.jarvis@bd.com','+1 319 123 4288',42);
Insert into CONTACTS (CONTACT_ID,FIRST_NAME,LAST_NAME,EMAIL,PHONE,CUSTOMER_ID) values (43,'Gabrielle','Dennis','gabrielle.dennis@facebook.com','+1 515 123 4290',43);
Insert into CONTACTS (CONTACT_ID,FIRST_NAME,LAST_NAME,EMAIL,PHONE,CUSTOMER_ID) values (44,'Classie','Norris','classie.norris@jabil.com','+1 319 123 4301',44);
Insert into CONTACTS (CONTACT_ID,FIRST_NAME,LAST_NAME,EMAIL,PHONE,CUSTOMER_ID) values (45,'Khalilah','Holman','khalilah.holman@centurylink.com','+1 745 123 4306',45);
Insert into CONTACTS (CONTACT_ID,FIRST_NAME,LAST_NAME,EMAIL,PHONE,CUSTOMER_ID) values (46,'Isreal','Rose','isreal.rose@supervalu.com','+1 414 123 4307',46);
Insert into CONTACTS (CONTACT_ID,FIRST_NAME,LAST_NAME,EMAIL,PHONE,CUSTOMER_ID) values (47,'Verena','Hopper','verena.hopper@generalmills.com','+1 414 123 4308',47);
Insert into CONTACTS (CONTACT_ID,FIRST_NAME,LAST_NAME,EMAIL,PHONE,CUSTOMER_ID) values (48,'Audie','Flores','audie.flores@southerncompany.com','+1 608 123 4309',48);
Insert into CONTACTS (CONTACT_ID,FIRST_NAME,LAST_NAME,EMAIL,PHONE,CUSTOMER_ID) values (49,'Gertrude','Cooke','gertrude.cooke@nexteraenergy.com','+1 608 123 4318',49);
Insert into CONTACTS (CONTACT_ID,FIRST_NAME,LAST_NAME,EMAIL,PHONE,CUSTOMER_ID) values (50,'Princess','Kane','princess.kane@thermofisher.com','+1 414 123 4323',50);

REM INSERTING into ORDERS
SET DEFINE OFF;
Insert into ORDERS (ORDER_ID,CUSTOMER_ID,STATUS,SALESMAN_ID,ORDER_DATE) values (105,1,'Pending',54,to_date('17-NOV-16','DD-MON-RR'));
Insert into ORDERS (ORDER_ID,CUSTOMER_ID,STATUS,SALESMAN_ID,ORDER_DATE) values (44,2,'Pending',55,to_date('20-FEB-17','DD-MON-RR'));
Insert into ORDERS (ORDER_ID,CUSTOMER_ID,STATUS,SALESMAN_ID,ORDER_DATE) values (101,3,'Pending',55,to_date('03-JAN-17','DD-MON-RR'));
Insert into ORDERS (ORDER_ID,CUSTOMER_ID,STATUS,SALESMAN_ID,ORDER_DATE) values (1,4,'Pending',56,to_date('15-OCT-17','DD-MON-RR'));
Insert into ORDERS (ORDER_ID,CUSTOMER_ID,STATUS,SALESMAN_ID,ORDER_DATE) values (5,5,'Canceled',56,to_date('09-APR-17','DD-MON-RR'));
Insert into ORDERS (ORDER_ID,CUSTOMER_ID,STATUS,SALESMAN_ID,ORDER_DATE) values (28,6,'Canceled',57,to_date('15-AUG-17','DD-MON-RR'));
Insert into ORDERS (ORDER_ID,CUSTOMER_ID,STATUS,SALESMAN_ID,ORDER_DATE) values (87,7,'Canceled',57,to_date('01-DEC-16','DD-MON-RR'));
Insert into ORDERS (ORDER_ID,CUSTOMER_ID,STATUS,SALESMAN_ID,ORDER_DATE) values (4,8,'Shipped',59,to_date('09-APR-15','DD-MON-RR'));
Insert into ORDERS (ORDER_ID,CUSTOMER_ID,STATUS,SALESMAN_ID,ORDER_DATE) values (41,9,'Shipped',59,to_date('11-MAY-17','DD-MON-RR'));
Insert into ORDERS (ORDER_ID,CUSTOMER_ID,STATUS,SALESMAN_ID,ORDER_DATE) values (83,16,'Shipped',62,to_date('02-DEC-16','DD-MON-RR'));
Insert into ORDERS (ORDER_ID,CUSTOMER_ID,STATUS,SALESMAN_ID,ORDER_DATE) values (93,17,'Shipped',62,to_date('27-OCT-16','DD-MON-RR'));
Insert into ORDERS (ORDER_ID,CUSTOMER_ID,STATUS,SALESMAN_ID,ORDER_DATE) values (94,1,'Shipped',62,to_date('27-OCT-17','DD-MON-RR'));
Insert into ORDERS (ORDER_ID,CUSTOMER_ID,STATUS,SALESMAN_ID,ORDER_DATE) values (79,2,'Shipped',64,to_date('14-DEC-16','DD-MON-RR'));
Insert into ORDERS (ORDER_ID,CUSTOMER_ID,STATUS,SALESMAN_ID,ORDER_DATE) values (80,3,'Shipped',64,to_date('13-DEC-16','DD-MON-RR'));
Insert into ORDERS (ORDER_ID,CUSTOMER_ID,STATUS,SALESMAN_ID,ORDER_DATE) values (2,4,'Shipped',null,to_date('26-APR-15','DD-MON-RR'));
Insert into ORDERS (ORDER_ID,CUSTOMER_ID,STATUS,SALESMAN_ID,ORDER_DATE) values (3,5,'Shipped',null,to_date('26-APR-17','DD-MON-RR'));
Insert into ORDERS (ORDER_ID,CUSTOMER_ID,STATUS,SALESMAN_ID,ORDER_DATE) values (6,6,'Shipped',null,to_date('09-APR-15','DD-MON-RR'));
Insert into ORDERS (ORDER_ID,CUSTOMER_ID,STATUS,SALESMAN_ID,ORDER_DATE) values (7,7,'Shipped',null,to_date('15-FEB-17','DD-MON-RR'));
Insert into ORDERS (ORDER_ID,CUSTOMER_ID,STATUS,SALESMAN_ID,ORDER_DATE) values (8,8,'Shipped',null,to_date('14-FEB-17','DD-MON-RR'));
Insert into ORDERS (ORDER_ID,CUSTOMER_ID,STATUS,SALESMAN_ID,ORDER_DATE) values (9,9,'Shipped',null,to_date('14-FEB-17','DD-MON-RR'));
Insert into ORDERS (ORDER_ID,CUSTOMER_ID,STATUS,SALESMAN_ID,ORDER_DATE) values (10,44,'Pending',null,to_date('24-JAN-17','DD-MON-RR'));
Insert into ORDERS (ORDER_ID,CUSTOMER_ID,STATUS,SALESMAN_ID,ORDER_DATE) values (11,45,'Shipped',null,to_date('29-NOV-16','DD-MON-RR'));
Insert into ORDERS (ORDER_ID,CUSTOMER_ID,STATUS,SALESMAN_ID,ORDER_DATE) values (12,46,'Shipped',null,to_date('29-NOV-16','DD-MON-RR'));
Insert into ORDERS (ORDER_ID,CUSTOMER_ID,STATUS,SALESMAN_ID,ORDER_DATE) values (13,47,'Shipped',null,to_date('29-NOV-16','DD-MON-RR'));
Insert into ORDERS (ORDER_ID,CUSTOMER_ID,STATUS,SALESMAN_ID,ORDER_DATE) values (14,48,'Shipped',null,to_date('28-SEP-17','DD-MON-RR'));
Insert into ORDERS (ORDER_ID,CUSTOMER_ID,STATUS,SALESMAN_ID,ORDER_DATE) values (15,49,'Shipped',null,to_date('27-SEP-17','DD-MON-RR'));
Insert into ORDERS (ORDER_ID,CUSTOMER_ID,STATUS,SALESMAN_ID,ORDER_DATE) values (16,16,'Pending',null,to_date('27-SEP-16','DD-MON-RR'));
Insert into ORDERS (ORDER_ID,CUSTOMER_ID,STATUS,SALESMAN_ID,ORDER_DATE) values (17,17,'Shipped',null,to_date('27-SEP-17','DD-MON-RR'));
Insert into ORDERS (ORDER_ID,CUSTOMER_ID,STATUS,SALESMAN_ID,ORDER_DATE) values (18,18,'Shipped',null,to_date('16-AUG-16','DD-MON-RR'));
Insert into ORDERS (ORDER_ID,CUSTOMER_ID,STATUS,SALESMAN_ID,ORDER_DATE) values (19,19,'Shipped',null,to_date('27-MAY-16','DD-MON-RR'));
Insert into ORDERS (ORDER_ID,CUSTOMER_ID,STATUS,SALESMAN_ID,ORDER_DATE) values (20,20,'Shipped',null,to_date('27-MAY-17','DD-MON-RR'));
Insert into ORDERS (ORDER_ID,CUSTOMER_ID,STATUS,SALESMAN_ID,ORDER_DATE) values (21,21,'Pending',null,to_date('27-MAY-17','DD-MON-RR'));
Insert into ORDERS (ORDER_ID,CUSTOMER_ID,STATUS,SALESMAN_ID,ORDER_DATE) values (22,22,'Canceled',null,to_date('26-MAY-16','DD-MON-RR'));
Insert into ORDERS (ORDER_ID,CUSTOMER_ID,STATUS,SALESMAN_ID,ORDER_DATE) values (23,23,'Shipped',null,to_date('07-SEP-16','DD-MON-RR'));
Insert into ORDERS (ORDER_ID,CUSTOMER_ID,STATUS,SALESMAN_ID,ORDER_DATE) values (24,41,'Shipped',null,to_date('07-SEP-16','DD-MON-RR'));
Insert into ORDERS (ORDER_ID,CUSTOMER_ID,STATUS,SALESMAN_ID,ORDER_DATE) values (25,42,'Shipped',null,to_date('24-AUG-16','DD-MON-RR'));
Insert into ORDERS (ORDER_ID,CUSTOMER_ID,STATUS,SALESMAN_ID,ORDER_DATE) values (27,43,'Canceled',null,to_date('16-AUG-16','DD-MON-RR'));
Insert into ORDERS (ORDER_ID,CUSTOMER_ID,STATUS,SALESMAN_ID,ORDER_DATE) values (29,44,'Shipped',null,to_date('14-AUG-17','DD-MON-RR'));
Insert into ORDERS (ORDER_ID,CUSTOMER_ID,STATUS,SALESMAN_ID,ORDER_DATE) values (30,45,'Shipped',null,to_date('12-AUG-17','DD-MON-RR'));
Insert into ORDERS (ORDER_ID,CUSTOMER_ID,STATUS,SALESMAN_ID,ORDER_DATE) values (31,46,'Canceled',null,to_date('12-AUG-17','DD-MON-RR'));
Insert into ORDERS (ORDER_ID,CUSTOMER_ID,STATUS,SALESMAN_ID,ORDER_DATE) values (32,47,'Shipped',null,to_date('09-MAR-17','DD-MON-RR'));
Insert into ORDERS (ORDER_ID,CUSTOMER_ID,STATUS,SALESMAN_ID,ORDER_DATE) values (33,48,'Shipped',null,to_date('07-MAR-17','DD-MON-RR'));
Insert into ORDERS (ORDER_ID,CUSTOMER_ID,STATUS,SALESMAN_ID,ORDER_DATE) values (34,49,'Shipped',null,to_date('12-JUN-16','DD-MON-RR'));
Insert into ORDERS (ORDER_ID,CUSTOMER_ID,STATUS,SALESMAN_ID,ORDER_DATE) values (35,50,'Shipped',null,to_date('05-SEP-16','DD-MON-RR'));

REM INSERTING into PRODUCT_CATEGORIES
SET DEFINE OFF;
Insert into PRODUCT_CATEGORIES (CATEGORY_ID,CATEGORY_NAME) values (1,'CPU');
Insert into PRODUCT_CATEGORIES (CATEGORY_ID,CATEGORY_NAME) values (2,'Video Card');
Insert into PRODUCT_CATEGORIES (CATEGORY_ID,CATEGORY_NAME) values (3,'RAM');
Insert into PRODUCT_CATEGORIES (CATEGORY_ID,CATEGORY_NAME) values (4,'Mother Board');
Insert into PRODUCT_CATEGORIES (CATEGORY_ID,CATEGORY_NAME) values (5,'Storage');


REM INSERTING into PRODUCTS
SET DEFINE OFF;
Insert into PRODUCTS (PRODUCT_ID,PRODUCT_NAME,DESCRIPTION,STANDARD_COST,LIST_PRICE,CATEGORY_ID) values (208,'Samsung MZ-V6P2T0BW','Series:960 Pro,Type:SSD,Capacity:2TB,Cache:2GB',840.11,1199.99,5);
Insert into PRODUCTS (PRODUCT_ID,PRODUCT_NAME,DESCRIPTION,STANDARD_COST,LIST_PRICE,CATEGORY_ID) values (229,'Seagate ST10000DM0004','Series:BarraCuda Pro,Type:7200RPM,Capacity:10TB,Cache:256MB',284.23,399.99,5);
Insert into PRODUCTS (PRODUCT_ID,PRODUCT_NAME,DESCRIPTION,STANDARD_COST,LIST_PRICE,CATEGORY_ID) values (230,'ADATA ASU800SS-512GT-C','Series:Ultimate SU800,Type:SSD,Capacity:512GB,Cache:N/A',113.29,136.69,5);
Insert into PRODUCTS (PRODUCT_ID,PRODUCT_NAME,DESCRIPTION,STANDARD_COST,LIST_PRICE,CATEGORY_ID) values (231,'Samsung MZ-V6E1T0','Series:960 EVO,Type:SSD,Capacity:1TB,Cache:1000MB',358.06,449.99,5);
Insert into PRODUCTS (PRODUCT_ID,PRODUCT_NAME,DESCRIPTION,STANDARD_COST,LIST_PRICE,CATEGORY_ID) values (232,'Western Digital WD1003FZEX','Series:BLACK SERIES,Type:7200RPM,Capacity:1TB,Cache:64MB',61.76,70.89,5);
Insert into PRODUCTS (PRODUCT_ID,PRODUCT_NAME,DESCRIPTION,STANDARD_COST,LIST_PRICE,CATEGORY_ID) values (233,'SanDisk SDSSDA-120G-G26','Series:SSD PLUS,Type:SSD,Capacity:120GB,Cache:N/A',52.7,59.99,5);
Insert into PRODUCTS (PRODUCT_ID,PRODUCT_NAME,DESCRIPTION,STANDARD_COST,LIST_PRICE,CATEGORY_ID) values (234,'Crucial CT525MX300SSD1','Series:MX300,Type:SSD,Capacity:525GB,Cache:N/A',135.59,150.99,5);
Insert into PRODUCTS (PRODUCT_ID,PRODUCT_NAME,DESCRIPTION,STANDARD_COST,LIST_PRICE,CATEGORY_ID) values (235,'Hitachi A7K1000-1000','Series:Ultrastar,Type:7200RPM,Capacity:1TB,Cache:32MB',29.94,41.99,5);
Insert into PRODUCTS (PRODUCT_ID,PRODUCT_NAME,DESCRIPTION,STANDARD_COST,LIST_PRICE,CATEGORY_ID) values (253,'Samsung MZ-V6P1T0BW','Series:960 Pro,Type:SSD,Capacity:1TB,Cache:1GB',466.49,579.99,5);
Insert into PRODUCTS (PRODUCT_ID,PRODUCT_NAME,DESCRIPTION,STANDARD_COST,LIST_PRICE,CATEGORY_ID) values (254,'Samsung MZ-7KE256BW','Series:850 Pro Series,Type:SSD,Capacity:256GB,Cache:N/A',97.19,119.99,5);
Insert into PRODUCTS (PRODUCT_ID,PRODUCT_NAME,DESCRIPTION,STANDARD_COST,LIST_PRICE,CATEGORY_ID) values (255,'Seagate ST2000DX002','Series:FireCuda,Type:Hybrid,Capacity:2TB,Cache:64MB',64.48,90.99,5);
Insert into PRODUCTS (PRODUCT_ID,PRODUCT_NAME,DESCRIPTION,STANDARD_COST,LIST_PRICE,CATEGORY_ID) values (256,'Western Digital WD5000AACS','Series:Caviar Green,Type:5400RPM,Capacity:500GB,Cache:16MB',20.14,26.99,5);
Insert into PRODUCTS (PRODUCT_ID,PRODUCT_NAME,DESCRIPTION,STANDARD_COST,LIST_PRICE,CATEGORY_ID) values (257,'SanDisk SDSSDHII-240G-G25','Series:Ultra II,Type:SSD,Capacity:240GB,Cache:N/A',73.39,84.95,5);
Insert into PRODUCTS (PRODUCT_ID,PRODUCT_NAME,DESCRIPTION,STANDARD_COST,LIST_PRICE,CATEGORY_ID) values (258,'PNY SSD7CS1311-120-RB','Series:CS1311,Type:SSD,Capacity:120GB,Cache:N/A',50.59,57.98,5);
Insert into PRODUCTS (PRODUCT_ID,PRODUCT_NAME,DESCRIPTION,STANDARD_COST,LIST_PRICE,CATEGORY_ID) values (259,'PNY SSD9SC240GMDA-RB','Series:XLR8,Type:SSD,Capacity:240GB,Cache:N/A',58.4,80.72,5);
Insert into PRODUCTS (PRODUCT_ID,PRODUCT_NAME,DESCRIPTION,STANDARD_COST,LIST_PRICE,CATEGORY_ID) values (260,'Crucial CT1050MX300SSD1','Series:MX300,Type:SSD,Capacity:1.1TB,Cache:N/A',192.52,267.99,5);
Insert into PRODUCTS (PRODUCT_ID,PRODUCT_NAME,DESCRIPTION,STANDARD_COST,LIST_PRICE,CATEGORY_ID) values (263,'Western Digital WDS250G1B0B','Series:Blue,Type:SSD,Capacity:250GB,Cache:N/A',70.71,89.99,5);
Insert into PRODUCTS (PRODUCT_ID,PRODUCT_NAME,DESCRIPTION,STANDARD_COST,LIST_PRICE,CATEGORY_ID) values (264,'Samsung MZ-75E120B/AM','Series:850 EVO-Series,Type:SSD,Capacity:120GB,Cache:N/A',74.41,88.99,5);
Insert into PRODUCTS (PRODUCT_ID,PRODUCT_NAME,DESCRIPTION,STANDARD_COST,LIST_PRICE,CATEGORY_ID) values (224,'Asus STRIX X299-E GAMING','CPU:LGA2066,Form Factor:ATX,RAM Slots:8,Max RAM:128GB',306,349.99,4);
Insert into PRODUCTS (PRODUCT_ID,PRODUCT_NAME,DESCRIPTION,STANDARD_COST,LIST_PRICE,CATEGORY_ID) values (246,'Gigabyte X299 AORUS Ultra Gaming','CPU:LGA2066,Form Factor:ATX,RAM Slots:8,Max RAM:128GB',287.78,343.99,4);
Insert into PRODUCTS (PRODUCT_ID,PRODUCT_NAME,DESCRIPTION,STANDARD_COST,LIST_PRICE,CATEGORY_ID) values (247,'Asus TUF X299 MARK 1','CPU:LGA2066,Form Factor:ATX,RAM Slots:8,Max RAM:128GB',241.15,339.99,4);
Insert into PRODUCTS (PRODUCT_ID,PRODUCT_NAME,DESCRIPTION,STANDARD_COST,LIST_PRICE,CATEGORY_ID) values (250,'Asus Z170-WS','CPU:LGA1151,Form Factor:ATX,RAM Slots:4,Max RAM:64GB',279.4,338.99,4);
Insert into PRODUCTS (PRODUCT_ID,PRODUCT_NAME,DESCRIPTION,STANDARD_COST,LIST_PRICE,CATEGORY_ID) values (251,'MSI X299 GAMING PRO CARBON AC','CPU:LGA2066,Form Factor:ATX,RAM Slots:8,Max RAM:128GB',238.8,337.81,4);
Insert into PRODUCTS (PRODUCT_ID,PRODUCT_NAME,DESCRIPTION,STANDARD_COST,LIST_PRICE,CATEGORY_ID) values (287,'MSI X99A XPOWER GAMING TITANIUM','CPU:LGA2011-3,Form Factor:EATX,RAM Slots:8,Max RAM:128GB',257.23,329.99,4);
Insert into PRODUCTS (PRODUCT_ID,PRODUCT_NAME,DESCRIPTION,STANDARD_COST,LIST_PRICE,CATEGORY_ID) values (288,'Asus ROG STRIX X99 GAMING','CPU:LGA2011-3,Form Factor:ATX,RAM Slots:8,Max RAM:128GB',255.86,319.99,4);
Insert into PRODUCTS (PRODUCT_ID,PRODUCT_NAME,DESCRIPTION,STANDARD_COST,LIST_PRICE,CATEGORY_ID) values (226,'Asus PRIME X299-A','CPU:LGA2066,Form Factor:ATX,RAM Slots:8,Max RAM:128GB',274.56,309.85,4);
Insert into PRODUCTS (PRODUCT_ID,PRODUCT_NAME,DESCRIPTION,STANDARD_COST,LIST_PRICE,CATEGORY_ID) values (227,'Gigabyte GA-X99-UD5 WIFI','CPU:LGA2011-3,Form Factor:EATX,RAM Slots:8,Max RAM:64GB',217.83,305,4);
Insert into PRODUCTS (PRODUCT_ID,PRODUCT_NAME,DESCRIPTION,STANDARD_COST,LIST_PRICE,CATEGORY_ID) values (268,'Western Digital WD10EZEX','Series:Caviar Blue,Type:7200RPM,Capacity:1TB,Cache:64MB',35.83,47.88,5);
Insert into PRODUCTS (PRODUCT_ID,PRODUCT_NAME,DESCRIPTION,STANDARD_COST,LIST_PRICE,CATEGORY_ID) values (284,'Kingston SA400S37/120G','Series:A400,Type:SSD,Capacity:120GB,Cache:N/A',40.63,54.99,5);
Insert into PRODUCTS (PRODUCT_ID,PRODUCT_NAME,DESCRIPTION,STANDARD_COST,LIST_PRICE,CATEGORY_ID) values (285,'Samsung MZ-75E1T0B/AM','Series:850 EVO-Series,Type:SSD,Capacity:1TB,Cache:N/A',260.23,339.99,5);
Insert into PRODUCTS (PRODUCT_ID,PRODUCT_NAME,DESCRIPTION,STANDARD_COST,LIST_PRICE,CATEGORY_ID) values (286,'Samsung MZ-V6E500','Series:960 EVO,Type:SSD,Capacity:500GB,Cache:512MB',209.62,234,5);
Insert into PRODUCTS (PRODUCT_ID,PRODUCT_NAME,DESCRIPTION,STANDARD_COST,LIST_PRICE,CATEGORY_ID) values (273,'Western Digital WD101KRYZ','Series:Gold,Type:7200RPM,Capacity:10TB,Cache:256MB',313.96,443.64,5);


Insert into ORDER_ITEMS (ORDER_ID,ITEM_ID,PRODUCT_ID,QUANTITY,UNIT_PRICE) values (8,5,284,118,54.99);
Insert into ORDER_ITEMS (ORDER_ID,ITEM_ID,PRODUCT_ID,QUANTITY,UNIT_PRICE) values (11,5,208,133,1199.99);
Insert into ORDER_ITEMS (ORDER_ID,ITEM_ID,PRODUCT_ID,QUANTITY,UNIT_PRICE) values (13,3,247,80,1805.97);
Insert into ORDER_ITEMS (ORDER_ID,ITEM_ID,PRODUCT_ID,QUANTITY,UNIT_PRICE) values (14,4,239,71,739.99);
Insert into ORDER_ITEMS (ORDER_ID,ITEM_ID,PRODUCT_ID,QUANTITY,UNIT_PRICE) values (19,4,259,46,80.72);
Insert into ORDER_ITEMS (ORDER_ID,ITEM_ID,PRODUCT_ID,QUANTITY,UNIT_PRICE) values (21,3,250,120,338.99);
Insert into ORDER_ITEMS (ORDER_ID,ITEM_ID,PRODUCT_ID,QUANTITY,UNIT_PRICE) values (22,5,260,59,1908.73);
Insert into ORDER_ITEMS (ORDER_ID,ITEM_ID,PRODUCT_ID,QUANTITY,UNIT_PRICE) values (24,3,258,80,1029.99);
Insert into ORDER_ITEMS (ORDER_ID,ITEM_ID,PRODUCT_ID,QUANTITY,UNIT_PRICE) values (44,6,251,82,443.64);
Insert into ORDER_ITEMS (ORDER_ID,ITEM_ID,PRODUCT_ID,QUANTITY,UNIT_PRICE) values (41,6,287,112,329.99);
Insert into ORDER_ITEMS (ORDER_ID,ITEM_ID,PRODUCT_ID,QUANTITY,UNIT_PRICE) values (28,6,208,120,1029.99);
Insert into ORDER_ITEMS (ORDER_ID,ITEM_ID,PRODUCT_ID,QUANTITY,UNIT_PRICE) values (29,9,233,71,59.99);
Insert into ORDER_ITEMS (ORDER_ID,ITEM_ID,PRODUCT_ID,QUANTITY,UNIT_PRICE) values (76,8,201,91,653.5);
Insert into ORDER_ITEMS (ORDER_ID,ITEM_ID,PRODUCT_ID,QUANTITY,UNIT_PRICE) values (81,5,55,144,150.99);
Insert into ORDER_ITEMS (ORDER_ID,ITEM_ID,PRODUCT_ID,QUANTITY,UNIT_PRICE) values (82,7,70,31,710.99);
Insert into ORDER_ITEMS (ORDER_ID,ITEM_ID,PRODUCT_ID,QUANTITY,UNIT_PRICE) values (83,7,18,49,799);
Insert into ORDER_ITEMS (ORDER_ID,ITEM_ID,PRODUCT_ID,QUANTITY,UNIT_PRICE) values (105,5,287,119,759.99);
Insert into ORDER_ITEMS (ORDER_ID,ITEM_ID,PRODUCT_ID,QUANTITY,UNIT_PRICE) values (83,7,287,66,680.99);
Insert into ORDER_ITEMS (ORDER_ID,ITEM_ID,PRODUCT_ID,QUANTITY,UNIT_PRICE) values (83,8,287,109,629.99);
Insert into ORDER_ITEMS (ORDER_ID,ITEM_ID,PRODUCT_ID,QUANTITY,UNIT_PRICE) values (83,6,285,147,873.98);
Insert into ORDER_ITEMS (ORDER_ID,ITEM_ID,PRODUCT_ID,QUANTITY,UNIT_PRICE) values (83,5,285,143,999.99);
Insert into ORDER_ITEMS (ORDER_ID,ITEM_ID,PRODUCT_ID,QUANTITY,UNIT_PRICE) values (83,9,285,135,660);
Insert into ORDER_ITEMS (ORDER_ID,ITEM_ID,PRODUCT_ID,QUANTITY,UNIT_PRICE) values (105,6,285,132,1299.73);
Insert into ORDER_ITEMS (ORDER_ID,ITEM_ID,PRODUCT_ID,QUANTITY,UNIT_PRICE) values (105,7,285,58,620.95);
Insert into ORDER_ITEMS (ORDER_ID,ITEM_ID,PRODUCT_ID,QUANTITY,UNIT_PRICE) values (101,6,285,138,719.99);
Insert into ORDER_ITEMS (ORDER_ID,ITEM_ID,PRODUCT_ID,QUANTITY,UNIT_PRICE) values (105,8,285,85,864.98);
Insert into ORDER_ITEMS (ORDER_ID,ITEM_ID,PRODUCT_ID,QUANTITY,UNIT_PRICE) values (1,10,264,147,525.99);
Insert into ORDER_ITEMS (ORDER_ID,ITEM_ID,PRODUCT_ID,QUANTITY,UNIT_PRICE) values (2,7,264,100,686.99);
Insert into ORDER_ITEMS (ORDER_ID,ITEM_ID,PRODUCT_ID,QUANTITY,UNIT_PRICE) values (3,8,264,127,948.99);
Insert into ORDER_ITEMS (ORDER_ID,ITEM_ID,PRODUCT_ID,QUANTITY,UNIT_PRICE) values (4,5,264,80,719.99);
Insert into ORDER_ITEMS (ORDER_ID,ITEM_ID,PRODUCT_ID,QUANTITY,UNIT_PRICE) values (6,3,264,90,15.55);
Insert into ORDER_ITEMS (ORDER_ID,ITEM_ID,PRODUCT_ID,QUANTITY,UNIT_PRICE) values (10,6,264,96,525.99);
Insert into ORDER_ITEMS (ORDER_ID,ITEM_ID,PRODUCT_ID,QUANTITY,UNIT_PRICE) values (10,10,264,37,1029.99);
Insert into ORDER_ITEMS (ORDER_ID,ITEM_ID,PRODUCT_ID,QUANTITY,UNIT_PRICE) values (10,8,264,264,640.99);
Insert into ORDER_ITEMS (ORDER_ID,ITEM_ID,PRODUCT_ID,QUANTITY,UNIT_PRICE) values (14,5,264,125,739.99);
Insert into ORDER_ITEMS (ORDER_ID,ITEM_ID,PRODUCT_ID,QUANTITY,UNIT_PRICE) values (15,7,83,118,829.99);
Insert into ORDER_ITEMS (ORDER_ID,ITEM_ID,PRODUCT_ID,QUANTITY,UNIT_PRICE) values (16,7,256,44,26.99);
Insert into ORDER_ITEMS (ORDER_ID,ITEM_ID,PRODUCT_ID,QUANTITY,UNIT_PRICE) values (18,5,87,103,759.99);
Insert into ORDER_ITEMS (ORDER_ID,ITEM_ID,PRODUCT_ID,QUANTITY,UNIT_PRICE) values (22,10,90,95,759.99);
Insert into ORDER_ITEMS (ORDER_ID,ITEM_ID,PRODUCT_ID,QUANTITY,UNIT_PRICE) values (23,8,241,126,1756);
Insert into ORDER_ITEMS (ORDER_ID,ITEM_ID,PRODUCT_ID,QUANTITY,UNIT_PRICE) values (24,5,41,83,299.89);
Insert into ORDER_ITEMS (ORDER_ID,ITEM_ID,PRODUCT_ID,QUANTITY,UNIT_PRICE) values (26,4,164,78,1850);

REM INSERTING into INVENTORIES
SET DEFINE OFF;
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (210,8,122);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (211,8,123);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (212,8,123);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (214,8,124);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (216,8,125);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (217,8,125);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (218,8,126);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (220,8,149);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (221,8,150);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (222,8,150);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (223,8,151);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (229,8,123);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (230,8,124);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (231,8,124);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (232,8,124);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (233,8,124);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (234,8,124);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (235,8,125);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (241,8,121);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (242,8,121);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (243,8,121);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (245,8,137);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (254,8,136);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (255,8,136);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (256,8,136);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (257,8,136);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (258,8,136);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (259,8,137);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (260,8,137);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (263,8,137);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (264,8,137);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (269,8,178);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (270,8,178);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (271,8,183);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (272,8,184);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (273,8,156);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (274,8,160);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (276,8,187);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (277,8,187);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (278,8,188);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (280,8,154);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (281,8,167);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (283,8,194);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (284,8,268);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (285,8,176);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (286,8,177);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (2,9,23);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (3,9,35);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (4,9,35);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (5,9,36);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (6,9,36);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (7,9,36);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (8,9,36);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (9,9,36);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (11,9,37);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (12,9,37);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (13,9,37);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (14,9,38);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (15,9,41);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (17,9,3);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (18,9,3);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (19,9,3);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (20,9,4);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (21,9,4);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (27,9,5);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (29,9,6);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (30,9,6);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (31,9,7);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (32,9,7);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (34,9,8);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (46,9,6);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (47,9,0);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (54,9,33);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (62,9,32);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (63,9,33);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (67,9,34);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (68,9,34);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (69,9,35);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (70,9,35);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (71,9,35);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (72,9,35);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (73,9,27);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (74,9,27);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (76,9,28);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (78,9,29);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (79,9,29);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (80,9,29);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (84,9,33);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (87,9,35);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (88,9,7);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (89,9,8);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (90,9,8);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (91,9,22);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (98,9,32);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (101,9,3);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (102,9,36);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (103,9,5);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (105,9,6);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (106,9,6);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (107,9,6);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (108,9,6);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (109,9,6);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (110,9,7);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (114,9,8);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (115,9,9);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (116,9,9);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (117,9,9);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (119,9,10);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (120,9,10);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (121,9,10);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (122,9,11);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (123,9,11);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (124,9,11);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (125,9,11);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (126,9,12);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (128,9,12);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (129,9,12);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (132,9,13);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (133,9,13);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (136,9,14);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (137,9,15);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (138,9,16);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (141,9,18);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (142,9,19);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (159,9,15);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (160,9,21);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (161,9,36);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (163,9,35);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (166,9,54);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (174,9,74);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (175,9,74);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (182,9,110);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (184,9,111);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (185,9,111);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (188,9,119);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (189,9,119);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (190,9,120);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (191,9,120);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (193,9,121);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (195,9,122);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (196,9,122);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (198,9,122);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (199,9,123);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (200,9,123);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (201,9,124);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (203,9,124);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (204,9,125);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (205,9,125);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (207,9,109);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (210,9,110);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (211,9,111);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (212,9,111);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (214,9,112);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (216,9,113);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (217,9,113);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (218,9,114);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (220,9,134);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (221,9,135);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (222,9,135);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (223,9,136);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (241,9,109);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (242,9,109);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (243,9,109);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (245,9,125);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (269,9,161);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (270,9,161);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (271,9,165);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (272,9,166);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (274,9,148);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (276,9,169);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (277,9,169);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (278,9,170);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (281,9,155);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (283,9,179);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (3,1,106);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (4,1,106);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (5,1,106);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (6,1,107);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (11,1,108);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (12,1,108);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (80,1,125);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (87,1,131);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (88,1,117);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (89,1,118);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (90,1,118);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (103,1,125);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (105,1,126);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (108,1,126);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (110,1,127);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (114,1,128);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (123,1,131);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (132,1,133);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (133,1,133);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (142,1,89);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (161,1,132);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (174,1,170);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (175,1,170);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (182,1,175);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (184,1,175);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (185,1,176);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (207,1,205);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (216,1,209);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (220,1,196);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (221,1,197);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (222,1,197);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (223,1,197);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (245,1,221);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (269,1,222);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (270,1,222);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (281,1,251);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (3,2,96);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (4,2,96);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (5,2,96);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (6,2,96);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (7,2,97);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (8,2,97);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (9,2,97);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (11,2,98);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (12,2,98);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (13,2,98);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (14,2,98);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (15,2,99);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (17,2,100);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (18,2,101);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (19,2,101);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (20,2,104);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (21,2,105);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (22,2,114);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (23,2,114);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (24,2,115);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (25,2,115);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (26,2,115);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (27,2,106);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (29,2,107);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (30,2,107);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (33,2,117);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (35,2,118);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (36,2,118);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (37,2,119);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (38,2,119);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (39,2,119);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (40,2,119);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (41,2,119);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (42,2,122);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (43,2,122);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (44,2,122);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (50,2,117);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (54,2,110);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (62,2,149);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (63,2,149);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (67,2,154);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (68,2,154);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (69,2,154);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (70,2,155);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (71,2,155);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (72,2,155);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (73,2,111);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (74,2,111);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (76,2,112);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (78,2,113);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (79,2,113);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (80,2,113);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (87,2,119);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (88,2,167);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (89,2,167);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (90,2,167);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (94,2,91);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (99,2,94);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (100,2,94);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (101,2,173);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (103,2,178);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (104,2,81);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (105,2,178);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (106,2,178);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (107,2,178);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (108,2,179);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (109,2,179);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (110,2,179);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (114,2,180);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (115,2,181);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (116,2,182);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (117,2,182);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (119,2,183);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (120,2,183);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (121,2,183);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (122,2,183);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (123,2,184);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (124,2,184);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (125,2,184);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (126,2,184);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (128,2,185);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (129,2,185);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (130,2,88);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (131,2,88);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (132,2,185);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (133,2,185);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (134,2,89);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (135,2,89);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (136,2,186);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (138,2,191);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (139,2,93);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (140,2,94);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (142,2,194);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (144,2,95);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (145,2,96);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (146,2,96);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (147,2,96);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (148,2,97);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (149,2,97);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (150,2,101);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (151,2,101);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (152,2,101);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (161,2,120);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (166,2,138);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (168,2,128);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (174,2,158);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (175,2,158);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (182,2,177);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (184,2,178);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (185,2,178);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (188,2,171);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (189,2,172);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (190,2,172);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (191,2,173);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (193,2,173);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (195,2,174);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (196,2,174);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (198,2,175);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (199,2,176);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (200,2,176);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (201,2,176);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (203,2,177);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (204,2,177);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (205,2,177);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (207,2,193);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (210,2,194);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (211,2,195);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (212,2,195);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (214,2,196);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (216,2,197);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (218,2,198);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (220,2,184);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (221,2,185);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (222,2,185);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (223,2,185);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (227,2,189);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (228,2,189);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (229,2,212);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (230,2,213);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (231,2,213);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (232,2,213);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (233,2,213);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (234,2,213);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (235,2,214);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (236,2,214);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (237,2,214);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (238,2,214);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (239,2,214);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (245,2,209);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (254,2,225);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (255,2,225);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (256,2,225);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (257,2,226);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (258,2,226);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (259,2,226);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (260,2,226);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (261,2,226);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (262,2,227);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (263,2,227);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (264,2,227);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (265,2,227);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (269,2,210);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (270,2,210);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (271,2,215);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (272,2,216);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (273,2,264);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (274,2,232);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (276,2,219);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (277,2,219);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (278,2,220);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (279,2,244);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (280,2,244);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (281,2,239);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (283,2,226);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (284,2,353);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (285,2,267);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (286,2,267);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (2,3,100);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (3,3,88);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (4,3,88);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (5,3,89);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (6,3,89);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (11,3,90);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (12,3,90);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (46,3,112);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (47,3,66);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (80,3,101);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (87,3,107);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (88,3,118);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (89,3,118);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (90,3,118);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (91,3,94);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (98,3,69);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (102,3,73);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (103,3,126);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (105,3,126);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (108,3,127);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (110,3,127);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (114,3,131);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (123,3,135);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (132,3,136);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (133,3,136);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (142,3,142);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (159,3,87);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (160,3,93);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (161,3,108);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (163,3,107);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (174,3,146);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (175,3,146);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (182,3,245);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (184,3,246);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (185,3,246);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (207,3,181);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (216,3,185);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (220,3,272);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (221,3,273);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (222,3,273);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (223,3,273);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (241,3,181);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (242,3,181);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (243,3,181);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (245,3,197);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (269,3,304);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (270,3,304);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (281,3,227);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (3,4,63);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (4,4,63);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (5,4,63);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (6,4,64);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (7,4,64);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (8,4,67);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (9,4,67);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (11,4,68);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (12,4,68);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (13,4,68);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (14,4,68);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (15,4,69);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (17,4,70);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (18,4,71);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (19,4,71);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (20,4,71);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (21,4,72);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (27,4,73);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (29,4,74);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (30,4,74);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (54,4,88);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (62,4,74);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (63,4,74);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (67,4,76);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (68,4,76);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (69,4,76);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (70,4,76);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (71,4,76);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (72,4,77);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (73,4,87);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (74,4,87);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (76,4,88);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (78,4,89);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (79,4,89);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (80,4,89);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (87,4,95);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (88,4,86);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (89,4,86);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (90,4,86);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (101,4,95);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (103,4,97);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (105,4,97);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (106,4,97);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (107,4,97);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (108,4,98);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (109,4,98);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (110,4,98);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (114,4,99);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (115,4,100);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (116,4,100);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (117,4,101);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (119,4,102);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (120,4,102);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (121,4,102);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (122,4,102);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (123,4,103);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (124,4,103);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (125,4,103);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (126,4,103);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (128,4,103);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (129,4,104);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (132,4,104);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (133,4,104);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (136,4,105);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (138,4,107);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (142,4,110);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (161,4,96);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (166,4,114);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (174,4,134);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (175,4,134);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (182,4,210);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (184,4,211);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (185,4,211);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (188,4,219);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (189,4,219);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (190,4,223);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (191,4,223);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (193,4,223);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (195,4,224);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (196,4,225);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (198,4,225);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (199,4,226);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (200,4,226);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (201,4,227);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (203,4,227);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (204,4,227);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (205,4,228);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (207,4,169);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (210,4,170);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (211,4,171);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (212,4,171);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (214,4,172);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (216,4,173);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (218,4,174);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (220,4,234);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (221,4,235);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (222,4,235);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (223,4,236);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (245,4,185);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (269,4,266);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (270,4,266);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (271,4,271);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (272,4,272);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (274,4,208);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (276,4,275);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (277,4,275);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (278,4,276);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (281,4,215);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (283,4,282);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (2,5,71);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (3,5,46);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (4,5,46);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (5,5,47);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (6,5,47);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (11,5,48);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (12,5,48);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (22,5,73);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (23,5,74);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (24,5,74);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (25,5,74);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (26,5,74);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (33,5,77);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (35,5,77);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (36,5,78);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (37,5,78);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (38,5,78);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (39,5,78);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (40,5,78);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (41,5,79);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (42,5,81);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (43,5,81);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (44,5,82);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (46,5,90);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (47,5,44);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (50,5,69);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (80,5,77);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (87,5,83);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (88,5,62);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (89,5,63);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (90,5,63);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (91,5,70);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (94,5,85);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (98,5,86);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (99,5,88);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (100,5,88);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (102,5,90);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (103,5,73);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (104,5,84);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (105,5,74);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (108,5,74);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (110,5,75);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (114,5,76);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (123,5,79);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (130,5,42);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (131,5,42);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (132,5,81);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (133,5,81);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (134,5,42);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (135,5,43);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (139,5,47);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (140,5,47);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (142,5,87);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (144,5,49);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (145,5,49);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (146,5,50);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (147,5,50);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (148,5,50);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (149,5,50);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (150,5,54);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (151,5,54);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (152,5,54);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (159,5,63);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (160,5,69);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (161,5,84);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (163,5,83);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (168,5,92);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (174,5,122);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (175,5,122);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (182,5,184);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (184,5,184);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (185,5,185);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (207,5,157);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (216,5,161);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (220,5,208);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (221,5,209);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (222,5,209);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (223,5,209);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (229,5,163);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (230,5,163);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (231,5,163);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (232,5,163);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (233,5,164);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (234,5,164);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (235,5,164);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (236,5,164);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (237,5,164);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (238,5,165);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (239,5,165);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (241,5,157);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (242,5,157);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (243,5,157);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (245,5,173);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (254,5,175);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (255,5,175);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (256,5,175);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (257,5,176);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (258,5,176);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (259,5,176);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (260,5,176);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (261,5,176);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (262,5,177);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (263,5,177);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (264,5,177);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (265,5,177);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (269,5,237);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (270,5,237);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (273,5,199);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (279,5,193);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (280,5,194);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (281,5,203);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (284,5,220);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (285,5,216);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (286,5,216);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (2,6,58);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (3,6,29);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (4,6,30);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (5,6,30);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (6,6,30);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (7,6,30);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (8,6,30);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (9,6,31);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (11,6,31);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (12,6,32);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (13,6,32);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (14,6,32);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (15,6,33);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (17,6,34);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (18,6,35);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (19,6,35);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (20,6,35);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (21,6,36);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (22,6,62);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (23,6,62);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (24,6,62);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (25,6,62);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (26,6,63);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (27,6,37);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (29,6,38);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (30,6,38);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (31,6,39);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (32,6,39);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (33,6,65);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (34,6,39);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (35,6,66);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (36,6,66);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (37,6,66);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (38,6,66);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (39,6,66);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (40,6,67);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (41,6,67);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (42,6,69);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (43,6,69);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (44,6,70);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (46,6,29);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (47,6,33);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (50,6,84);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (54,6,66);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (56,6,58);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (57,6,66);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (62,6,30);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (63,6,30);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (67,6,34);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (68,6,35);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (69,6,35);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (70,6,35);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (71,6,35);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (72,6,35);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (73,6,63);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (74,6,63);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (76,6,64);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (78,6,65);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (79,6,65);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (80,6,65);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (84,6,69);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (87,6,71);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (88,6,44);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (89,6,45);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (90,6,45);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (91,6,58);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (94,6,71);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (95,6,60);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (96,6,60);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (98,6,72);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (99,6,73);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (100,6,74);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (101,6,51);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (102,6,76);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (103,6,53);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (104,6,71);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (105,6,53);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (106,6,53);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (107,6,53);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (108,6,54);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (109,6,54);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (110,6,54);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (114,6,55);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (115,6,56);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (116,6,56);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (117,6,57);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (119,6,58);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (120,6,58);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (121,6,58);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (122,6,58);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (123,6,59);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (124,6,59);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (125,6,59);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (126,6,59);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (128,6,59);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (129,6,60);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (130,6,78);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (131,6,29);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (132,6,60);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (133,6,60);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (134,6,29);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (135,6,29);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (136,6,61);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (137,6,65);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (138,6,66);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (139,6,34);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (140,6,34);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (141,6,68);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (142,6,69);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (144,6,36);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (145,6,36);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (146,6,37);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (147,6,37);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (148,6,37);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (149,6,37);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (150,6,41);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (151,6,41);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (152,6,41);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (157,6,42);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (159,6,51);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (160,6,57);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (161,6,72);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (163,6,71);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (166,6,90);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (168,6,80);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (170,6,81);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (172,6,85);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (173,6,94);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (174,6,110);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (175,6,110);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (182,6,163);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (184,6,164);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (185,6,164);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (188,6,172);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (189,6,172);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (190,6,173);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (191,6,173);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (193,6,174);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (195,6,175);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (196,6,175);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (198,6,176);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (199,6,176);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (200,6,177);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (201,6,177);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (203,6,177);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (204,6,178);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (205,6,178);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (207,6,145);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (210,6,146);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (211,6,147);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (212,6,147);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (214,6,148);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (216,6,149);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (217,6,149);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (218,6,150);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (220,6,185);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (221,6,185);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (222,6,186);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (223,6,186);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (227,6,141);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (228,6,141);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (229,6,149);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (230,6,149);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (231,6,150);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (232,6,150);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (233,6,150);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (234,6,150);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (235,6,150);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (236,6,151);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (237,6,151);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (238,6,151);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (239,6,151);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (241,6,145);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (242,6,145);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (243,6,145);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (245,6,161);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (247,6,148);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (251,6,150);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (254,6,161);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (255,6,162);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (256,6,162);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (257,6,162);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (258,6,162);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (259,6,162);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (260,6,163);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (261,6,163);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (262,6,163);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (263,6,163);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (264,6,163);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (265,6,164);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (269,6,214);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (270,6,214);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (271,6,221);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (272,6,222);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (273,6,184);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (274,6,184);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (276,6,225);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (277,6,225);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (278,6,226);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (279,6,180);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (280,6,180);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (281,6,191);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (283,6,232);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (284,6,320);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (285,6,202);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (286,6,203);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (287,6,212);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (288,6,213);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (2,7,46);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (3,7,63);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (4,7,63);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (5,7,63);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (6,7,63);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (11,7,65);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (12,7,65);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (22,7,50);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (23,7,50);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (24,7,50);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (25,7,51);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (26,7,51);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (33,7,53);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (35,7,54);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (36,7,54);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (37,7,55);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (38,7,55);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (39,7,55);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (40,7,55);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (41,7,55);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (42,7,57);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (43,7,58);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (44,7,58);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (46,7,18);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (47,7,22);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (50,7,58);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (80,7,53);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (87,7,59);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (88,7,27);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (89,7,27);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (90,7,27);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (91,7,46);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (94,7,57);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (98,7,58);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (99,7,60);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (100,7,60);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (102,7,62);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (103,7,35);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (104,7,58);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (105,7,35);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (108,7,36);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (110,7,36);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (114,7,37);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (123,7,41);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (130,7,66);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (131,7,66);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (132,7,45);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (133,7,45);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (134,7,17);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (135,7,17);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (139,7,21);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (140,7,21);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (142,7,51);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (144,7,23);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (145,7,23);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (146,7,24);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (147,7,24);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (148,7,24);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (149,7,24);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (150,7,28);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (151,7,28);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (152,7,28);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (159,7,39);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (160,7,45);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (161,7,60);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (163,7,59);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (168,7,68);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (174,7,98);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (175,7,98);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (182,7,143);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (184,7,143);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (185,7,144);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (207,7,133);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (216,7,137);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (220,7,167);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (221,7,168);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (222,7,168);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (223,7,168);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (229,7,136);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (230,7,136);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (231,7,136);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (232,7,137);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (233,7,137);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (234,7,137);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (235,7,137);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (241,7,133);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (242,7,133);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (243,7,133);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (245,7,149);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (254,7,148);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (255,7,148);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (256,7,149);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (257,7,149);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (258,7,149);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (259,7,149);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (260,7,149);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (263,7,150);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (264,7,150);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (269,7,196);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (270,7,196);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (273,7,170);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (280,7,167);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (281,7,179);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (284,7,294);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (285,7,189);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (286,7,189);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (2,8,34);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (3,8,49);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (4,8,49);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (5,8,49);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (6,8,50);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (7,8,50);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (8,8,50);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (9,8,50);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (11,8,51);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (12,8,51);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (13,8,51);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (14,8,51);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (15,8,52);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (17,8,54);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (18,8,54);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (19,8,54);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (20,8,5);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (21,8,5);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (22,8,38);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (23,8,39);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (24,8,39);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (25,8,39);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (26,8,39);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (27,8,6);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (29,8,7);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (30,8,7);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (31,8,8);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (32,8,8);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (33,8,42);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (34,8,9);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (35,8,42);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (36,8,43);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (37,8,43);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (38,8,43);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (39,8,43);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (40,8,44);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (41,8,44);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (42,8,46);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (43,8,46);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (44,8,47);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (46,8,7);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (47,8,11);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (50,8,32);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (54,8,44);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (62,8,47);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (63,8,47);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (67,8,49);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (68,8,49);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (69,8,50);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (70,8,50);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (71,8,50);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (72,8,50);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (73,8,39);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (74,8,39);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (76,8,40);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (78,8,41);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (79,8,41);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (80,8,41);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (84,8,45);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (87,8,47);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (88,8,12);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (89,8,12);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (90,8,13);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (91,8,34);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (94,8,44);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (98,8,45);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (99,8,47);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (100,8,47);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (101,8,18);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (102,8,49);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (103,8,20);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (104,8,46);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (105,8,20);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (106,8,21);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (107,8,21);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (108,8,21);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (109,8,21);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (110,8,22);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (114,8,23);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (115,8,24);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (116,8,24);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (117,8,24);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (119,8,25);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (120,8,25);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (121,8,25);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (122,8,26);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (123,8,26);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (124,8,26);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (125,8,26);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (126,8,26);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (128,8,27);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (129,8,27);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (130,8,53);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (131,8,53);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (132,8,28);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (133,8,28);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (134,8,54);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (135,8,54);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (136,8,28);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (137,8,29);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (138,8,31);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (139,8,8);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (140,8,9);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (141,8,33);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (142,8,34);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (144,8,10);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (145,8,11);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (146,8,11);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (147,8,11);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (148,8,12);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (149,8,12);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (150,8,15);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (151,8,15);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (152,8,15);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (159,8,27);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (160,8,33);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (161,8,48);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (163,8,47);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (166,8,66);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (168,8,56);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (174,8,86);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (175,8,86);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (182,8,128);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (184,8,128);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (185,8,129);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (188,8,137);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (189,8,137);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (190,8,137);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (191,8,138);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (193,8,138);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (195,8,139);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (196,8,139);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (198,8,140);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (199,8,141);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (200,8,141);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (201,8,142);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (203,8,142);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (204,8,142);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (205,8,142);
Insert into INVENTORIES (PRODUCT_ID,WAREHOUSE_ID,QUANTITY) values (207,8,121);

SELECT * FROM INVENTORIES;


--1. Create the plsql block to adjust the salary form 7900 to 9000 whose empid is 122.

DECLARE
  v_employee_id EMPLOYEES.EMPLOYEE_ID%TYPE := 122;
BEGIN
  UPDATE EMPLOYEES
  SET SALARY = 9000
  WHERE EMPLOYEE_ID = v_employee_id;

  COMMIT;
  DBMS_OUTPUT.PUT_LINE('Salary updated successfully.');
EXCEPTION
  WHEN NO_DATA_FOUND THEN
    DBMS_OUTPUT.PUT_LINE('Employee with ID ' || v_employee_id || ' not found.');
  WHEN OTHERS THEN
    DBMS_OUTPUT.PUT_LINE('An error occurred: ' || SQLERRM);
END;


Select employee_id, Salary from employees where employee_id = 122;
  
  
  
DECLARE
  CURSOR c_managers IS
    SELECT employee_id, first_name, last_name
    FROM employees
    WHERE manager_id IS NOT NULL;
  
  v_employee_id employees.employee_id%TYPE;
  v_first_name  employees.first_name%TYPE;
  v_last_name   employees.last_name%TYPE;
BEGIN
  OPEN c_managers;
  
  LOOP
    FETCH c_managers INTO v_employee_id, v_first_name, v_last_name;
    EXIT WHEN c_managers%NOTFOUND;
    
    -- Print the manager details
    DBMS_OUTPUT.PUT_LINE('Manager ID: ' || v_employee_id);
    DBMS_OUTPUT.PUT_LINE('Name: ' || v_first_name || ' ' || v_last_name);
    DBMS_OUTPUT.PUT_LINE('---------------------------');
  END LOOP;
  
  CLOSE c_managers;
END;
/

--Print a list of managers using PL/SQL explicit cursors.

SET SERVEROUTPUT ON;
DECLARE
  -- PL/SQL block content here
    CURSOR c_managers IS
    SELECT employee_id, first_name, last_name
    FROM employees
    WHERE manager_id IS NOT NULL;
  
  v_employee_id employees.employee_id%TYPE;
  v_first_name  employees.first_name%TYPE;
  v_last_name   employees.last_name%TYPE;
BEGIN
  -- PL/SQL block execution here
  OPEN c_managers;
  
  LOOP
    FETCH c_managers INTO v_employee_id, v_first_name, v_last_name;
    EXIT WHEN c_managers%NOTFOUND;
    
    -- Print the manager details
    DBMS_OUTPUT.PUT_LINE('Manager ID: ' || v_employee_id);
    DBMS_OUTPUT.PUT_LINE('Name: ' || v_first_name || ' ' || v_last_name);
    DBMS_OUTPUT.PUT_LINE('---------------------------');
  END LOOP;
  
  CLOSE c_managers;
END;
/

-- Create a PL/SQL cursor to calculate total salary from employees table without using sum() function

SET SERVEROUTPUT ON;
DECLARE
    CURSOR c_employees IS
    SELECT salary
    FROM employees;
  
  v_salary employees.salary%TYPE;
  v_total_salary NUMBER := 0;
BEGIN
  OPEN c_employees;
  
  LOOP
    FETCH c_employees INTO v_salary;
    EXIT WHEN c_employees%NOTFOUND;
    
    -- Accumulate the salary
    v_total_salary := v_total_salary + v_salary;
  END LOOP;
  
  CLOSE c_employees;
  
  -- Print the total salary
  DBMS_OUTPUT.PUT_LINE('Total Salary: ' || v_total_salary);
END;
/
-- Display the name and salary of each employee in the employees table whose salary is less than passed in parameter value

CREATE OR REPLACE PROCEDURE display_employees(p_salary_limit IN NUMBER) IS
  CURSOR c_employees IS
    SELECT first_name, last_name, salary
    FROM employees
    WHERE salary < p_salary_limit;
  
  v_first_name employees.first_name%TYPE;
  v_last_name employees.last_name%TYPE;
  v_salary NUMBER(20,5);
BEGIN
  OPEN c_employees;
  
  LOOP
    FETCH c_employees INTO v_first_name, v_last_name, v_salary;
    EXIT WHEN c_employees%NOTFOUND;
    
    -- Display the employee name and salary
    DBMS_OUTPUT.PUT_LINE('Employee: ' || v_first_name || ' ' || v_last_name || ', Salary: ' || v_salary);
  END LOOP;
  
  CLOSE c_employees;
END;
/


SET SERVEROUTPUT ON;
BEGIN
  display_employees(6000); 
END;
/
--
--display the name of the employee and increment percentage of salary according to their working experiences 

CREATE OR REPLACE PROCEDURE display_salary_increment AS
  CURSOR c_employees IS
    SELECT employee_id, first_name, last_name, hire_date, salary
    FROM employees;
  
  v_employee_id employees.employee_id%TYPE;
  v_first_name employees.first_name%TYPE;
  v_last_name employees.last_name%TYPE;
  v_hire_date employees.hire_date%TYPE;
  v_salary employees.salary%TYPE;
  v_increment_percentage NUMBER(5, 2);
BEGIN
  OPEN c_employees;
  
  LOOP
    FETCH c_employees INTO v_employee_id, v_first_name, v_last_name, v_hire_date, v_salary;
    EXIT WHEN c_employees%NOTFOUND;
    
    -- Calculate increment percentage based on working experience
    v_increment_percentage := CASE
      WHEN MONTHS_BETWEEN(SYSDATE, v_hire_date) < 12 THEN 5
      WHEN MONTHS_BETWEEN(SYSDATE, v_hire_date) < 24 THEN 10
      ELSE 15
    END;
    
    -- Calculate the incremented salary
    v_salary := v_salary + (v_salary * v_increment_percentage / 100);
    
    -- Display the employee name and incremented salary
    DBMS_OUTPUT.PUT_LINE('Employee: ' || v_first_name || ' ' || v_last_name || ', Incremented Salary: ' || v_salary
    || ',Increment_percent:     ' || v_increment_percentage);
  END LOOP;
  
  CLOSE c_employees;
END;
/

SET SERVEROUTPUT ON;
BEGIN
display_salary_increment;
END;
/

--display the number of employees by month

CREATE OR REPLACE PROCEDURE display_employees_by_month IS
BEGIN
  FOR i IN 1..12 LOOP
    DECLARE
      v_employee_count NUMBER;
    BEGIN
      SELECT COUNT(*) INTO v_employee_count
      FROM employees
      WHERE EXTRACT(MONTH FROM hire_date) = i;
      
      DBMS_OUTPUT.PUT_LINE('Month ' || i || ': ' || v_employee_count || ' employees');
    END;
  END LOOP;
END;
/

SET SERVEROUTPUT ON;
BEGIN
display_employees_by_month;
END;
/


--CREATE plsql block to insert records from employee table to another table

CREATE TABLE target_table (
  job_title VARCHAR2(255),
  salary number(20,5)
);

SET SERVEROUTPUT ON;
DECLARE
  CURSOR c_employees IS
    SELECT *
    FROM employees;
    
  v_employee employees%ROWTYPE;
BEGIN
  -- Open the cursor
  OPEN c_employees;
  
  -- Fetch each record from the cursor and insert into the target table
  LOOP
    FETCH c_employees INTO v_employee;
    EXIT WHEN c_employees%NOTFOUND;
    
    -- Insert into the target table
    INSERT INTO target_table (job_title, salary)
    VALUES (v_employee.job_title, v_employee.salary);
  END LOOP;
  
  -- Close the cursor
  CLOSE c_employees;
  
  -- Commit the changes
  COMMIT;
  
  -- Display success message
  DBMS_OUTPUT.PUT_LINE('Records inserted successfully.');
EXCEPTION
  WHEN OTHERS THEN
    -- Display error message
    DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
    -- Rollback changes
    ROLLBACK;
END;
/

SELECT DISTINCT job_title, salary
FROM target_table;

--create the plsql package to calculate the net value of the ordered items  done by a particular customer in a specific year

CREATE OR REPLACE PACKAGE order_net_value_pkg IS
  -- Procedure to calculate the net value of ordered items by customer and year
  PROCEDURE calculate_net_value(
    p_customer_id IN NUMBER,
    p_year IN NUMBER,
    p_net_value OUT NUMBER
  );
END order_net_value_pkg;
/

CREATE OR REPLACE PACKAGE BODY order_net_value_pkg IS
  -- Procedure implementation to calculate the net value of ordered items
  PROCEDURE calculate_net_value(
    p_customer_id IN NUMBER,
    p_year IN NUMBER,
    p_net_value OUT NUMBER
  ) IS
  BEGIN
    SELECT SUM(order_items.quantity * order_items.unit_price)
    INTO p_net_value
    FROM orders
    JOIN order_items ON orders.order_id = order_items.order_id
    WHERE orders.customer_id = p_customer_id
      AND EXTRACT(YEAR FROM orders.order_date) = p_year;
  EXCEPTION
    WHEN NO_DATA_FOUND THEN
      p_net_value := 0;
  END calculate_net_value;
END order_net_value_pkg;
/

DECLARE
  v_customer_id NUMBER := 44; -- Replace with the desired customer ID
  v_year NUMBER := 2017; -- Replace with the desired year
  v_net_value NUMBER;
BEGIN
  order_net_value_pkg.calculate_net_value(v_customer_id, v_year, v_net_value);
  DBMS_OUTPUT.PUT_LINE('Net Value: ' || v_net_value);
END;
/

--display the first 10 customers using nested table

DECLARE
  TYPE customer_list IS TABLE OF contacts%ROWTYPE;
  v_customers customer_list;
BEGIN
  SELECT *
  BULK COLLECT INTO v_customers
  FROM contacts
  WHERE ROWNUM <= 10;

  FOR i IN 1..v_customers.COUNT LOOP
    DBMS_OUTPUT.PUT_LINE('Customer ID: ' || v_customers(i).customer_id);
    DBMS_OUTPUT.PUT_LINE('First Name: ' || v_customers(i).first_name);
    DBMS_OUTPUT.PUT_LINE('Last Name: ' || v_customers(i).last_name);
    DBMS_OUTPUT.PUT_LINE('Email: ' || v_customers(i).email);
    DBMS_OUTPUT.PUT_LINE('Phone Number: ' || v_customers(i).phone);
    -- Display other desired customer information

    DBMS_OUTPUT.PUT_LINE('-----------------------');
  END LOOP;
END;
/
--fetch the data from employees table for employee_id '1001' using native dynamic sql (execute immediate)
DECLARE
  v_employee_id NUMBER := 1001;
  v_sql VARCHAR2(200);
  v_first_name employees.first_name%TYPE;
  v_last_name employees.last_name%TYPE;
  v_salary employees.salary%TYPE;
BEGIN
  v_sql := 'SELECT first_name, last_name, salary FROM employees WHERE employee_id = :emp_id';

  EXECUTE IMMEDIATE v_sql INTO v_first_name, v_last_name, v_salary USING v_employee_id;

  DBMS_OUTPUT.PUT_LINE('Employee ID: ' || v_employee_id);
  DBMS_OUTPUT.PUT_LINE('First Name: ' || v_first_name);
  DBMS_OUTPUT.PUT_LINE('Last Name: ' || v_last_name);
  DBMS_OUTPUT.PUT_LINE('Salary: ' || v_salary);
EXCEPTION
  WHEN NO_DATA_FOUND THEN
    DBMS_OUTPUT.PUT_LINE('Employee not found.');
END;
/
--Using DBMS_SQL

DECLARE
  v_employee_id NUMBER := 1001;
  v_sql VARCHAR2(200);
  v_cursor_id INTEGER;
  v_first_name employees.first_name%TYPE;
  v_last_name employees.last_name%TYPE;
  v_salary employees.salary%TYPE;
BEGIN
  v_sql := 'SELECT first_name, last_name, salary FROM employees WHERE employee_id = :emp_id';

  v_cursor_id := DBMS_SQL.OPEN_CURSOR;

  DBMS_SQL.PARSE(v_cursor_id, v_sql, DBMS_SQL.NATIVE);
  DBMS_SQL.BIND_VARIABLE(v_cursor_id, ':emp_id', v_employee_id);

  IF DBMS_SQL.EXECUTE(v_cursor_id) > 0 THEN
    DBMS_SQL.DEFINE_COLUMN(v_cursor_id, 1, v_first_name, 100);
    DBMS_SQL.DEFINE_COLUMN(v_cursor_id, 2, v_last_name, 100);
    DBMS_SQL.DEFINE_COLUMN(v_cursor_id, 3, v_salary);

    IF DBMS_SQL.FETCH_ROWS(v_cursor_id) > 0 THEN
      LOOP
        EXIT WHEN DBMS_SQL.FETCH_ROWS(v_cursor_id) = 0;
        DBMS_SQL.COLUMN_VALUE(v_cursor_id, 1, v_first_name);
        DBMS_SQL.COLUMN_VALUE(v_cursor_id, 2, v_last_name);
        DBMS_SQL.COLUMN_VALUE(v_cursor_id, 3, v_salary);

        DBMS_OUTPUT.PUT_LINE('Employee ID: ' || v_employee_id);
        DBMS_OUTPUT.PUT_LINE('First Name: ' || v_first_name);
        DBMS_OUTPUT.PUT_LINE('Last Name: ' || v_last_name);
        DBMS_OUTPUT.PUT_LINE('Salary: ' || v_salary);
      END LOOP;
    ELSE
      DBMS_OUTPUT.PUT_LINE('Employee not found.');
    END IF;
  END IF;

  DBMS_SQL.CLOSE_CURSOR(v_cursor_id);
EXCEPTION
  WHEN OTHERS THEN
    DBMS_SQL.CLOSE_CURSOR(v_cursor_id);
    RAISE;
END;
/

--Create a statement level trigger, when CRUD operatons is performed on employees table

Set SERVEROUTPUT ON;
CREATE OR REPLACE TRIGGER employees_trigger
AFTER INSERT OR UPDATE OR DELETE ON employees
DECLARE
  v_operation VARCHAR2(10);
BEGIN
  IF INSERTING THEN
    v_operation := 'INSERT';
  ELSIF UPDATING THEN
    v_operation := 'UPDATE';
  ELSIF DELETING THEN
    v_operation := 'DELETE';
  END IF;
  
  DBMS_OUTPUT.PUT_LINE('CRUD operation (' || v_operation || ') performed on employees table');
END;
/
Insert into EMPLOYEES (EMPLOYEE_ID,FIRST_NAME,LAST_NAME,EMAIL,PHONE,HIRE_DATE,MANAGER_ID,JOB_TITLE,SALARY) values
(1011,'Tommy','Bailey','tommy.bailey@example.com','515.123.4567',to_date('17-JUN-16','DD-MON-RR'),null,'President',10000);






  
  
  
  
  
  
  
