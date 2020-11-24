---Question 2 partie 1---
SET SERVEROUTPUT ON
DECLARE 
cus_id orders.customer_id%type;
n_orders NUMBER:=0;
    CURSOR c_nbr_orders IS
        SELECT * from orders where customer_id = cus_id;
    CURSOR c_nbr_customers IS
        SELECT * from customers;
 
BEGIN
    FOR i IN c_nbr_customers LOOP
        cus_id := i.customer_id;
        FOR j IN c_nbr_orders LOOP
            n_orders := n_orders+1;
        END LOOP;
            DBMS_OUTPUT.PUT_LINE(' Le nombre de commandes du client ' || i.name ||' est: ' || n_orders);
            n_orders:=0;
    END LOOP;
END;

---Question 2 partie 2---
SET SERVEROUTPUT ON
DECLARE 
e_id number;
n_ventes NUMBER:=0;
    CURSOR c_nbr_orders IS
        SELECT * from orders where salesman_id=e_id;
        
    CURSOR c_nbr_employees IS
        SELECT * from employees;
 
BEGIN
    FOR i IN c_nbr_employees LOOP
        e_id := i.employee_id;
        FOR j IN c_nbr_orders LOOP
            n_ventes := n_ventes+1;
        END LOOP;
            DBMS_OUTPUT.PUT_LINE(' Le nombre de ventes de l employee qui a l id : ' || i.employee_id ||' est: ' || n_ventes);
            n_ventes:=0;
    END LOOP;
END;
