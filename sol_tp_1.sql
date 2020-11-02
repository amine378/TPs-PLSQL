----------------------exo1---------------
   SET SERVEROUTPUT ON; 
DECLARE
    v_nom VARCHAR(15);
    v_prenom VARCHAR(15);
   
BEGIN
       v_nom := '&v_nom';
    
    v_prenom := '&v_prenom';
    
    
     DBMS_OUTPUT.PUT_LINE('le nom est ' || v_nom  );
     
    DBMS_OUTPUT.PUT_LINE('le prenom  est ' || v_prenom  );
END;
-------exo2------------------------------------
DECLARE
CURSOR c2 IS
    SELECT employee_id FROM EMPLOYEES; 
  counter integer := 0;
  
BEGIN
FOR n IN c2 LOOP 
  counter := counter +1;
  END LOOP;
  DBMS_OUTPUT.PUT_LINE(counter);
END;
--------------------------exo3----------------------

DECLARE
CURSOR c1 IS
    SELECT employee_id FROM EMPLOYEES
    WHERE manager_id = 1;
  counter integer := 0;
  
BEGIN
FOR n IN c2 LOOP 
  counter := counter +1;
  END LOOP;
  DBMS_OUTPUT.PUT_LINE(counter);
END;
----------------------exo4------------------------------------------------------------------------------------------------
DECLARE
CURSOR c2 IS
    SELECT employee_id FROM EMPLOYEES; 
     counter1 integer := 0;
CURSOR c1 IS
    SELECT employee_id FROM EMPLOYEES
    WHERE manager_id = 1;
  counter2 integer := 0;
  counter integer := 0;
BEGIN
FOR n IN c2 LOOP 
  counter1 := counter1 + 1;
  END LOOP;
  DBMS_OUTPUT.PUT_LINE(counter1);
  FOR n IN c1 LOOP 
  counter2 := counter2 + 1;
  END LOOP;
  DBMS_OUTPUT.PUT_LINE(counter2);
  counter := (counter2  / counter1 ) * 100;
  DBMS_OUTPUT.PUT_LINE(counter);
  
  END;
  
  ---------------------exo5-------------------------------------------------------------------------------------------
 SET SERVEROUTPUT ON;
  DECLARE
     v_last_name    EMPLOYEES.LAST_NAME %TYPE;
	 v_first_name    EMPLOYEES.FIRST_NAME %TYPE;
	 v_hire_date     EMPLOYEES.HIRE_DATE %TYPE;
	  v_ID           EMPLOYEES.EMPLOYEE_ID %TYPE;
	
	 
  BEGIN 
  v_ID := &v_ID;
    select LAST_NAME INTO v_last_name  FROM  EMPLOYEES
	 WHERE  EMPLOYEE_ID = v_ID ;
	  select FIRST_NAME INTO v_first_name  FROM EMPLOYEES 
	 WHERE  EMPLOYEE_ID = v_ID ;
      select HIRE_DATE INTO v_hire_date  FROM EMPLOYEES  
	 WHERE  EMPLOYEE_ID = v_ID ;
   DBMS_OUTPUT.PUT_LINE('le nom est ' ||  v_last_name || v_first_name || 'et date daccés ' ||  v_hire_date );
	  END;
	  ---------------------exo 6-------------------------------------------
	  
	  SET SERVEROUTPUT ON;
  DECLARE
     Enreg  EMPLOYEES%ROWTYPE;
      v_ID EMPLOYEES.MANAGER_ID%TYPE ;
BEGIN 
  v_ID := &v_ID;
    SELECT * INTO Enreg FROM  EMPLOYEES 
	 WHERE  EMPLOYEES.EMPLOYEE_ID = v_ID ;
   DBMS_OUTPUT.PUT_LINE('le nom est ' ||  Enreg.LAST_NAME|| Enreg.FIRST_NAME || 'et date daccés ' ||  Enreg.HIRE_DATE  );
END;
-------------------------------------exo7-----------------------------------------

	    SET SERVEROUTPUT ON;
  DECLARE  
     Rec  PRODUCTS%ROWTYPE;
	 v_product_id  PRODUCTS.PRODUCT_ID %TYPE ;
  BEGIN
  v_product_id := &v_product_id;
	  SELECT *  INTO Rec FROM  PRODUCTS
	  WHERE PRODUCT_ID = v_product_id ;
	  DBMS_OUTPUT.PUT_LINE('element ' ||  Rec.PRODUCT_ID ||  'element ' ||  Rec.PRODUCT_NAME ||'element ' ||  Rec.DESCRIPTION ||'element ' ||  Rec.STANDARD_COST ||'element ' ||  Rec.LIST_PRICE || 'element ' ||  Rec.CATEGORY_ID );
	 END;
-----------------------------------exo8----------------------------
      SET SERVEROUTPUT ON;
  DECLARE  
    r_mgr  EMPLOYEES%ROWTYPE;
	r_emp EMPLOYEES%ROWTYPE;
    v_ID  EMPLOYEES.EMPLOYEE_ID %TYPE;

BEGIN
  v_ID := &v_ID;
  SELECT * INTO r_emp FROM EMPLOYEES
  WHERE EMPLOYEE_ID = v_ID;
  SELECT * INTO r_mgr FROM EMPLOYEES
   WHERE   EMPLOYEE_ID = r_emp.MANAGER_ID;
   
	DBMS_OUTPUT.PUT_LINE('le nom est ' ||  r_mgr.LAST_NAME|| r_mgr.FIRST_NAME || 'et date daccés ' ||  r_mgr.HIRE_DATE || 'email' ||  r_mgr.phone ||  r_mgr.MANAGER_ID  );
  
END;
	
	--------------------------exo9-----------------------------------
	   
 SET SERVEROUTPUT ON;
  DECLARE
  CURSOR c1 IS
     SELECT ORDER_ID FROM ORDERS; 
	 counter1 NUMBER := 0;
	 v_ID NUMBER ;
  r_cust CUSTOMERS%ROWTYPE;
  r_ORD  ORDERS%ROWTYPE;
  TYPE table_O IS TABLE OF NUMBER ;
  ord_t table_O;
  BEGIN 
  v_ID := &v_ID;
 
  FOR n IN c LOOP 
  counter1 := counter1 + 1;
  END LOOP;
  FOR i IN counter1 LOOP
    SELECT ORDER_ID  INTO ord_t(i) FROM ORDERS
	WHERE CUSTOMER_ID = v_ID; 
	END LOOP;
  FOR i IN counter1 LOOP
  DBMS_OUTPUT.PUT_LINE('element ' ||  ord_t(i) );
 END;
      
	 
	

