                                                                                            --tp2:pl/sql   réalisée par chyamae mestour
--QUESTIN1:
SET SERVEROUTPUT ON;
DECLARE
c_id employees.employee_id%type;
c_last_name employees.LAST_NAME%type;
c_first_name employees.FIRST_NAME%type;
c_hire_date employees.HIRE_DATE%type;
c_job employees.JOB_TITLE%type;
c_manager employees.MANAGER_ID%type;
c_name employees.LAST_NAME%type;
cursor c_employee is
  select FIRST_NAME,LAST_NAME,EMPLOYEE_ID,JOB_TITLE,HIRE_DATE,MANAGER_ID from employees;

BEGIN
open c_employee;
loop
fetch c_employee into c_first_name,c_last_name,c_id,c_job,c_hire_date,c_manager;
if c_manager is null then
DBMS_OUTPUT.PUT_LINE('Employé' || c_first_name || ' ' || c_last_name || '(ID : ' || c_id || ')'  || ' ' || 'travaille comme'  || ' ' || c_job || ' ' ||
 'depuit ' || c_hire_date || 'sous aucun direction  '  ||  '(matricule:' ||   c_manager  
|| ').');
else
 select LAST_NAME into c_name from employees where EMPLOYEE_ID = c_manager;
 


DBMS_OUTPUT.PUT_LINE('Employé' || c_first_name || ' ' || c_last_name || '(ID : ' || c_id || ')'  || ' ' || 'travaille comme'  || ' ' || c_job || ' ' ||
 'depuit ' || c_hire_date || 'sous la direction de ' || c_name ||  '(matricule:' ||   c_manager  
|| ').');
end if;
exit when c_employee%notfound;
end loop;
close c_employee;

  
END;

---------------------------------------------------------------------------------------------------------------------------------------------------------
--QUESTION2:
SET SERVEROUTPUT ON;
DECLARE
c_id customers.CUSTOMER_ID%type;
c_nom customers.NAME%type;
v_nbr int;
c_last_name employees.LAST_NAME%type;
c_first_name employees.FIRST_NAME%type;
c_ide employees.employee_id%type;
v_numero int;

cursor c_custmer is
  select CUSTOMER_ID,NAME  from customers;
cursor c_employee is
  select FIRST_NAME,LAST_NAME,EMPLOYEE_ID from employees;

BEGIN
open c_custmer;
loop
fetch c_custmer into c_id,c_nom;
select COUNT(*) into v_nbr FROM orders where CUSTOMER_ID=c_id;
DBMS_OUTPUT.PUT_LINE('le client ' || c_nom || ' ' || 'a' || ' ' || v_nbr || ' ' || 'commande'  );
exit when c_custmer%notfound;

end loop;
close c_custmer;
open c_employee;
loop
fetch c_employee into c_first_name,c_last_name,c_ide;
select COUNT(*) into v_numero FROM orders where SALESMAN_ID=c_ide;

DBMS_OUTPUT.PUT_LINE('Employee ' || c_first_name || ' ' || c_last_name || ' ' || 'a' || ' ' || v_numero || ' ' || 'vente'  );
exit when c_employee%notfound;
end loop;
close c_employee;

END;
-------------------------------------------------------------------------------------------------------------------------------
--QUESTION3:
SET SERVEROUTPUT ON;
DECLARE
         v_client_id customers.customer_id%type;
          v_order ORDERS.ORDER_ID%type;
          CURSOR C_orders IS
        SELECT distinct CUSTOMER_ID FROM ORDERS;
        CURSOR C_ORDER IS
        SELECT  ORDER_ID FROM ORDERS WHERE customer_id= v_client_id ;
       NOMBRE_LIGNE int := 0;
        TOTAL_ACHAT int :=0;
        PRIX int :=0;
BEGIN

   OPEN C_orders;
   loop
     fetch C_orders into v_client_id;
       exit when C_orders%notfound;
        OPEN C_ORDER;
        loop
        fetch C_ORDER into v_order ;
         exit when C_ORDER%notfound;
        SELECT sum(unit_price*quantity) INTO PRIX FROM order_items  WHERE order_items.order_id = v_order;
        TOTAL_ACHAT := TOTAL_ACHAT+PRIX;
        end loop;
        close C_ORDER;
        --dbms_output.put_line('la somme de client' || v_client_id ||' est  :'||TOTAL_ACHAT);  
        
        IF TOTAL_ACHAT >= 20000 THEN
        UPDATE CUSTOMERS
       SET CUSTOMERS.CREDIT_LIMIT = CREDIT_LIMIT + 50 WHERE customer_id = v_client_id  ;
        NOMBRE_LIGNE := NOMBRE_LIGNE + 1;
       END IF;
         
        TOTAL_ACHAT := 0;
        end loop;
        close C_orders;
        dbms_output.put_line('nombre de lighne est  :'||NOMBRE_LIGNE); 
        end;
        
