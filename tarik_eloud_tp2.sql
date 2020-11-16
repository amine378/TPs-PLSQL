----------------------------------QUESTION 1 ----------------------------------
SET SERVEROUTPUT ON;
declare

    cursor c_employer is
    select * FROM employees;
    employer employees%ROWTYPE;
    v_directeur employees.last_name%type;
    cursor employe_manag(v_id employees.manager_id%type) is
    select last_name into v_directeur  FROM employees where employee_id=v_id;
    
begin

    open c_employer; 
    loop
        fetch c_employer into employer;
        exit when c_employer%notfound;
        dbms_output.put_line('____employé '||employer.first_name ||' '||employer.last_name||' (ID : '||employer.employee_id||' )' );
        dbms_output.put_line('travail comme '||employer.job_title ||' depuis '||employer.hire_date );
    
    open employe_manag(employer.manager_id); 
     loop
         fetch employe_manag into v_directeur(employer.manager_id);
     exit when employe_manag%notfound;
         dbms_output.put_line('sous la direction de '||v_directeur);
     end loop;
     close employe_manag;
     
    end loop;
    close c_employer;
    
end;

----------------------------------QUESTION 2 ----------------------------------

set SERVEROUTPUT ON;
DECLARE
CURSOR c(var_1 ORDERS.CUSTOMER_ID%type) is 
select count(CUSTOMER_ID) from ORDERS where CUSTOMER_ID=var_1;
v_client ORDERS.CUSTOMER_ID%type;
v_nbr number ;
CURSOR curs(v_employe orders.salesman_id%type)is
select count(salesman_id) from ORDERS where salesman_id=v_employe;
v_emp orders.salesman_id%type;
BEGIN
v_client := '&v_client';
open c(v_client);
FETCH C into v_nbr;
dbms_output.put_line('votre nombre de commande est: '|| v_nbr);
close c;
v_emp := '&v_emp';
open curs(v_emp);
FETCH Curs into v_nbr;
dbms_output.put_line('Le nombre de vente de cet employer est: '|| v_nbr);
close curs;
END;
----------------------------------QUESTION 3 ----------------------------------
SET SERVEROUTPUT ON;
DECLARE
    total order_items.unit_price%type:=0;
    cus_id customers.customer_id%type;
    ord_id orders.order_id%type;
     i number:=0;
BEGIN
    for cust IN (select * from customers) loop
        for ord IN (select * from orders where customer_id= cust.customer_id) LOOP
            for price IN (select * from order_items where order_id=ord.order_id) LOOP
                total := total+price.unit_price;
            end loop;
        end loop;
            if (total>=2000) then
               dbms_output.put_line('the customer number '||cust.customer_id||' bought : '||total);
                update customers set credit_limit= credit_limit+50;
                i := i+1;
            end if;    
            total:=0;
    end loop;
    dbms_output.put_line('nbr de ligne mise a jour est ' ||  i);
END;
----------------------------------QUESTION 4 ----------------------------------
SET SERVEROUTPUT ON;
DECLARE
    total order_items.unit_price%type:=0;
    cus_id customers.customer_id%type;
    ord_id orders.order_id%type;
     i number:=0;
BEGIN
    for cust IN (select * from customers) loop
        for ord IN (select * from orders where customer_id= cust.customer_id) LOOP
            for price IN (select * from order_items where order_id=ord.order_id) LOOP
                total := total+price.unit_price;
            end loop;
        end loop;
            if (total>=10000) then
               dbms_output.put_line('the customer number '||cust.customer_id||' bought : '||total);
                update customers set credit_limit= credit_limit+50;
                i := i+1;
            end if;    
            total:=0;
    end loop;
    dbms_output.put_line('nbr de ligne mise a jour est ' ||  i);
END;