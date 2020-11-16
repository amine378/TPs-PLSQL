------qst1
set serverout on ;
declare 
cursor emp_demo is
select * from EMPLOYEES ;
begin
for n in emp_demo loop
dbms_output.put_line('Employé ' || n.FIRST_NAME || n.LAST_NAME || ' (ID : ' || n.EMPLOYEE_ID || ' ) 
travaille comme ' || n.JOB_TITLE || ' depuis ' || n.HIRE_DATE || ' sous la direction de '||
n.LAST_NAME || ' (matricule : ' || n.MANAGER_ID || ')');
end loop;
end ;
-----quest2-1
set SERVEROUTPUT ON;
DECLARE
    indexx number;
    br number;
    cursor cmd_mod(elm number) is
    select count(ORDER_ID) from ORDERS where CUSTOMER_ID=elm;
BEGIN
    br := '&br';
    open cmd_mod(br);
    fetch cmd_mod into indexx;
        dbms_output.put_line('le nombre de commande d’un client est: '||indexx);
    close cmd_mod;
END;
-----quest2-2
set SERVEROUTPUT ON;
DECLARE
    indexx number;
    br number;
    cursor cmd_mod(elm number) is
    select count(STATUS) from ORDERS where SALESMAN_ID=elm;
BEGIN
    br := '&br';
    open cmd_mod(br);
    fetch cmd_mod into indexx;
        dbms_output.put_line('le nombre de vente  de l employee ' || br ||' est: '|| indexx);
    close cmd_mod;
END;
-----quest3
set SERVEROUTPUT ON;
DECLARE
    indexx number;
    br number;
    cursor cmd_mod is
    select count(*) from CUSTOMERS where CREDIT_LIMIT > 2000;

BEGIN
    update CUSTOMERS set
    CREDIT_LIMIT = CREDIT_LIMIT + 50 where  CREDIT_LIMIT > 2000;
    open cmd_mod;
    fetch cmd_mod into indexx;
        dbms_output.put_line('le nombre de vente  de l employee ' || br ||' est: '||indexx);
    close cmd_mod;
END;
-----quest4
set SERVEROUTPUT ON;
DECLARE
    indexx number;
    br number;
    cursor cmd_mod is
    select count(*) from CUSTOMERS where CREDIT_LIMIT > 10000;

BEGIN
    update CUSTOMERS set
    CREDIT_LIMIT = CREDIT_LIMIT + 50 where  CREDIT_LIMIT > 10000;
    open cmd_mod;
    fetch cmd_mod into indexx;
        dbms_output.put_line('le nombre de vente  de l employee ' || br ||' est: '||indexx);
    close cmd_mod;
END;
-----quest5
set serverout on ;
declare 
indexx float ;
br float ;
cursor taux(nbr float) is
select   (count(STATUS) / (select count(STATUS) from ORDERS where STATUS = 'Shipped'))*100 
taux_vente from ORDERS where STATUS = 'Shipped' and SALESMAN_ID = nbr group by SALESMAN_ID;
begin
br := '&br' ;
open taux(br) ;
fetch taux into indexx ;
dbms_output.put_line('le taux de lemployer portant lid ' || br || ' est de ' || indexx || '%' );
close  taux ;
end ;
