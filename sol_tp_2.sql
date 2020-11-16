--question 1
set SERVEROUTPUT ON;
DECLARE
CURSOR C1 IS SELECT * FROM employees;
r_c1 C1%ROWTYPE;
v_manager EMPLOYEES.FIRST_NAME%TYPE;
nbr number;
BEGIN
OPEN C1;
LOOP
FETCH C1 into r_c1;
EXIT WHEN C1%NOTFOUND;
Select count(*) into nbr from employees where employee_id = r_c1.MANAGER_ID;
if ( nbr = 0) then
dbms_output.put_line('Employé ' || r_c1.FIRST_NAME  || ' ' || r_c1.LAST_NAME || ' ' ||  'travaille comme ' || r_c1.JOB_TITLE ||' ' ||  'depuis ' ||r_c1.HIRE_DATE ||' ' ||
'sous aucune direction');
else
SELECT FIRST_NAME into v_manager FROM employees where employee_id = r_c1.MANAGER_ID;
dbms_output.put_line('Employé ' || r_c1.FIRST_NAME  || ' ' || r_c1.LAST_NAME || ' ' ||  'travaille comme ' || r_c1.JOB_TITLE ||' ' ||  'depuis ' || r_c1.HIRE_DATE ||' ' ||
'sous la direction de ' ||   v_manager );
END IF;
END LOOP;
CLOSE C1;
END;

--question 2
--A)
---premiere methode
set SERVEROUTPUT ON;
DECLARE
CURSOR C1 IS SELECT * from orders where CUSTOMER_ID = '&id_customer';
r_orders C1%ROWTYPE;
nbr integer := 0;
BEGIN
OPEN C1;
LOOP
FETCH C1 into r_orders;
EXIT When C1%NOTFOUND;
nbr := nbr+1;
END LOOP;
CLOSE C1;
dbms_output.put_line('le nombre de commande du client : ' || r_orders.name  || nbr );
END;
--2eme methode
set SERVEROUTPUT ON;
DECLARE
CURSOR C1 IS SELECT  name, commandes from customers INNER JOIN ( select customer_id, count(*) as commandes from orders group by customer_id having customer_id='&id_customer' ) ORDERS ON ORDERS.CUSTOMER_ID=customers.customer_id;
r_orders C1%ROWTYPE;
nbr integer := 0;
BEGIN
OPEN C1;
LOOP
FETCH C1 into r_orders;
EXIT When C1%NOTFOUND;
dbms_output.put_line('le nombre de commandes du client : ' || r_orders.name || ' est '  || r_orders.commandes );
END LOOP;
CLOSE C1;
END;
-- pour citer le nombre de demandes de tous les clients
set SERVEROUTPUT ON;
DECLARE
CURSOR C1 IS SELECT  name, commandes from customers INNER JOIN ( select customer_id, count(*) as commandes from orders group by customer_id ) ORDERS ON ORDERS.CUSTOMER_ID=customers.customer_id;
r_orders C1%ROWTYPE;
nbr integer := 0;
BEGIN
OPEN C1;
LOOP
FETCH C1 into r_orders;
EXIT When C1%NOTFOUND;
dbms_output.put_line('le nombre de commandes du client ' || r_orders.name || ' est '  || r_orders.commandes );
END LOOP;
CLOSE C1;
END;
--B)

set SERVEROUTPUT ON;
DECLARE
CURSOR C1 IS SELECT employee_id, first_name, last_name, ventes FROM EMPLOYEES INNER JOIN (SELECT salesman_id, COUNT(*) as ventes from ORDERS group by salesman_id ) ORDERS ON ORDERS.salesman_id=employees.employee_id;
r_ventes C1%ROWTYPE;
nbr integer := 0;
BEGIN
OPEN C1;
LOOP
FETCH C1 into r_ventes;
EXIT When C1%NOTFOUND;
dbms_output.put_line('le nombre de ventes de l''employee ' || r_ventes.first_name || ' ' || r_ventes.last_name || ' est '  || r_ventes.ventes );
END LOOP;
CLOSE C1;
END;

--question 3

set SERVEROUTPUT ON;
DECLARE
nbr number;
BEGIN
UPDATE CUSTOMERS SET CREDIT_LIMIT=CREDIT_LIMIT+50 where CREDIT_LIMIT>2000;
if sql%notfound then 
dbms_output.put_line('pas de client ayant plus de 2000 dollars d''achats');
elsif sql%found then
nbr:=sql%rowcount;
dbms_output.put_line('nombre de lignes modifiées : ' || nbr);
end if;
END;
--question 4

set SERVEROUTPUT ON;
DECLARE
nbr number;
BEGIN
UPDATE CUSTOMERS SET CREDIT_LIMIT=CREDIT_LIMIT+50 where CREDIT_LIMIT>10000;
if sql%notfound then 
dbms_output.put_line('pas de client ayant plus de 10000 dollars d''achats');
elsif sql%found then
nbr:=sql%rowcount;
dbms_output.put_line('nombre de lignes modifiées : ' || nbr);
end if;
END;

--question 5
set SERVEROUTPUT ON;
DECLARE
date1 DATE :='&premiere_date';
date2 DATE :='&deuxieme_date';
v_empl NUMBER :='&employee_id';
CURSOR C1 IS select count(*)*100/(select count(*) from orders where ORDER_DATE>date1 AND ORDER_DATE<date2) as res   from orders where (ORDER_DATE>date1 AND ORDER_DATE<date2) group by salesman_id having salesman_id=v_empl;
r_ventes C1%ROWTYPE;
BEGIN
OPEN C1;
LOOP
FETCH C1 into r_ventes;
EXIT When C1%NOTFOUND;
dbms_output.put_line('le taux de vente est ' || r_ventes.res  || '%' );
END LOOP;
CLOSE C1;
END;

--question 6
set SERVEROUTPUT ON;
DECLARE
CURSOR C1 IS select EMPLOYEE_ID, ventes from employees  inner join (select salesman_id, count(*) as ventes from orders group by salesman_id) orders ON orders.salesman_id=employees.employee_id where MANAGER_ID='&manager_id';
r_ventes C1%ROWTYPE;
BEGIN
OPEN C1;
LOOP
FETCH C1 into r_ventes;
EXIT When C1%NOTFOUND;
dbms_output.put_line('employee id  : ' || r_ventes.employee_id  || ' ' || '| ventes : ' || r_ventes.ventes);
END LOOP;
CLOSE C1;
END;