------------------------------------------------------------------------------------------------------------------------------
--question4;

SET SERVEROUTPUT ON;
DECLARE
         v_client_id customers.customer_id%type;
          v_order ORDERS.ORDER_ID%type;
          CURSOR C_orders IS
        SELECT distinct CUSTOMER_ID FROM ORDERS;
        CURSOR C_ORDER IS
        SELECT  ORDER_ID FROM ORDERS WHERE customer_id= v_client_id ;
       NOMBRE_LIGNE int := 0;
        TOTAL_ACHAT int :=0;
        PRIX int :=0;
BEGIN

   OPEN C_orders;
   loop
     fetch C_orders into v_client_id;
       exit when C_orders%notfound;
        OPEN C_ORDER;
        loop
        fetch C_ORDER into v_order ;
         exit when C_ORDER%notfound;
        SELECT sum(unit_price*quantity) INTO PRIX FROM order_items  WHERE order_items.order_id = v_order;
        TOTAL_ACHAT := TOTAL_ACHAT+PRIX;
        end loop;
        close C_ORDER;
        --dbms_output.put_line('la somme de client' || v_client_id ||' est  :'||TOTAL_ACHAT);  
        
        IF TOTAL_ACHAT >= 100000 THEN
        UPDATE CUSTOMERS
       SET CUSTOMERS.CREDIT_LIMIT = CREDIT_LIMIT + 50 WHERE customer_id = v_client_id  ;
        NOMBRE_LIGNE := NOMBRE_LIGNE + 1;
       END IF;
         
        TOTAL_ACHAT := 0;
        end loop;
        close C_orders;
        dbms_output.put_line('nombre de lighne est  :'||NOMBRE_LIGNE); 
        end;


----------------------------------------------------------------------------------------------------------------------------
--question5:
SET SERVEROUTPUT ON;
DECLARE

v_date_debut date := '&v_date_debut';
v_date_fin date := '&v_date_fin';

  
c_last_name employees.LAST_NAME%type;
c_first_name employees.FIRST_NAME%type;
c_ide employees.employee_id%type;
num1 int;
nbr int;
taux int;
cursor c_employee is
  select FIRST_NAME,LAST_NAME,EMPLOYEE_ID from employees;

BEGIN

open c_employee;
loop
fetch c_employee into c_first_name,c_last_name,c_ide;
select COUNT(*) into num1 FROM orders where SALESMAN_ID=c_ide and ORDER_DATE > v_date_debut and  ORDER_DATE < v_date_fin ;
select COUNT(*)  into nbr from orders;
taux := (num1/nbr)*100;
DBMS_OUTPUT.PUT_LINE('Employee ' || c_first_name || ' ' || c_last_name || ' ' || 'a un taux de vente' || ' ' || taux|| ' ' || 'entre les dates '  || ' ' ||v_date_debut ||  ' ' || 'est  '  || ' ' ||v_date_fin );
exit when c_employee%notfound;
end loop;
close c_employee;

END;
------------------------------------------------------------------------------------------------------------------------------
--question6:

SET SERVEROUTPUT ON;
DECLARE
id_manager  employees.MANAGER_ID%type:= '&id_manager';

c_last_name employees.LAST_NAME%type;
c_first_name employees.FIRST_NAME%type;
c_ide employees.employee_id%type;
num1 int;
ex_invalid_id exception;
dd employees.FIRST_NAME%type;


cursor c_employee is
  select FIRST_NAME,LAST_NAME,EMPLOYEE_ID from employees where MANAGER_ID = id_manager ;

BEGIN


 if id_manager <= 0 then
 raise ex_invalid_id;
 end if;
select FIRST_NAME into dd  FROM employees where MANAGER_ID= id_manager ;

exception 
when ex_invalid_id then 
DBMS_OUTPUT.PUT_LINE('id doit etre superieur a 0');
when no_data_found then 
DBMS_OUTPUT.PUT_LINE('id introuvable');
when others then 


open c_employee;


loop

fetch c_employee into c_first_name,c_last_name,c_ide;

select COUNT(*) into num1 FROM orders where SALESMAN_ID=c_ide  ;

exit when c_employee%notfound;
DBMS_OUTPUT.PUT_LINE('Employee ' || c_first_name || ' ' || c_last_name || ' ' || 'a manager id' || ' ' || id_manager ||'a ' || ' ' || num1 || ' ' || 'vente'  );

end loop;
close c_employee;

END;
