-------------------- Administration de base de données -------------------- 
          -------------------- TP :3  --------------------
-- HARRASS YASSMINA

-- Procédures 

-- Question 1 :

CREATE PROCEDURE ajout_warehouse( name_warehouse IN warehouses.warehouse_name%TYPE,id_location warehouses.location_id%TYPE)
IS
i NUMBER :=0;
CURSOR c_location IS SELECT location_id  FROM locations  WHERE location_id=id_location;
BEGIN
FOR v_location IN c_location LOOP
i:=i+1;
END LOOP;
if i=1 then 
INSERT INTO warehouses(warehouse_name,location_id) VALUES(name_warehouse,id_location);
ELSE
dbms_output.put_line('ID de la location introuvable ');
END if;
END ajout_warehouse;

-- Question  2 :

CREATE PROCEDURE update_warehouse( id_warehouse IN warehouses.warehouse_id%TYPE,
name_warehouse IN warehouses.warehouse_name%TYPE,id_location warehouses.location_id%TYPE)
IS
i NUMBER :=0;
j NUMBER :=0;
CURSOR c_location IS SELECT location_id  FROM locations  WHERE location_id=id_location ;
CURSOR c_warehouse IS SELECT warehouse_id  FROM warehouses WHERE warehouse_id=id_warehouse ;
BEGIN
for v_warehouse IN c_warehouse LOOP
j:=j+1;
END LOOP;
FOR v_location IN c_location LOOP
i:=i+1;
END LOOP;
if i=1 and j=1 then 
update warehouses SET  WAREHOUSE_NAME=name_warehouse
WHERE location_id=id_location and  warehouse_id=id_warehouse;
ELSE
dbms_output.put_line('ID de la location ou de WAREHOUSE introuvable  ');
END if;
END update_warehouse;

-- Question 3 :

CREATE PROCEDURE delete_warehouse( id_warehouse IN warehouses.warehouse_id%TYPE)
IS
erreur exception ;
i NUMBER:=0;
CURSOR c_warehouse IS SELECT * FROM warehouses WHERE warehouse_id=id_warehouse;
BEGIN
FOR v_warehouse IN c_warehouse LOOP
i:=i+1;
END LOOP;
if i=1  then
DELETE FROM warehouses WHERE warehouse_id=id_warehouse;
else 
RAISE erreur;
end if;
EXCEPTION
    WHEN erreur THEN
      DBMS_OUTPUT.PUT_LINE (' ID Warehouse introuvable');
END delete_warehouse;

--Question 4:

CREATE PROCEDURE affiche_warehouses(id_location  IN warehouses.location_id%TYPE)
IS
i number :=0;
j number :=0;
CURSOR c_location IS SELECT location_id  FROM locations  WHERE location_id=id_location ;
CURSOR list_warehouses IS SELECT * FROM warehouses WHERE location_id=id_location;
BEGIN
FOR v_location IN c_location LOOP
i:=i+1;
END LOOP;
if i=1 then 
FOR v_warehouse IN list_warehouses LOOP
j:=j+1;
END LOOP;
if j>1 then
FOR v_warehouse IN list_warehouses LOOP
DBMS_OUTPUT.PUT_LINE (' ID Warehouse : ' || v_warehouse.warehouse_id || '   - Warehouse_name : ' ||v_warehouse.warehouse_name  );
END LOOP;
else 
DBMS_OUTPUT.PUT_LINE (' No warehouse founded');
end if;
else 
DBMS_OUTPUT.PUT_LINE (' ID Location introuvable');
end if;
END affiche_warehouses;

--QUESTION 5: 

CREATE PROCEDURE calcule_ca(id_employee employees.employee_id%TYPE , somme out float)
IS
CURSOR c_employee IS SELECT * FROM orders  WHERE salesman_id=id_employee;
CURSOR c_order_id( id_order order_items.order_id%TYPE) IS SELECT * FROM order_items WHERE order_id=id_order;
BEGIN
somme:=0;
FOR v_employee IN c_employee LOOP
FOR v_order_id IN c_order_id(v_employee.order_id) LOOP
somme:= somme+v_order_id.quantity*v_order_id.unit_price;
END LOOP;
END LOOP;
END calcule_ca;

-- Fonctions :

-- Question 1:


