--Question 1:
SET SERVEROUTPUT ON;
DECLARE
v_nom VARCHAR(20);
v_prenom VARCHAR(20);
BEGIN
v_nom :='&v_nom';
v_prenom :='&v_prenom';
DBMS_OUTPUT.PUT_LINE('Bienvenue '|| v_nom ||' '|| v_prenom);
END;

-- QUESTION 2 3 4 
SET SERVEROUTPUT ON;
DECLARE
v_total INTEGER;
v_count INTEGER;
v_pro INTEGER;
BEGIN
SELECT COUNT(*) 
INTO v_total
FROM employees;
SELECT COUNT(*)
INTO v_count
FROM employees
WHERE MANAGER_ID = 1;
v_pro := (v_count*100)/v_total;
DBMS_OUTPUT.PUT_LINE('La proportion est :'|| v_pro);
END;

--QUESTION 5
SET SERVEROUTPUT ON;
DECLARE
v_last_name  employees.LAST_NAME%TYPE;
v_first_name  employees. FIRST_NAME%TYPE;
v_hire_date  employees. HIRE_DATE%TYPE;
v_id employees. EMPLOYEE_ID%TYPE;
BEGIN
v_id := '& v_id';
SELECT LAST_NAME, FIRST_NAME, HIRE_DATE
INTO v_last_name, v_first_name , v_hire_date
FROM employees 
WHERE EMPLOYEE_ID = v_id;
DBMS_OUTPUT.PUT_LINE('LAST NAME : ' || v_last_name ) ;
DBMS_OUTPUT.PUT_LINE('FIRST_NAME : ' || v_first_name) ;
DBMS_OUTPUT.PUT_LINE('HIRE_DATE : ' || v_hire_date) ;
END;

--QUESTION 6
SET SERVEROUTPUT ON;
DECLARE
TYPE r_employee_type IS record (
last_name employees.LAST_NAME%TYPE, 
first_name employees.FIRST_NAME%TYPE,
hire_date employees.HIRE_DATE%TYPE);

r_employee r_employee_type;
BEGIN
SELECT LAST_NAME, FIRST_NAME, HIRE_DATE
INTO r_employee  
FROM employees 
WHERE rownum <= 1;
DBMS_OUTPUT.PUT_LINE('LAST NAME : ' || r_employee. last_name);
DBMS_OUTPUT.PUT_LINE('FIRST_NAME : ' || r_employee. first_name) ;
DBMS_OUTPUT.PUT_LINE('HIRE_DATE : ' || r_employee. hire_date) ;
END;  

--QUESTION 7
SET SERVEROUTPUT ON;
DECLARE
r_produit products%ROWTYPE;
v_id products.PRODUCT_ID%TYPE;
BEGIN
v_id := '&v_id';
SELECT * INTO r_produit
FROM products
WHERE PRODUCT_ID  =  v_id;
dbms_output.put_line('PRODUCT_ID : ' || r_produit.PRODUCT_ID);
dbms_output.put_line('PRODUCT_NAME : ' || r_produit.PRODUCT_NAME);
dbms_output.put_line('DESCRIPTION : ' || r_produit.DESCRIPTION);
dbms_output.put_line('STANDARD_COST : ' || r_produit.STANDARD_COST);
dbms_output.put_line('LIST_PRICE : ' || r_produit.LIST_PRICE);
dbms_output.put_line('CATEGORY_ID : ' || r_produit.CATEGORY_ID);
END;

--QUESTION 8
SET SERVEROUTPUT ON;
DECLARE

r_emp employees%ROWTYPE;
v_id employees.EMPLOYEE_ID%TYPE;
BEGIN
v_id := '&v_id';
SELECT * INTO r_emp
FROM employees
WHERE EMPLOYEE_ID  =  v_id;

DBMS_OUTPUT.PUT_LINE('EMPLOYEE_ID : '||r_emp.EMPLOYEE_ID);
DBMS_OUTPUT.PUT_LINE('FIRST_NAME : '||r_emp.FIRST_NAME);
DBMS_OUTPUT.PUT_LINE('LAST_NAME : '||r_emp.LAST_NAME);
DBMS_OUTPUT.PUT_LINE('EMAIL : '||r_emp.EMAIL);
DBMS_OUTPUT.PUT_LINE('PHONE : '||r_emp.PHONE);
DBMS_OUTPUT.PUT_LINE('HIRE_DATE : '||r_emp.HIRE_DATE);
DBMS_OUTPUT.PUT_LINE('JOB_TITLE : '||r_emp.JOB_TITLE);
DBMS_OUTPUT.PUT_LINE('MANAGER_ID : '||r_emp.MANAGER_ID);

END;

--QUESTION 9
SET SERVEROUTPUT ON;
DECLARE
v_id NUMBER;
r_cstmr CUSTOMERS%ROWTYPE;
TYPE r_order_type IS RECORD(
V_ORDER_ID ORDERS.ORDER_ID%TYPE,
V_CUSTOMER_ID ORDERS.CUSTOMER_ID%TYPE,
V_STATUS ORDERS.STATUS%TYPE,
V_SALESMAN_ID ORDERS.SALESMAN_ID%TYPE,
V_ORDER_DATE ORDERS.ORDER_DATE%TYPE
);
r_order r_order_type;
Type ordr_type is TABLE of r_order_type;
ordr ordr_type := ordr_type();
cursor c_orders is 
Select * 
from orders
where customer_id = v_id;
indice NUMBER := 1;
BEGIN
 v_id := '& v_id'; 
 FOR r_order IN c_orders LOOP
 EXIT WHEN c_orders%NOTFOUND;
 ordr.extend;
 ordr(indice) := r_order;
 indice := indice+1;
DBMS_OUTPUT.PUT_LINE(' ORDER_ID :'||r_order.ORDER_ID||' CUSTOMER_ID :'||r_order.CUSTOMER_ID||' STATUS :'||r_order.STATUS||' SALESMAN_ID :'||r_order.SALESMAN_ID||' ORDER_DATE :'||r_order.ORDER_DATE);
END LOOP;
END;
