-- **************************************  Administrations des bases de données **************************************

--                  **************************************  Solution TP_2  ************************************** 

-- *****************************
-- * Nom : HARRASS             *
-- * Prénom :Yassmina          * 
-- *****************************

-- Question 1 :

----- Methode 1 :

SET SERVEROUTPUT ON;
DECLARE
CURSOR c_employee IS SELECT * FROM EMPLOYEES ;
CURSOR c_manager(id NUMBER) IS SELECT * FROM employees WHERE  EMPLOYEE_ID = id;
v_employee c_employee%ROWTYPE;
v_manager c_manager%ROWTYPE;
i NUMBER :=0;
BEGIN
FOR v_employee IN c_employee LOOP
i:= i+1;
END LOOP;
IF i>0 THEN
FOR v_employee IN c_employee LOOP
if v_employee.manager_id IS NULL  then 
 DBMS_OUTPUT.PUT_LINE('Employé :  ' || v_employee.FIRST_NAME || ' - ' || v_employee.LAST_NAME || '( ID  : '|| v_employee.EMPLOYEE_ID || ')' || 
' travaille comme   ' || v_employee.JOB_TITLE || ' depuis     ' || v_employee.HIRE_DATE  );
else
FOR v_manager IN c_manager(v_employee.manager_id) LOOP
DBMS_OUTPUT.PUT_LINE('Employé :  ' || v_employee.FIRST_NAME || ' - ' || v_employee.LAST_NAME || '( ID  : '|| v_employee.EMPLOYEE_ID || ')' || 
' travaille comme   ' || v_employee.JOB_TITLE || ' depuis     ' || v_employee.HIRE_DATE || '  sous la direction  de ' || v_manager.LAST_NAME || 
'   (MATRICULE : ' || v_employee.manager_id || ')' );
END LOOP ;
end if;
END LOOP;
ELSE
DBMS_OUTPUT.PUT_LINE('No Employer found ');
END IF ;
END;

--Methode 2 : Optimisée

SET SERVEROUTPUT ON;
DECLARE
CURSOR c_employee IS 
SELECT emp1.first_name, emp1.last_name , emp1.employee_id , emp1.job_title,emp1.hire_date,emp1.manager_id,emp2.last_name as manager_last_name
FROM employees emp1
LEFT OUTER JOIN employees  emp2 ON  emp1.manager_id =emp2.employee_id;
v_employee c_employee%ROWTYPE;
BEGIN
FOR v_employee IN c_employee LOOP
if v_employee.manager_id IS NULL   then
 DBMS_OUTPUT.PUT_LINE('Employé :  ' || v_employee.FIRST_NAME || ' - ' || v_employee.LAST_NAME || '( ID  : '|| v_employee.EMPLOYEE_ID || ')' || 
' travaille comme   ' || v_employee.JOB_TITLE || ' depuis     ' || v_employee.HIRE_DATE  );
else
DBMS_OUTPUT.PUT_LINE('Employé :  ' || v_employee.FIRST_NAME || ' - ' || v_employee.LAST_NAME || '( ID  : '|| v_employee.EMPLOYEE_ID || ')' || 
' travaille comme   ' || v_employee.JOB_TITLE || ' depuis     ' || v_employee.HIRE_DATE || '  sous la direction  de ' || v_employee.manager_last_name || 
'   (MATRICULE : ' || v_employee.manager_id || ')' );
end if;
END LOOP;
END;


-- Question 2 :