CREATE FUNCTION prix_total(id_client IN customers.customer_id%TYPE)
RETURN FLOAT IS
somme FLOAT :=0;
CURSOR c_customer IS SELECT * FROM orders  WHERE customer_id=id_client;
CURSOR c_order_id( id_order order_items.order_id%TYPE) IS SELECT * FROM order_items WHERE order_id=id_order;
BEGIN
FOR v_customer IN c_customer LOOP
FOR v_order_id IN c_order_id(v_customer.order_id) LOOP
somme:= somme+v_order_id.unit_price*v_order_id.quantity;
END LOOP;
END LOOP;
return somme;
END;


-- Question 2:

CREATE FUNCTION nombre_commande
RETURN NUMBER IS
total number;
BEGIN
SELECT count(*) INTO total FROM orders WHERE status='Pending';
return total;
END;



-- Déclencheurs 

-- QUESTION 1:


CREATE OR REPLACE TRIGGER commande
AFTER 
INSERT ON orders 
FOR EACH ROW
BEGIN
DBMS_output.put_line('ROW INSERTED : ORDER_ID ' || :new.order_id || '   CUSTOMER_ID' || :new.customer_id || '  STATUS' || :new.status || '  SALESMAN_ID' || :new.salesman_id
|| '   ORDER_DATE' || :new.order_date);
END;


-- QUESTION 2 :


CREATE OR REPLACE  TRIGGER alerte_stock 
AFTER 
INSERT OR UPDATE OR DELETE 
ON INVENTORIES
DECLARE
CURSOR c_alert_stock IS SELECT * FROM inventories WHERE quantity<10 ;
BEGIN
FOR v_alert_stock IN c_alert_stock LOOP
dbms_output.put_line(' Le stock est inferieur à 10 dans le produit : ' || v_alert_stock.product_id || '   dans le warehouse d ID '|| v_alert_stock.WAREHOUSE_id);
END LOOP;
END;
 

--QUESTION 3 :

CREATE OR REPLACE TRIGGER no_modification BEFORE 
UPDATE OF credit_limit ON customers 
FOR EACH ROW
DECLARE
v_jour NUMBER;
erreur exception;
BEGIN
SELECT to_char(sysdate,'DD') JOUR  INTO v_jour FROM DUAL;
IF v_jour>=27 and v_jour<=30 then
RAISE_application_error(-20000,'Vous ne pouvez pas modifier');
end if;
END;

-- Question 4 :

CREATE OR REPLACE TRIGGER ajout_employee
BEFORE INSERT ON employees
FOR EACH ROW
DECLARE
v_date date;
v_date_utilisateur date:= to_date(:new.hire_date,'DD-MM-RR');
BEGIN
SELECT sysdate INTO v_date from dual;
if v_date<v_date_utilisateur then
RAISE_application_error(-20000,'Vous ne pouvez pas insérer');
end if;
END;


--question 5 :

CREATE OR REPLACE TRIGGER remise 
BEFORE
INSERT 
ON order_items     
FOR EACH ROW 
DECLARE
somme float :=0;
i number :=0;
j number :=0;
CURSOR c_product_insert IS SELECT  product_id FROM products where product_id = :NEW.product_id;
cursor c_orders_insert IS SELECT  order_id from orders where order_id = :NEW.order_id;
CURSOR c_distinct_order_id IS SELECT distinct order_id FROM order_items;
CURSOR c_summe(id_order NUMBER) IS SELECT * from order_items where  order_id=id_order;
BEGIN
if inserting then 
for v_product IN c_product_insert LOOP
i:=i+1;
END LOOP;
for v_order IN c_orders_insert LOOP
j:=j+1;
END LOOP;
if i=1 then
if j=1 then
FOR v_distinct IN c_distinct_order_id LOOP
FOR v_summe IN c_summe(v_distinct.order_id) LOOP
somme := somme +v_summe.quantity*v_summe.unit_price;
END LOOP;
if somme>10000 then 
somme:=somme-somme*(5/100);
dbms_output.put_line('le prix de la  commande d ID  ' ||  v_distinct.order_id || ' apres reduction 5% est   ' || somme );
end if;
END LOOP;
else 
RAISE_application_error(-20000,'Vous ne pouvez pas faire l insertion ');
end if;
else
RAISE_application_error(-20000,'Vous ne pouvez pas faire l insertion ');
end if;
end if;
END;























