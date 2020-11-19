----Question 1;

SET SERVEROUTPUT ON
DECLARE
CURSOR c_employees IS SELECT * FROM employees;
CURSOR c_manager (param employees.EMPLOYEE_ID%type) IS SELECT * FROM EMPLOYEES where EMPLOYEE_ID=param ;
v_employee c_employees%rowtype;
v_manager c_manager%rowtype;
BEGIN
for v_employee in c_employees loop
exit when c_employees%notfound;
for v_manager in c_manager(v_employee.EMPLOYEE_ID) loop
dbms_output.put_line ('Employé '|| v_employee.FIRST_NAME||' '|| v_employee.LAST_NAME ||'('||v_employee.employee_id||') travaille comme '||v_employee.job_title||' depuis '|| v_employee.hire_date ||' sous la direction de '||v_manager.last_name ||'(matricule : '||v_manager.employee_id||')');
end loop;
end loop;
END;

----Question 2;

ACCEPT var_nom  PROMPT 'Veuillez saisir votre nom :>'
set SERVEROUTPUT ON
DECLARE
CURSOR c_nbr_commande_client(param customers.customer_id%type) IS SELECT COUNT(CUSTOMER_ID) as nbr_commande_client from orders WHERE CUSTOMER_ID = param GROUP BY CUSTOMER_ID;
v_id number(2);
CURSOR c_nbr_vente IS SELECT SALESMAN_ID,COUNT(SALESMAN_ID) as nbr_vente from orders  GROUP BY SALESMAN_ID;
BEGIN
v_id := '&var_nom';
for n in c_nbr_commande_client(v_id) loop
dbms_output.put_line('le nombre de commande du client qui a ID('||v_id||') '||'est :'||n.nbr_commande_client);
end loop;
dbms_output.put_line('---------------------------------');
for v in c_nbr_vente loop
dbms_output.put_line('le nombre du vente de employee qui a ID('||v.SALESMAN_ID||') '||'est :'||v.nbr_vente);
end loop;
END;

----Question 3;

set SERVEROUTPUT ON
DECLARE
CURSOR c_augmenter IS SELECT customers.customer_id as v_customer,sum(unit_price) as v_prix from order_items,customers,orders where customers.customer_id = orders.customer_id and orders.order_id = order_items.order_id  group by  customers.customer_id having sum(unit_price) > 2000 order by customers.customer_id; 
total_rows number(2) := 0;
BEGIN
for v in c_augmenter loop
UPDATE CUSTOMERS SET CREDIT_LIMIT = CREDIT_LIMIT + 50 WHERE customer_id = v.v_customer;
if sql%found then
dbms_output.put_line( v.v_customer);
total_rows := total_rows + 1 ;
end if;
end loop;
dbms_output.put_line(total_rows||' customers selected');
END;

----Question 4;

set SERVEROUTPUT ON
DECLARE
CURSOR c_augmenter IS SELECT customers.customer_id as v_customer,sum(unit_price) as v_prix from order_items,customers,orders where customers.customer_id = orders.customer_id and orders.order_id = order_items.order_id  group by  customers.customer_id having sum(unit_price) > 10000 order by customers.customer_id; 
total_rows number(2) := 0;
BEGIN
for v in c_augmenter loop
UPDATE CUSTOMERS SET CREDIT_LIMIT = CREDIT_LIMIT + 50 WHERE customer_id = v.v_customer;
if sql%found then
dbms_output.put_line( v.v_customer);
total_rows := total_rows + 1 ;
end if;
end loop;
dbms_output.put_line(total_rows||' customers selected');
END;

----Question 5;

ACCEPT var_date1  PROMPT 'Veuillez saisir la premiere date sous form (dd/mm/rr) :>'
ACCEPT var_date2  PROMPT 'Veuillez saisir la deuxieme date sous form (dd/mm/rr) :>'
SET SERVEROUTPUT ON
DECLARE
v_total_vente number;
v_date1 orders.ORDER_DATE%type := '&var_date1';
v_date2 orders.ORDER_DATE%type := '&var_date2';
CURSOR taux_vente IS 
SELECT SALESMAN_ID,COUNT(SALESMAN_ID) as v_nb_vente FROM orders where ORDER_DATE BETWEEN v_date1 and v_date2 and salesman_id is not null GROUP BY SALESMAN_ID ;
BEGIN
SELECT count(*) into v_total_vente FROM orders where ORDER_DATE BETWEEN v_date1 and v_date2 ;
for n in taux_vente loop
dbms_output.put_line( 'Employee ID '||n.SALESMAN_ID||'a comme nombre de vente : '||n.v_nb_vente ||' et le nombre de vente total est :'||v_total_vente||'//porcentage of sales'||n.v_nb_vente/v_total_vente*100||'%' );
end loop;
END;

----Question 6;

ACCEPT var_id  PROMPT 'Veuillez saisir ID de votre manager :>'
SET SERVEROUTPUT ON
DECLARE
CURSOR nbr_vente_manager IS 
select count(orders.salesman_id) as v_taha from orders,employees where orders.salesman_id=employees.employee_id and employees.manager_id = '&var_id' ;
BEGIN
for n in nbr_vente_manager loop
dbms_output.put_line(n.v_taha );
end loop;
end;