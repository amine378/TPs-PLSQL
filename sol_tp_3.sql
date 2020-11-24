--------------- procedure

---------------------question 1
declare
procedure insertWareHouses(id_location in number,warehouses_name in varchar2,warehouse_id in number) 
begin
insert into warehouses(warehouse_id,warehouse_name,location_id) values (id_location,warehouse_name,warehouse_id);
end;
v_warehouse_name varchar2(255) := '&warehouse_name'
v_warehouse_id number :=&warehouse_id;
v_location_id number :=&location_id;
begin
insertWareHouse(v_warehouse_id,v_warehouse_name,v_location_id);
end;
--------------------------question 2

declare
procedure updateWareHouses(id_location in number,warehouses_name in varchar2,warehouse_id in number) 
begin
update wharehouses set warehouse_id=warehouse_id and warehouse_name=warehouse_name where id_location)id_location;
end;
v_location_id number :=&location_id;
v_warehouse_name varchar2(255) := '&warehouse_name'
v_warehouse_id number :=&warehouse_id;

begin
updateWareHouse(v_warehouse_id,v_warehouse_name,v_location_id);
end;
---------------------------------------question3
declare
procedure deleteWareHouses(id_location in number,warehouses_name in varchar2,warehouse_id in number) 
begin
delete from wharehouses where warehouse_id=warehouse_id and warehouse_name=warehouse_name where id_location)id_location;
end;
v_location_id number :=&location_id;
v_warehouse_name varchar2(255) := '&warehouse_name'
v_warehouse_id number :=&warehouse_id;

begin
deleteWareHouse(v_warehouse_id,v_warehouse_name,v_location_id);
end;
-----------------------question4
declare
procedure afficherWareHouses(id_location in number) 
begin
select * from locations inner join warehouses warehouses.location_id=locations.location_id where location_id=id_location ;
end;
v_location_id number :=&location_id;


begin
afficherWareHouse(v_id_location);
end;



----------------------question 5
declare
procedure calculeCA(id_employee in number,ca out number) 
begin
select sum(quantity*unit_price) into ca from (orders o inner join  order_item i on o.order_id=i.order_id ) inner join employees e on o.salesman_id=e.employee_id where employee_id=id_employee ;

end;
v_id number := &id
v_ca number;

begin
calculeCA(v_id,v_ca);
dbms_output.put_line(v_ca);
end;

------------fonctions----------------

-----------------------------question 1
declare
function calculPrxTotal(id_customer in numer)
return number is
prix_total number;
begin
select sum(unit_price) into prix_total from (orders o inner join order_item i on o.order_id=i.order_id) inner join customers c on o.customers_id=c.customers_id where customer_id=id_customer;
return prix_total;
end;
v_id number :=&id;
v_prix_total  number;
begin
 v_prix_total := calculPrixTotal(v_id);
dbms_output.put_line(v_prix);

end;
 -------------------------------question2
declare
function nbCommande()
return number is
nb_commande number;
begin
select count(order_id) into nb_commande from orders where status='Pending'
return nb_commande;
end;

v_nb_commande number;
begin
 v_nb_commande := nbCommande();
dbms_output.put_line(v_nb_commande);

end;
----------------------------------triggers-------------------
-----------------------question1

create or replace trigger 
after insert on orders
when(new.order_id>0)
for each row 
declare
begin
dbms_output.put_line('order id '+:new.order_id +'customer id'+:new.customer_id);
end;

----------------------------question2
create or replace trigger
after insert on inventories
when(:new.quantity <10)
for each row 
declare
begin
dbms_output.put_line('alerte : quantity <10');
end;
--------------------------------question3

---------------------------question4

create or replace trigger 
before insert on employees
when(:new.hire_date < sysdate)
for each row 
begin
dbms_output.put_line('hire date est < que la date d auj');
end;
----------------------------------question5
create or replace
after insert on order_items
when(:new.unit_price >10000)
for each row
begin
update order_items set unit_price +=unit_price*(1-unit_price);
end;







