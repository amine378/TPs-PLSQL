--QUESTION 1
SET SERVEROUTPUT ON;
DECLARE
cursor c_employees is
SELECT * FROM EMPLOYEES;
r_employees c_employees%ROWTYPE;
BEGIN
FOR r_employees IN c_employees LOOP
DBMS_OUTPUT.PUT_LINE('Employe : ' || r_employees.FIRST_NAME ||' '|| r_employees.LAST_NAME ||'( ID : '|| r_employees.EMPLOYEE_ID || ')travaille comme ' || r_employees.JOB_TITLE || ' depuis ' || r_employees.HIRE_DATE || ' sous la direction d un manager avec la matricule : ' ||r_employees.MANAGER_ID||').');
EXIT WHEN c_employees%NOTFOUND;
END LOOP;
END;
--QUESTION2
SET SERVEROUTPUT ON;
DECLARE
v_id INTEGER;
total INTEGER;
cursor c_customers is
SELECT *
FROM ORDERS
WHERE CUSTOMER_ID = v_id;
r_customers c_customers%ROWTYPE;
Cursor c_empoyees is
 SELECT UNIQUE SALESMAN_ID 
 FROM ORDERS
 ORDER BY SALESMAN_ID;
 r_employees c_empoyees%ROWTYPE;
 v_nbr_vente INTEGER;
BEGIN
v_id := '&v_id';
OPEN c_customers;
LOOP
FETCH c_customers INTO r_customers;
EXIT WHEN c_customers%NOTFOUND;
END LOOP;
total := c_customers%ROWCOUNT;
CLOSE c_customers;
DBMS_OUTPUT.PUT_LINE('Le nombre de commande du client avec ID '||v_id||' est : '||total);
FOR r_employees IN c_empoyees LOOP
 EXIT WHEN c_empoyees%NOTFOUND;
 SELECT COUNT(*) INTO v_nbr_vente
 FROM ORDERS
 WHERE SALESMAN_ID = r_employees.SALESMAN_ID;
 DBMS_OUTPUT.PUT_LINE('Le nombre de vente d un employee sous ID :'||r_employees.SALESMAN_ID||' est :'||v_nbr_vente);
END LOOP;
END;
-- QUESTION 3:
SET SERVEROUTPUT ON
DECLARE 
Total INTEGER;
CURSOR c_sum IS 
SELECT SUM(quantity * unit_price) somme, CUSTOMER_ID
FROM order_items
INNER JOIN orders USING (order_id)
GROUP BY CUSTOMER_ID
ORDER BY CUSTOMER_ID asc;
r_sum c_sum%ROWTYPE;
BEGIN
OPEN c_sum;
LOOP
FETCH c_sum INTO r_sum;
EXIT WHEN c_sum%NOTFOUND;
IF r_sum.somme > 2000 THEN
UPDATE CUSTOMERS 
SET CREDIT_LIMIT = CREDIT_LIMIT + 50
WHERE CUSTOMER_ID = r_sum.CUSTOMER_ID;
END IF;
END LOOP;
Total := c_sum%ROWCOUNT;
CLOSE c_sum;
DBMS_OUTPUT.PUT_LINE('Le nombre de lignes qui ont étaient mise à jour est : '||Total);
END;
-- QUESTION 4:
SET SERVEROUTPUT ON
DECLARE 
Total INTEGER;
CURSOR c_sum IS 
SELECT SUM(quantity * unit_price) somme, CUSTOMER_ID
FROM order_items
INNER JOIN orders USING (order_id)
GROUP BY CUSTOMER_ID
ORDER BY CUSTOMER_ID asc;
r_sum c_sum%ROWTYPE;
BEGIN
OPEN c_sum;
LOOP
FETCH c_sum INTO r_sum;
EXIT WHEN c_sum%NOTFOUND;
IF r_sum.somme > 10000 THEN
UPDATE CUSTOMERS 
SET CREDIT_LIMIT = CREDIT_LIMIT + 50
WHERE CUSTOMER_ID = r_sum.CUSTOMER_ID;
END IF;
END LOOP;
Total := c_sum%ROWCOUNT;
CLOSE c_sum;
DBMS_OUTPUT.PUT_LINE('Le nombre de lignes qui ont étaient mise à jour est : '||Total);
END;
--QUESTION5:
 SET SERVEROUTPUT ON
  DECLARE
 date1 date;
 date2 date;
 v_id NUMBER;
 total  NUMBER;
 taux NUMBER;
 CURSOR c_employees is
 SELECT *
 From ORDERS
 WHERE SALESMAN_ID = v_id
 AND ORDER_DATE BETWEEN date1 and date2;  
 r_employees c_employees%ROWTYPE;
 BEGIN
 v_id := '&v_id';
 date1 := '&date1';
 date2 := '&date2';
 OPEN c_employees;
 SELECT  count(*) INTO total
 From ORDERS
 WHERE SALESMAN_ID = 55;
 LOOP
 FETCH c_employees INTO  r_employees;
 EXIT WHEN c_employees%NOTFOUND;
 END LOOP;
 taux := c_employees%ROWCOUNT / total;
 DBMS_OUTPUT.PUT_LINE('Le taux de vente de l employee avec ID :'||v_id||' est :'||taux);
 CLOSE c_employees;
 END;
 --QUESTION6: 
 SET SERVEROUTPUT ON
 DECLARE
 v_manager_id INTEGER;
 v_nbr_vente INTEGER;
 counter INTEGER;
 CURSOR c_employees IS
 SELECT *
 FROM EMPLOYEES 
 WHERE MANAGER_ID = v_manager_id;
 r_employees c_employees%ROWTYPE;
 BEGIN
 v_manager_id := '&v_manager_id';
 DBMS_OUTPUT.PUT_LINE('Le nombre de vente de chaque employee sous la direction du manager sous ID : '||v_manager_id );
 OPEN c_employees;
 LOOP
 FETCH c_employees INTO r_employees;
 EXIT WHEN c_employees%NOTFOUND; 
 SELECT count(*) INTO v_nbr_vente
 FROM ORDERS 
 WHERE SALESMAN_ID = r_employees.EMPLOYEE_ID;
 DBMS_OUTPUT.PUT_LINE(' ID de lemployee : '||r_employees.EMPLOYEE_ID||' Nombre de vente est : '||v_nbr_vente);
 END LOOP;
 CLOSE c_employees;
 counter := c_employees%ROWCOUNT;
 EXCEPTION
 WHEN others THEN
 DBMS_OUTPUT.PUT_LINE('Aucun manager sous cet ID !');
 END;
