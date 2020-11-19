------- quest 1-------------
set serveroutput on;
declare
cursor c_employee is
select * from employees;
empl c_employee%rowtype;
begin
open c_employee;
loop
fetch c_employee into empl;
exit when c_employee%notfound;
dbms_output.put_line('employé first name:'||empl.firstname||' last name : '|| empl.lastname || '(' || empl.id || ')' || 'le salaire ' ||empl.salary 
                      || 'travaille depuis '|| empl.hire_date || 'sous la direction du manager ou le numero id est ' || empl.manager_id);
end loop;

close c_employee;
end;
---------------quest 2--------------

------ps: j ai pas fais des jointures car j ai pas cree des jointure lors de la cration de la table des le depart

SET SERVEROUTPUT ON;
declare
cursor c_employee is
select count(*)   from employees;
cursor c_customer is
select count(*) from customer;
cmp1 INT;
cmp2 int;
begin

open c_employee;
open c_customer;
fetch c_employee into cmp1;
fetch c_customer into cmp2;
dbms_output.put_line( ' nombre d employée est ' ||cmp1 || ' nombre de customer est '|| cmp2);
close c_customer;
close c_employee;

end;
-------------------------question 3-------------------
 SET SERVEROUTPUT ON;
declare
cursor c_customer is
select * from customer 
where credit_limit>2000
for update of credit_limit;
cmp int ;
begin
cmp := 0;
for it in c_customer
loop
update customer set achat=achat+50 where customer_id=it.customer_id;
cmp:=cmp+1;

end loop;

dbms_output.put_line('le nombre de ligne affecte est '|| cmp);


end;
------------------quest 4------------------
 SET SERVEROUTPUT ON;
declare
cursor c_customer is
select * from customer 
where credit_limit>10000
for update of credit_limit;
cmp int ;
begin
cmp := 0;
for it in c_customer
loop
update customer set achat=achat+50 where customer_id=it.customer_id;
cmp:=cmp+1;

end loop;

dbms_output.put_line('le nombre de ligne affecte est '|| cmp);

end;
---------------quest 5-------------------
