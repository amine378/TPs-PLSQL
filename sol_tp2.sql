-------------question 1----------------------------------------------------------------------

set serveroutput on;
DECLARE 
c_name employees.first_name%TYPE;
c_lastname employees.last_name%TYPE;
lmanager employees.last_name%TYPE;
c_id employees.EMPLOYEE_ID%TYPE;
c_jobtitle employees.job_title%TYPE;
c_hiredate employees.hire_date%TYPE;
c_managerid employees.manager_id%TYPE;
cursor c_employee is 
select first_name, last_name, EMPLOYEE_ID, job_title, hire_date, manager_id FROM EMPLOYEES;
BEGIN
open c_employee;
loop 
fetch c_employee into c_name,c_lastname,c_id,c_jobtitle,c_hiredate,c_managerid;
exit when c_employee%notfound;
if c_managerid is not null then
select last_name into lmanager from employees where employee_id=c_managerid;
dbms_output.put_line('Employée '||c_name||' '||c_lastname||' ( ID: '||c_id||' ) travaille comme '||c_jobtitle||' depuis '||c_hiredate||' sous la direction de '||lmanager||' ( matricule : '||c_managerid||' ).');
else
dbms_output.put_line('Employée '||c_name||' '||c_lastname||' ( ID: '||c_id||' ) travaille comme '||c_jobtitle||' depuis '||c_hiredate||' sous la direction de personne');
end if;
END LOOP;
close c_employee;
end;

-------------question 2------------------------------------------------------------------------


set serveroutput on;
DECLARE
c_idcus customers.customer_id%type;
c_idemp employees.employee_id%type;
c_cus customers.name%type; 
c_empf employees.first_name%type;
c_empl employees.last_name%type;
sum1 int;
sum2 int;
cursor c_count1 is 
select customer_id,name from customers;
cursor c_count2 is 
select employee_id,first_name,last_name from employees;
begin
open c_count1;
loop
fetch c_count1 into c_idcus,c_cus;
exit when c_count1%notfound;
select count(*) into sum1 from orders where customer_id=c_idcus;
dbms_output.put_line('nombre dordre de '||c_cus||' est : '||sum1);
end loop;
close c_count1;
open c_count2;
loop
fetch c_count2 into c_idemp,c_empf,c_empl;
exit when c_count2%notfound;
select count(*) into sum2 from orders where salesman_id=c_idemp;
dbms_output.put_line('nombre de vente de '||c_empf|| ' '||c_empl||' est : '||sum2);
end loop;
close c_count2;
end;

------------------question 3-------------------------------------------------------------

set serveroutput on;
DECLARE
v_cusid customers.customer_id%type;
v_orderid orders.order_id%type;
achat int:=0;
total int:=0;
nbr int:=0;
cursor c_cus is 
select distinct customer_id from orders ORDER BY customer_id;
cursor c_order is 
select order_id from orders where customer_id=v_cusid;
begin
open c_cus;
loop 
fetch c_cus into v_cusid;
exit when c_cus%notfound;
open c_order;
loop
fetch c_order into v_orderid;
exit when c_order%notfound;
select sum(unit_price*quantity) into achat from order_items where order_id=v_orderid;
total:=total+achat;
end loop;
close c_order;
if total>20000 then
UPDATE customers set credit_limit=credit_limit+50
where customer_id=v_cusid;
nbr:=nbr+1;
end if;
total:=0;
achat:=0;
end loop;
close c_cus;
dbms_output.put_line('nombre des client dont limit cridit est modifié est  : '||nbr);
end;

-----------------question 4----------------------------------------------------------------------------------

set serveroutput on;
DECLARE
v_cusid customers.customer_id%type;
v_orderid orders.order_id%type;
achat int:=0;
total int:=0;
nbr int:=0;
cursor c_cus is 
select distinct customer_id from orders ORDER BY customer_id;
cursor c_order is 
select order_id from orders where customer_id=v_cusid;
begin
open c_cus;
loop 
fetch c_cus into v_cusid;
exit when c_cus%notfound;
open c_order;
loop
fetch c_order into v_orderid;
exit when c_order%notfound;
select sum(unit_price*quantity) into achat from order_items where order_id=v_orderid;
total:=total+achat;
end loop;
close c_order;
if total>100000 then
UPDATE customers set credit_limit=credit_limit+50
where customer_id=v_cusid;
nbr:=nbr+1;
end if;
total:=0;
achat:=0;
end loop;
close c_cus;
dbms_output.put_line('nombre des client dont limit cridit est modifié est  : '||nbr);
end;

-----------------question 5---------------------------------------------------------------------------
set serveroutput on;
DECLARE
c_idemp employees.employee_id%type;
c_empf employees.first_name%type;
c_empl employees.last_name%type;
v_date_debut date := '&v_date_debut';
v_date_fin date := '&v_date_fin';
sum1 int;
taux int;
tot int;
cursor c_count is 
select employee_id,first_name,last_name from employees where ;
begin
open c_count;
loop
fetch c_count into c_idemp,c_empf,c_empl;
exit when c_count%notfound;
select count(*) into sum1 from orders where salesman_id=c_idemp and order_date>v_date_debut and order_date<v_date_fin;
select count(*) into tot from orders;
taux := (sum1/tot)*100;
dbms_output.put_line('le taux de vente de '||c_empf|| ' '||c_empl||' est : '||taux);
end loop;
close c_count;
end;

------------------question 6--------------------------------------------------------------------------

set serveroutput on;
DECLARE
c_idemp employees.employee_id%type;
c_empf employees.first_name%type;
c_empl employees.last_name%type;
v_manager employees.manager_id%type := '&v_manager';
v_id employees.manager_id%type;
sum1 int;
ex_invalid_id exception; 
cursor c_count is 
select employee_id,first_name,last_name from employees where manager_id=v_manager ;
begin
if v_manager<=0 then
raise ex_invalid_id;
end if;
select employee_id into v_id from employees where manager_id=v_manager;
exception 
when ex_invalid_id then
dbms_output.put_line('entrez une valeur superieur a zero');
when no_data_found then
dbms_output.put_line('Manager n existe pas');
when others then
open c_count;
loop
fetch c_count into c_idemp,c_empf,c_empl;
exit when c_count%notfound; 
select count(*) into sum1 from orders where salesman_id=c_idemp  ;
dbms_output.put_line('le nombre de vente de '||c_empf|| ' '||c_empl||' de manager '||v_manager||' est : '||sum1);
end loop;
close c_count;
end; 