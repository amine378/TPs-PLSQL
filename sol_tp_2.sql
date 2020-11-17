//
//  sol_tp_2.sql
//  Devoir
//
//  Created by Naoufal ACHAHBAR on 16/11/2020.
//  Copyright © 2020 Naoufal ACHAHBAR. All rights reserved.
//


/* question 1 : */

SET SERVEROUTPUT ON;
DECLARE
c_emp employees%rowtype;
CURSOR c_employees is
SELECT employee_id, first_name, last_name, job_title, hire_date, manager_id
FROM employees;
BEGIN
    OPEN c_employees;
    LOOP
    FETCH c_employees 
    into c_emp.employee_id, c_emp.first_name, c_emp.last_name, 
    c_emp.job_title, c_emp.hire_date, c_emp.manager_id;
        EXIT WHEN c_employees%notfound;
        dbms_output.put_line('Employé ' || c_emp.first_name || ' ' || c_emp.last_name || ' (ID: ' || c_emp.employee_id || ' ) ' || 'travaille comme ' || c_emp.job_title || ' depuis ' || c_emp.hire_date || ' sous la direction de ' || c_emp.last_name || ' (matricule : ' || c_emp.manager_id || ' )');
    END LOOP;
    CLOSE c_employees;
END;


/* question 2 : */
-- 1 :

SET SERVEROUTPUT ON;
DECLARE
n_cmd number;
c_id number;
cursor c_customer(x number) is
    SELECT COUNT(ORDER_ID) FROM ORDERS where CUSTOMER_ID = x;
BEGIN
c_id := &client;
open c_customer(c_id);
fetch c_customer into n_cmd;
 dbms_output.put_line('Le nombre de commandes est : ' || n_cmd);
close c_customer;
END;

-- 2 :

SET SERVEROUTPUT ON;
DECLARE
n_vnt number;
s_id number;
cursor c_employees(x number) is
    SELECT COUNT(ORDER_ID) FROM ORDERS where SALESMAN_ID = x;
BEGIN
s_id := &salesman;
open c_employees(s_id);
fetch c_employees into n_vnt;
 dbms_output.put_line('Le nombre de commandes est : ' || n_vnt);
close c_employees;
END;


/* question 3 : */

SET SERVEROUTPUT ON;    
DECLARE
      CURSOR c_customer is
      SELECT customer_id , SUM(QUANTITY * UNIT_PRICE)
      FROM ORDERS
      INNER JOIN order_items USING(order_id)
      group by customer_id
      having SUM(QUANTITY*UNIT_PRICE) > 2000;
c integer;
begin
c:=0;
 for i in c_customer loop
   update customers set credit_limit = credit_limit + 50
   where customer_id = i.customer_id;
   c:=c+1;
   end loop;
   dbms_output.put_line('Le nombre de lignes mis a jour est : ' || c);
END;


/* question 4 : */

SET SERVEROUTPUT ON;    
DECLARE
      CURSOR c_customer is
      SELECT customer_id , SUM(QUANTITY * UNIT_PRICE)
      FROM ORDERS
      INNER JOIN order_items USING(order_id)
      group by customer_id
      having SUM(QUANTITY*UNIT_PRICE) > 1000;
c integer;
begin
c:=0;
 for i in c_customer loop
   update customers set credit_limit = credit_limit + 50
   where customer_id = i.customer_id;
   c:=c+1;
   end loop;
   dbms_output.put_line('Le nombre de lignes mis a jour est : ' || c);
END;


/* question 5 : */

SET SERVEROUTPUT ON;    
DECLARE
        v_salesman orders.salesman_id%type;
        date_start orders.order_date%type;
        date_end orders.order_date%type;
        taux float;
        somme integer;
        
        cursor rate is
        select count(*)*100/(select count(*) from orders where STATUS = 'Shipped' AND ORDER_DATE>date_start AND ORDER_DATE<date_end) as taux_vente  from orders where (STATUS = 'Shipped' AND ORDER_DATE>date_start AND ORDER_DATE<date_end) group by salesman_id having salesman_id=v_salesman;
      
BEGIN

        v_salesman := &v_salesman;
        date_start := '&date_start';
        date_end := '&date_end';
        
        open rate ;
        fetch rate into taux ;
        EXIT WHEN rate%NOTFOUND;
        dbms_output.put_line('Le taux de vente de ' || v_salesman || ' est : ' || taux.taux_vente  || '%' );
        END LOOP;
        CLOSE  rate ;
END ;