DECLARE 
CURSOR c_customer_order IS 
SELECT  customers.customer_id  ,count(order_id) t
FROM customers 
LEFT JOIN orders  ON  customers.customer_id = orders.customer_id
group by customers.customer_id;
v_customer_order c_customer_order%ROWTYPE;
CURSOR c_employee_order IS 
SELECT  employees.employee_id  ,count(order_id) t
FROM employees
LEFT JOIN orders  ON  employees.employee_id = orders.salesman_id 
group by employees.employee_id;
v_employee_order c_employee_order%ROWTYPE;
BEGIN
FOR v_customer_order IN c_customer_order LOOP
DBMS_OUTPUT.PUT_LINE('Id of Customer : ' || v_customer_order.customer_id || ' Total of orders : '|| v_customer_order.t );
END LOOP;
DBMS_OUTPUT.PUT_LINE('**************************************');
FOR v_employee_order IN c_employee_order LOOP
DBMS_OUTPUT.PUT_LINE('Id of employee : ' || v_employee_order.employee_id || ' Total of sales : '|| v_employee_order.t );
END LOOP;
END;
-- Question 3 :
DECLARE 
CURSOR c_update IS SELECT customers.customer_id ,SUM(order_items.quantity*order_items.unit_price) as total from customers join orders 
on customers.customer_id=orders.customer_id join order_items on orders.order_id =order_items.order_id group by customers.customer_id;
v_update c_update%ROWTYPE;
v_total FLOAT;
i NUMBER :=0;
BEGIN
FOR v_update IN c_update LOOP
v_total:= v_update.total;
IF v_total>2000 then
UPDATE customers SET credit_limit =credit_limit+50 WHERE customer_id =v_update.customer_id;
i:=i+1;
end if;
END LOOP;
DBMS_OUTPUT.PUT_LINE(i);
END;

-- Question 4 : 

DECLARE 
CURSOR c_update IS SELECT customers.customer_id ,SUM(order_items.quantity*order_items.unit_price) as total from customers join orders 
on customers.customer_id=orders.customer_id join order_items on orders.order_id =order_items.order_id group by customers.customer_id;
v_update c_update%ROWTYPE;
v_total FLOAT;
i NUMBER :=0;
BEGIN
FOR v_update IN c_update LOOP
v_total:= v_update.total;
IF v_total>10000 then
UPDATE customers SET credit_limit =credit_limit+50 WHERE customer_id =v_update.customer_id;
i:=i+1;
end if;
END LOOP;
DBMS_OUTPUT.PUT_LINE(i);
END;

-- Question 5 :

DECLARE
v_total_orders NUMBER;
date1 DATE :=TO_DATE('&date1 ','DD-MM-RR');
date2 DATE := TO_DATE('&date2 ','DD-MM-RR');
CURSOR c_employee IS 
SELECT  employees.employee_id  ,count(order_id) t
FROM employees
LEFT JOIN orders  ON  employees.employee_id = orders.salesman_id 
WHERE orders.order_date BETWEEN date1 AND date2
group by employees.employee_id;
v_employee c_employee%ROWTYPE;
BEGIN
SELECT count(*) INTO v_total_orders FROM orders WHERE orders.order_date BETWEEN date1 AND date2 ;
if SIGN(date2-date1)>0  then
FOR v_employee IN c_employee LOOP
DBMS_OUTPUT.PUT_LINE(' EMPLOYEE ID : ' || v_employee.employee_id  || '  numbers of sales ' || v_employee.t || ' percentage of sales ' ||  
(v_employee.t/v_total_orders)*100 || '%');
END LOOP;
else 
DBMS_OUTPUT.PUT_LINE(' the first date is more longer than the second or are the same ');
end if;
END;

-- Question 6:


DECLARE 
erreur EXCEPTION;
managerid NUMBER := '&manager_id';
CURSOR c_manager IS SELECT * FROM employees WHERE manager_id = managerid;
v_manager c_manager%ROWTYPE;
i NUMBER := 0;
CURSOR c_employee_order(employeeid NUMBER ) IS 
SELECT  employees.employee_id  ,count(order_id) t
FROM employees
LEFT JOIN orders  ON  employees.employee_id = orders.salesman_id 
WHERE employees.employee_id=employeeid
group by employees.employee_id;
v_employee_order c_employee_order%ROWTYPE;
BEGIN 
FOR v_manager IN c_manager LOOP
i:=i+1;
END LOOP;
if i>0 then
FOR v_manager IN c_manager LOOP
FOR v_employee_order IN c_employee_order(v_manager.employee_id) LOOP
DBMS_OUTPUT.PUT_LINE( 'Employee ID : '|| v_employee_order.employee_id || ' total of sales : ' || v_employee_order.t);
END LOOP;
END LOOP;
else 
RAISE erreur;
end if;
EXCEPTION
WHEN erreur THEN
DBMS_OUTPUT.PUT_LINE('NO manager in this ID');
END;














