/* QUESTION 1*/
SET SERVEROUTPUT ON
DECLARE
 v_nom VARCHAR(20);
 v_prenom VARCHAR(20);
BEGIN
v_nom:='&v_nom';
v_prenom:='&v_prenom';
dbms_output.put_line('Votre nom complet est : ' ||v_nom ||' '|| v_prenom);
END;

/*QUESTION 2*/
SET SERVEROUTPUT ON
DECLARE
nbr_employee number;
BEGIN
SELECT COUNT(*)INTO nbr_employee FROM employees;
dbms_output.put_line('Le nombre des emplyees est '||nbr_employee);
END;

/*QUESTION 3*/
SET SERVEROUTPUT ON
DECLARE
nbr_employee number;
BEGIN
SELECT COUNT(*)INTO nbr_employee FROM employees WHERE manager_id=1;
dbms_output.put_line('Le nombre des emplyees est '||nbr_employee);
END;

/*QUESTION 2-3-4*/
SET SERVEROUTPUT ON
DECLARE
nbr_employee number;
nbr_employee1 number;
proportion number;
BEGIN
SELECT COUNT(*)INTO nbr_employee FROM employees;
SELECT COUNT(*)INTO nbr_employee1 FROM employees WHERE manager_id=1;
proportion:=(nbr_employee1/nbr_employee)*100;
dbms_output.put_line('Le pourcentage des employees qui ont un ID egale a 1 est : '||proportion);
END;


/*QUESTION 5*/
SET SERVEROUTPUT ON
DECLARE
v_firstname employees.first_name%TYPE;
v_lastname employees.last_name%TYPE;
v_hire_date employees.hire_date%TYPE;
id_emp employees.employee_id%TYPE;
BEGIN
id_emp:=&id_emp;
SELECT first_name,last_name,hire_date INTO v_lastname,v_firstname,v_hire_date FROM employees WHERE employee_id=id_emp;
dbms_output.put_line('L employee choisi est : '||v_lastname||' '||v_firstname||' '||v_hire_date);
END;

/*QUESTION6*/
SET SERVEROUTPUT ON
DECLARE
TYPE employee_rect IS RECORD
(
first_name employees.first_name%TYPE,
last_name employees.last_name%TYPE,
hire_date employees.hire_date%TYPE
);
employee_rec employee_rect;
id_emp employees.employee_id%TYPE;
BEGIN
id_emp:=&id_emp;
SELECT first_name,last_name,hire_date INTO employee_rec FROM employees WHERE employee_id=id_emp;
dbms_output.put_line('L employee choisi est : '||employee_rec.last_name||' '||employee_rec.first_name||' '||employee_rec.hire_date);
END;

/*QUESTION7*/

SET SERVEROUTPUT ON
DECLARE
products_rec products%ROWTYPE;
id_pro products.product_id%TYPE;
BEGIN
id_pro:=&id_pro;
SELECT * INTO products_rec FROM products WHERE product_id=id_pro;
dbms_output.put_line('Le produit choisi choisi est : ID : '||products_rec.product_id||' Le nom du produit : '||products_rec.product_name||' Sa description : '||products_rec.description||' le cout est : '||products_rec.standard_cost||' prix de vente : '||products_rec.list_price||' son ID de categorie : '||products_rec.category_id);
END;

/*QUESTION8*/
SET SERVEROUTPUT ON
DECLARE
r_emp employees%ROWTYPE;
r_mgr employees%ROWTYPE;
id_emp NUMBER;
BEGIN
id_emp:=&id_emp;
SELECT * INTO r_emp FROM employees WHERE employee_id=id_emp;
IF id_emp>1 THEN
SELECT * INTO r_mgr FROM employees WHERE employee_id=r_emp.manager_id;
END IF;
IF id_emp=1 THEN 
dbms_output.put_line('L employee choisi est : '||r_emp.last_name||' '||r_emp.first_name||' '||r_emp.email||' '||r_emp.phone||' '||r_emp.hire_date||' '||r_emp.job_title);
dbms_output.put_line('C est le President!!!!! il manage soi meme');
ELSE
dbms_output.put_line('L employee choisi est : '||r_emp.last_name||' '||r_emp.first_name||' '||r_emp.email||' '||r_emp.phone||' '||r_emp.hire_date||' '||r_emp.job_title);
dbms_output.put_line('son manager est : '||r_mgr.last_name||' '||r_mgr.first_name||' '||r_mgr.email||' '||r_mgr.phone||' '||r_mgr.hire_date||' '||r_mgr.job_title);
END IF;
END;

/*QUESTION9*/ /* JUST AN INNOCENT TRY */ /*NOT WORKING*/
SET SERVEROUTPUT ON
DECLARE
r_cus customers%ROWTYPE;
r_ord orders%ROWTYPE;
id_cus NUMBER;
id_ord NUMBER;

CURSOR n_customers is SELECT * from orders where customer_id=id_cus;

BEGIN
id_cus:=&id_cus;
SELECT * INTO r_cus FROM customers WHERE customer_id=id_cus;
FOR n IN n_customers LOOP
SELECT * INTO r_ord FROM orders WHERE customer_id=id_cus;
dbms_output.put_line('L employee choisi est : '||r_ord.status);
END LOOP;
END;












