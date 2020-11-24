----------Question 1---------------------
SET SERVEROUTPUT ON;
DECLARE
CURSOR c_emp IS 
SELECT first_name, last_name, employee_id, job_title, hire_date, manager_id FROM employees;
l_name employees.last_name%TYPE;
BEGIN
FOR N IN c_emp LOOP
IF N.manager_id IS NOT NULL THEN
SELECT last_name INTO l_name FROM employees WHERE employee_id=N.manager_id;
dbms_output.put_line('Employee '|| N.first_name ||' '||N.last_name||' ID : '||N.employee_id||' travaille comme '||N.job_title||' depuis '||N.hire_date||' sous la direction de '||l_name||' de matricule '||N.manager_id);
ELSE
dbms_output.put_line('Employee '|| N.first_name ||' '||N.last_name||' ID : '||N.employee_id||' travaille comme '||N.job_title||' depuis '||N.hire_date||' C est le directeur!');
END IF;
END LOOP;
END;
----------------------------------

-------------Question 2-1 -----------------
SET SERVEROUTPUT ON
DECLARE 
i INTEGER:=0;

cus_id orders.customer_id%TYPE;
id_c number;
    CURSOR n_orders IS 
    SELECT * FROM orders WHERE customer_id=id_c;
    CURSOR n_customers IS 
    SELECT * FROM customers;
    BEGIN
    FOR N IN n_customers LOOP
    id_c := N.customer_id;
    FOR M IN n_orders LOOP
    i:=i+1;
    END LOOP;
    DBMS_OUTPUT.PUT_LINE('Nombre de commande du '||N.name||' est :'||i);
    i:=0;
    END LOOP;
    END;
-----------------------------------------------

---------------Question 2-2---------------------
SET SERVEROUTPUT ON

DECLARE 

i INTEGER:=0;
emp_id number;

    CURSOR n_orders IS 
    SELECT * FROM orders WHERE salesman_id=emp_id;
    
    CURSOR n_employees IS 
    SELECT * FROM employees;
    
    BEGIN
    FOR N IN n_employees LOOP
    emp_id := N.employee_id;
    FOR M IN n_orders LOOP
    i:=i+1;
    END LOOP;
    DBMS_OUTPUT.PUT_LINE('Nombre de ventes de l employee qui a l ID : '||N.employee_id||' est :'||i);
    i:=0;
    END LOOP;
    END;
------------------------------------------------------    