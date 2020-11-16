/* Q1
set SERVEROUTPUT ON;
DECLARE
    cursor c_employe is
    select * from EMPLOYEES;
    cursor c_manager (v_id employees.manager_id%type) is
    select LAST_NAME from EMPLOYEES where employee_id=v_id;
BEGIN
    for v_emp IN c_employe LOOP
    dbms_output.put_line('Employé '||v_emp.FIRST_NAME ||' '|| v_emp.LAST_NAME ||' (ID : '||v_emp.EMPLOYEE_ID||')');
    dbms_output.put_line('travaille comme '||v_emp.JOB_TITLE||' depuis '|| v_emp.HIRE_DATE||' sous la direction de ');
    for v_man IN c_manager(v_emp.MANAGER_ID) LOOP
    dbms_output.put_line(v_man.LAST_NAME);
    END LOOP;
    dbms_output.put_line('( matricule:'||v_emp.MANAGER_ID||').');
    END LOOP;
END;
*/
/* Q2-1
set SERVEROUTPUT ON;
DECLARE
    cursor c_nbrcom(cus ORDERS.CUSTOMER_ID%TYPE) is
    select count(*) from ORDERS where CUSTOMER_ID=cus;
    br ORDERS.CUSTOMER_ID%TYPE;
    v_nbr number;
BEGIN
    br := '&br';
    open c_nbrcom(br);
    fetch c_nbrcom into v_nbr;
        dbms_output.put_line('le nombre de commande d’un client est: '||v_nbr);
    close c_nbrcom;
END;
*/
/* Q2-2
set SERVEROUTPUT ON;
DECLARE
    cursor curseur2(c_id orders.salesman_id%TYPE) is
    select count(*) from ORDERS where salesman_id=c_id;
    v_nbr number;
BEGIN
    for v_emp IN (select * from employees) LOOP
        open curseur2(v_emp.employee_id);
        fetch curseur2 into v_nbr;
            dbms_output.put_line('le nombre de vente de l''employé avec id ='|| v_emp.employee_id ||' est :'||v_nbr);
        close curseur2;
    END LOOP;
END;
*/
/*
SET SERVEROUTPUT ON;
declare
    total order_items.unit_price%type:=0;
    cus_id customers.customer_id%type;
    ord_id orders.order_id%type;
     i number:=0;
begin
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
end;
*/
/* Q4
SET SERVEROUTPUT ON;
declare
    total order_items.unit_price%type:=0;
    cus_id customers.customer_id%type;
    ord_id orders.order_id%type;
     i number:=0;
begin
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
end;
*/