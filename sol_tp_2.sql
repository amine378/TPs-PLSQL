----------------------------EXO1-------------------------------
SET SERVEROUTPUT ON
DECLARE
c_id_employ employees.employee_id%TYPE;
c_nom       employees.last_name%TYPE;
c_prenom   employees.first_name%TYPE;
c_job    employees.job_title%TYPE;
c_date  employees.hire_date%TYPE;
c_id_man employees.manager_id%TYPE;
c_nomman employees.last_name%TYPE;
CURSOR c_employee IS 
SELECT employee_id , last_name , first_name , job_title , hire_date , manager_id FROM  employees ;
BEGIN 
OPEN c_employee ;
LOOP 
  FETCH c_employee INTO c_id_employ ,c_nom , c_prenom  ,c_job , c_date , c_id_man ;
       EXIT WHEN c_employee%notfound;
	    if c_id_man is not null then
       SELECT last_name INTO c_nomman FROM EMPLOYEES 
       WHERE employee_id = c_id_man ;
      DBMS_OUTPUT.PUT_LINE('employee' || c_nom || ' '||c_prenom || 'ID :' || c_id_employ || 'job' || c_job || 'hire date ' || c_date ||'manAger ' || c_nomman  ||'id' || c_id_man  );
   END IF;
   END LOOP;
   CLOSE c_employee ;
      
END;     
---------------------------------EXO2------------------------------------------
SET SERVEROUTPUT ON
DECLARE
CURSOR c_order IS 
   SELECT order_id , customer_id ,SALESMAN_ID FROM orders;
CURSOR c_sale IS 
    SELECT SALESMAN_ID FROM orders;
c1 NUMBER :=0;
c2 NUMBER :=0;
v_id CUSTOMERS.customer_id%TYPE;  
BEGIN 
v_id := '&v_id'; --entrer id client 
FOR n IN c_order LOOP
 IF v_id = n.customer_id THEN 
    IF n.order_id  is not null THEN 
    c1 := c1 + 1;
    END IF;
 END IF;
 END LOOP;
 DBMS_OUTPUT.PUT_LINE('le nombre dordre ' || c1 );
 ------------------------------------
 FOR m IN c_sale LOOP
   IF m.SALESMAN_ID  is not null THEN 
   DBMS_OUTPUT.PUT_LINE('saler: ');
     FOR l IN c_order LOOP
         IF (m.SALESMAN_ID = l.SALESMAN_ID  ) AND (l.order_id is not null) THEN 
           DBMS_OUTPUT.PUT_LINE('L ordre ' || l.order_id );
          END IF;
      END LOOP;
      END IF;
  END LOOP;    
      
      
END;
----------------------exo3----------------------------------------

----------------------------------exo33-----------------------------------
SET SERVEROUTPUT ON    
DECLARE

      CURSOR c_cust;
      SELECT customer_id ,
      SUM(QUANTITY * UNIT_PRICE)
      FROM orders 
      INNER JOIN order_items USING( order_id )
      group by customer_id 
      having SUM(QUANTITY * UNIT_PRICE) > 2000;
      COUNTER  integer;
BEGIN
COUNTER := 0;
 for nin c_cust loop
   update customers set credit_limit=credit_limit+50
   where customer_id=n.customer_id;
   counter := counter + 1;
   end loop;
   DBMS_OUTPUT.PUT_LINE('Nombre de lignes affectés est :' || counter);
END;


---------------------------exo 5-----------------------------

	
	SET SERVEROUTPUT ON
DECLARE
CURSOR c_empl IS 
 select * FROM employee ; 
 CURSOR c_ord IS 
 select * FROM ORDERS 
 WHERE order_date between v_date_a and v_date_f;
 v_date_a DATE;
 v_date_f DATE;
 v_id employee_id%TYPE ;
 c1 NUMBER := 0 ;
 total_rows  NUMBER(3) := 0;
 taux number := 0;
BEGIN 
v_date_a := '&v_date_a';
v_date_f := '&v_date_f';
v_id := '&v_id';
    FOR n IN c_ord LOOP 
     IF (n.employee_id  = v_id ) AND (v_date_a < n.hire_date)THEN 
        c1 := c1 + 1;
     END IF;
     END LOOP;
  select order_id  FROM ORDERS ;
   total_rows := sql%rowcount;
      taux =: (c1 \  total_rows)*100 ;
    DBMS_OUTPUT.PUT_LINE( 'le taux est ' || taux );  
     
     END;
   


