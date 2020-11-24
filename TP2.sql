-------------------------QST1--------------------------
SET SERVEROUTPUT ON;
DECLARE 

CURSOR c_employee IS
SELECT * FROM EMPLOYEES;

v_manager EMPLOYEES.LAST_NAME%TYPE;

BEGIN

FOR i IN c_employee LOOP
DBMS_OUTPUT.PUT_LINE('Employé '||i.FIRST_NAME||'_'||i.LAST_NAME||'(ID : '||i.EMPLOYEE_ID||')travaille comme '||
i.JOB_TITLE||' depuis '||i.HIRE_DATE);

  IF i.MANAGER_ID IS NOT NULL THEN 
  SELECT LAST_NAME INTO v_manager FROM EMPLOYEES WHERE EMPLOYEE_ID=i.MANAGER_ID;
  DBMS_OUTPUT.PUT_LINE('sous la direction de '||v_manager ||'(matricule : '||i.MANAGER_ID||').');
  END IF;
  DBMS_OUTPUT.PUT_LINE('*********************************************************************');
  
END LOOP;

END;
----------------------------QST2--------------------------
SET SERVEROUTPUT ON;
DECLARE 

CURSOR c_customers(v_customer_id ORDERS.CUSTOMER_ID%TYPE)IS
SELECT COUNT(*)  FROM ORDERS WHERE CUSTOMER_ID=v_customer_id;

CURSOR c_salesman(v_salesman_id ORDERS.SALESMAN_ID%TYPE)IS
SELECT COUNT(*)  FROM ORDERS WHERE SALESMAN_ID=v_salesman_id;

v_id_1 ORDERS.CUSTOMER_ID%TYPE:='&v_id_1';
v_id_2 ORDERS.SALESMAN_ID%TYPE:='&v_id_2';

nbr1 INT;
nbr2 INT;
BEGIN

OPEN c_customers(v_id_1);
FETCH c_customers INTO nbr1;

DBMS_OUTPUT.PUT_LINE('le nombre de commande de client id :'||v_id_1||' est : '||nbr1||'.');
CLOSE c_customers;

OPEN c_salesman(v_id_2);
FETCH c_salesman INTO nbr2;
DBMS_OUTPUT.PUT_LINE('le nombre de ventes d employee id :'||v_id_2||' est : '||nbr2||'.');
CLOSE c_salesman;

END;
-------------------------QST3------------------------------
SET SERVEROUTPUT ON;
DECLARE 

CURSOR c_customers IS
SELECT CUSTOMER_ID ,SUM(QUANTITY*UNIT_PRICE)
FROM ORDERS
INNER JOIN ORDER_ITEMS USING(ORDER_ID)
GROUP BY CUSTOMER_ID
HAVING SUM(QUANTITY*UNIT_PRICE)>2000;

C INT;
BEGIN
C:=0;
FOR i IN c_customers LOOP
UPDATE CUSTOMERS SET CREDIT_LIMIT = CREDIT_LIMIT+50
WHERE CUSTOMER_ID=i.CUSTOMER_ID;
C:=C+1;
END LOOP;
--DBMS_OUTPUT.PUT_LINE('Le nombre de lignes affectées est : '||c_customers%ROWCOUNT);--
DBMS_OUTPUT.PUT_LINE('Le nombre de lignes affectées est : '||C);

END;
----------------------------QST4-------------------------------
SET SERVEROUTPUT ON;
DECLARE 

CURSOR c_customers IS
SELECT CUSTOMER_ID ,SUM(QUANTITY*UNIT_PRICE)
FROM ORDERS
INNER JOIN ORDER_ITEMS USING(ORDER_ID)
GROUP BY CUSTOMER_ID
HAVING SUM(QUANTITY*UNIT_PRICE)>10000;

C INT;
BEGIN
C:=0;
FOR i IN c_customers LOOP
UPDATE CUSTOMERS SET CREDIT_LIMIT = CREDIT_LIMIT+50
WHERE CUSTOMER_ID=i.CUSTOMER_ID;
C:=C+1;
END LOOP;
--DBMS_OUTPUT.PUT_LINE('Le nombre de lignes affectées est : '||c_customers%ROWCOUNT);--
DBMS_OUTPUT.PUT_LINE('Le nombre de lignes affectées est : '||C);

END;
-----------------------QST5-------------------------------------------
SET SERVEROUTPUT ON;
DECLARE
v_date_start ORDERS.ORDER_DATE%TYPE;
v_date_end ORDERS.ORDER_DATE%TYPE;
v_salesman_id ORDERS.SALESMAN_ID%TYPE;
somme_total NUMBER;
taux DECIMAL(10,2);

CURSOR c_ventes IS
SELECT SUM(QUANTITY*UNIT_PRICE) as ventes FROM ORDERS 
INNER JOIN ORDER_ITEMS USING(ORDER_ID)
WHERE SALESMAN_ID = v_salesman_id 
AND ORDER_DATE BETWEEN v_date_start AND v_date_end;

BEGIN
v_salesman_id:=&v_salesman_id;
v_date_start:='&v_date_start';
v_date_end:='&v_date_end';

SELECT SUM(QUANTITY*UNIT_PRICE) INTO somme_total FROM ORDERS
INNER JOIN ORDER_ITEMS USING(ORDER_ID)
WHERE ORDER_DATE BETWEEN v_date_start AND v_date_end;

FOR i IN c_ventes LOOP
taux:=i.ventes/somme_total;
DBMS_OUTPUT.PUT_LINE('le taux de l employee ID : '|| v_salesman_id ||' est '||taux||'%');

END LOOP;
END;
-----------------------QST6-------------------------------------------
SET SERVEROUTPUT ON;
DECLARE

CURSOR C_ventes IS
SELECT EMPLOYEE_ID, ventes 
FROM EMPLOYEES  
INNER JOIN (SELECT SALESMAN_ID, COUNT(*) AS ventes FROM ORDERS GROUP BY SALESMAN_ID)
orders ON ORDERS.SALESMAN_ID=EMPLOYEES.EMPLOYEE_ID where MANAGER_ID='&MANAGER_ID';

r_ventes C_ventes%ROWTYPE;

BEGIN

OPEN C_ventes;
LOOP

FETCH C_ventes  into r_ventes;
EXIT When C_ventes%NOTFOUND;

dbms_output.put_line('Employee id  : ' || r_ventes.EMPLOYEE_ID  || ' ' || '---> ventes : ' || r_ventes.ventes);

END LOOP;

CLOSE C_ventes;
END;