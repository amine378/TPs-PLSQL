-----------QST1-----------

SET SERVEROUTPUT ON;
DECLARE
v_nom char(50);
v_prenom char(50);
BEGIN
v_nom:= '&v_nom';
v_prenom:='&v_prenom';
dbms_output.put_line('Le nom  est: ' ||v_nom);
dbms_output.put_line('Le prenom  est: ' ||v_prenom);
END;

-----------QST2--------------

SET SERVEROUTPUT ON;
DECLARE
v_nbr_total INT;
BEGIN
SELECT COUNT(*) INTO v_nbr_total FROM EMPLOYEES;
dbms_output.put_line('Le nombre total des employees est : '||v_nbr_total);
END;

-------------QST3-------------

SET SERVEROUTPUT ON;
DECLARE
v_nbr_id INT;
BEGIN
SELECT COUNT(*) INTO v_nbr_id FROM EMPLOYEES WHERE MANAGER_ID=1;
dbms_output.put_line('Le nombre total des employees est : '||v_nbr_id);
END;

----------QST4-------------

SET SERVEROUTPUT ON;
DECLARE
v_nbr_total INT;
v_nbr_id INT;
v_prctg decimal(10,2);
BEGIN
SELECT COUNT(*) INTO v_nbr_total FROM EMPLOYEES;
SELECT COUNT(*) INTO v_nbr_id FROM EMPLOYEES WHERE MANAGER_ID=1;
v_prctg:=( v_nbr_id /v_nbr_total)*100;
dbms_output.put_line('Le pourcentage est : '||v_prctg);
END;

-----------QST5------------
SET SERVEROUTPUT ON;
DECLARE 
v_last_name EMPLOYEES.LAST_NAME%TYPE;
v_first_name EMPLOYEES.FIRST_NAME%TYPE;
v_hire_date EMPLOYEES.HIRE_DATE%TYPE;
v_id EMPLOYEES.EMPLOYEE_ID%TYPE;
BEGIN
v_id:='&v_id';
SELECT LAST_NAME,FIRST_NAME,HIRE_DATE INTO v_last_name,v_first_name,v_hire_date
FROM EMPLOYEES
WHERE EMPLOYEE_ID=v_id;
dbms_output.put_line(v_last_name||','||v_first_name||','||v_hire_date||'.');
END;

------------QST6--------------
SET SERVEROUTPUT ON;
DECLARE
TYPE r_employee IS RECORD(
v_last_name EMPLOYEES.LAST_NAME%TYPE,
v_first_name EMPLOYEES.FIRST_NAME%TYPE,
v_hire_date EMPLOYEES.HIRE_DATE%TYPE);
emp r_employee;
v_id EMPLOYEES.EMPLOYEE_ID%TYPE;
BEGIN
v_id:='&v_id';
SELECT LAST_NAME,FIRST_NAME,HIRE_DATE 
INTO emp 
FROM EMPLOYEES
WHERE EMPLOYEE_ID =v_id;
dbms_output.put_line(emp.v_last_name||','||emp.v_first_name||','||emp.v_hire_date);
END;
---------------QST7 methode1-------------
SET SERVEROUTPUT ON;
DECLARE
TYPE r_prod IS RECORD(
v_product_id PRODUCTS.PRODUCT_ID%TYPE,
v_product_name PRODUCTS.PRODUCT_NAME%TYPE,
v_description PRODUCTS.DESCRIPTION%TYPE,
v_standard_cost PRODUCTS.STANDARD_COST%TYPE,
v_list_price PRODUCTS.LIST_PRICE%TYPE,
v_category_id PRODUCTS.CATEGORY_ID%TYPE);
prod r_prod;
nbr number;
BEGIN
prod.v_product_id:=&nbr;
SELECT PRODUCT_ID,PRODUCT_NAME,DESCRIPTION,STANDARD_COST,LIST_PRICE,CATEGORY_ID 
INTO prod 
FROM PRODUCTS 
WHERE PRODUCT_ID=prod.v_product_id;
dbms_output.put_line(prod.v_product_id||','||prod.v_product_name||','||prod.v_description||','||prod.v_standard_cost||','||
prod.v_list_price||','||prod.v_category_id);
END;
-------------QST7methode2-----------------------
SET SERVEROUTPUT ON;
DECLARE
prod PRODUCTS%ROWTYPE;
nbr number;
BEGIN
prod.product_id:=&nbr;
SELECT PRODUCT_ID,PRODUCT_NAME,DESCRIPTION,STANDARD_COST,LIST_PRICE,CATEGORY_ID 
INTO prod 
FROM PRODUCTS 
WHERE PRODUCT_ID=prod.product_id;
dbms_output.put_line(prod.product_id||','||prod.product_name||','||prod.description||','||prod.standard_cost||','||
prod.list_price||','||prod.category_id);
END;
-----------QST8--------------------------
SET SERVEROUTPUT ON;
DECLARE

r_mgr EMPLOYEES%ROWTYPE;
r_emp EMPLOYEES%ROWTYPE;
nbr INT;

BEGIN

r_emp.EMPLOYEE_ID:=&nbr;

SELECT EMPLOYEE_ID,FIRST_NAME,LAST_NAME,EMAIL,PHONE,HIRE_DATE,MANAGER_ID,JOB_TITLE
INTO r_emp.EMPLOYEE_ID,r_emp.FIRST_NAME,r_emp.LAST_NAME,r_emp.EMAIL,r_emp.PHONE,r_emp.HIRE_DATE,r_mgr.MANAGER_ID,r_emp.JOB_TITLE
FROM EMPLOYEES 
WHERE EMPLOYEE_ID = r_emp.EMPLOYEE_ID;

dbms_output.put_line('L employee est: ');
dbms_output.put_line(r_emp.EMPLOYEE_ID||','||r_emp.FIRST_NAME||','||r_emp.LAST_NAME||','||r_emp.EMAIL||','||r_emp.PHONE
||','||r_emp.HIRE_DATE||','||r_emp.JOB_TITLE);
dbms_output.put_line('Son manager est: ');

SELECT EMPLOYEE_ID,FIRST_NAME,LAST_NAME,EMAIL,PHONE,HIRE_DATE,JOB_TITLE
INTO r_mgr.EMPLOYEE_ID,r_mgr.FIRST_NAME,r_mgr.LAST_NAME,r_mgr.EMAIL,r_mgr.PHONE,r_mgr.HIRE_DATE,r_mgr.JOB_TITLE
FROM EMPLOYEES
WHERE EMPLOYEE_ID = r_mgr.MANAGER_ID;

dbms_output.put_line(r_mgr.EMPLOYEE_ID||','||r_mgr.FIRST_NAME||','||r_mgr.LAST_NAME||','||r_mgr.EMAIL||','||r_mgr.PHONE
||','||r_mgr.HIRE_DATE||','||r_mgr.JOB_TITLE);
END;
