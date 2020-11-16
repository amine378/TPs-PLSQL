/~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~QUESTION 1 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~/


SET SERVEROUTPUT ON;

DECLARE
  v_nom VARCHAR2(30);
  v_prenom VARCHAR2(30);
BEGIN
   v_nom := '&v_nom';
   v_prenom :='&v_prenom';
   
   dbms_output.put_line('votre nom est : ' || v_nom);
   dbms_output.put_line('votre prenom est : ' || v_prenom);

 

END;


/~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~QUESTION 2 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~/

SET SERVEROUTPUT ON;

DECLARE
  var1 int;
  
BEGIN
   select count(*) into var1 from employees ;
   
   dbms_output.put_line('le nombre des employés est  : ' || var1);


 

END;





/~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~QUESTION 3 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~/

SET SERVEROUTPUT ON;

DECLARE
 
  var2 int ;
  
BEGIN
   select count(*) into var2 
   from employees 
   where MANAGER_ID = 1 ;
   
   dbms_output.put_line('le nombre des employés est  : ' || var2);
   
END;


/~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~QUESTION 4 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~/


SET SERVEROUTPUT ON;

DECLARE
  var1 int;
  var2 int ;
  prop float;
  
BEGIN


   select count(*) into var1 from employees ;
    dbms_output.put_line('le nombre des employés est  : ' || var1);
   
   select count(*) into var2 from employees where MANAGER_ID = 1 ;
    dbms_output.put_line('le nombre des employés ayant le manager_id=1 est  : ' || var2);
   
   prop:=(var2/var1)*100;
   dbms_output.put_line('la proportion est  : ' || round(prop,2) || '%');
   
END;


/~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~QUESTION 5 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~/


SET SERVEROUTPUT ON;

DECLARE
    v_last_name employees.last_name%type;
    v_first_name employees.first_name%type;
    v_hire_date employees.hire_date%type;
    v_id employees.employee_id%type;
    
  
BEGIN
    v_id := &v_id;

   select employees.last_name, employees.first_name, employees.hire_date 
   into v_last_name, v_first_name , v_hire_date
   from employees 
   where employees.employee_id = v_id ;
   
  DBMS_OUTPUT.PUT_LINE('Le nom complet de l employé est  ' || v_last_name || v_first_name || ' sa date est  ' || v_hire_date );

   
END;



/~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~QUESTION 6 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~/


SET SERVEROUTPUT ON;

DECLARE
    
    empRec employees%rowtype;
    
    v_id employees.employee_id%type;
    
  
BEGIN
    v_id := &v_id;
   

   select * 
   into empRec
   from employees 
   where employees.employee_id = v_id ;
   
  DBMS_OUTPUT.PUT_LINE('Le nom complet de l employé est  ' || empRec.last_name || ' ' || empRec.first_name || ' sa date est  ' || empRec.hire_date );

   
END;

/~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~QUESTION 7~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~/

SET SERVEROUTPUT ON;

DECLARE
    
    prodRec products%rowtype;
    
    v_id products.product_id%type;
    
  
BEGIN
    v_id := &v_id;
   
   select * 
   into prodRec
   from products
   where products.product_id = v_id ;
 
   DBMS_OUTPUT.PUT_LINE('Product s description  : ' || prodRec.description );
   DBMS_OUTPUT.PUT_LINE('Product s standard cost  : ' || prodRec.STANDARD_COST );
   DBMS_OUTPUT.PUT_LINE('Product s list price : ' || prodRec.LIST_PRICE );
   DBMS_OUTPUT.PUT_LINE('Product s category id  : ' || prodRec.CATEGORY_ID );
    
END;

/~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~QUESTION 8~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~/


SET SERVEROUTPUT ON;

DECLARE
    
    r_mgr employees%rowtype;
    r_emp employees%rowtype;
    
    v_id employees.employee_id%type;
    
  
BEGIN
    v_id := &v_id;

   select * 
   into r_emp
   from employees 
   where employees.employee_id = v_id ;
   
  DBMS_OUTPUT.PUT_LINE('employee s first name  ' || r_emp.first_name );
  DBMS_OUTPUT.PUT_LINE('employee s LAST_NAME  ' || r_emp.LAST_NAME );
  DBMS_OUTPUT.PUT_LINE('employee s EMAIL      ' || r_emp.EMAIL );
  DBMS_OUTPUT.PUT_LINE('employee s PHONE  ' || r_emp.PHONE );
  DBMS_OUTPUT.PUT_LINE('employee s HIRE_DATE  ' || r_emp.HIRE_DATE );
  DBMS_OUTPUT.PUT_LINE('employee s Job title  ' || r_emp.JOB_TITLE );
  

  if r_emp.manager_id is not NULL then
			     DBMS_OUTPUT.PUT_LINE('Son manager est  ');

			  select *
			  into r_mgr
			  from employees
			  where employees.employee_id = r_emp.manager_id;
			  

			  
			  DBMS_OUTPUT.PUT_LINE('manager s first name  ' || r_mgr.first_name );
			  DBMS_OUTPUT.PUT_LINE('manager  s LAST_NAME  ' || r_mgr.LAST_NAME );
			  DBMS_OUTPUT.PUT_LINE('manager  s EMAIL      ' || r_mgr.EMAIL );
			  DBMS_OUTPUT.PUT_LINE('manager  s PHONE  ' || r_mgr.PHONE );
			  DBMS_OUTPUT.PUT_LINE('manager  s HIRE_DATE  ' || r_mgr.HIRE_DATE );
			  DBMS_OUTPUT.PUT_LINE('manager  s Job title  ' || r_mgr.JOB_TITLE );
			  
			 
			  else 
			   DBMS_OUTPUT.PUT_LINE(' He s the manager ');
end if;
   
  
  

    
END;


/~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~QUESTION 9~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~/




SET SERVEROUTPUT ON;

DECLARE
     
/******* curseur ********/
     cursor cusRec is select customer_id , name from customers ;
     cursor ordCur is select order_id ,customer_id from orders;
/******* record ********/
     ordRec orders%rowtype;
/******* collection ********/
     type v_list is table of customers.customer_id%type index by binary_integer;
     id_list v_list;
/***** autre **************/
     v_ord_id orders.order_id%type;
     counter integer := 0;
     var1 integer := 0 ; 
BEGIN
             for n in cusRec LOOP
                         counter := counter + 1;
                         id_list(counter) := n.customer_id;    
                         
                          var1 :=0;
                          select count(*) into var1 from orders where customer_id=n.customer_id; 
                                    for m in ordCur LOOP
                                        if n.customer_id=m.customer_id then
                                        dbms_output.put_line('customer('||counter||'):'||id_list(counter)|| ' ' ||n.name );
                                        select * into ordRec from orders where order_id=m.order_id;
                                              DBMS_OUTPUT.PUT_LINE('++++++++++++++++++++++' );
                                              DBMS_OUTPUT.PUT_LINE('ORDER_ID  ' ||ordRec.order_id );
                                              DBMS_OUTPUT.PUT_LINE('STATUS ' || ordRec.STATUS );
                                              DBMS_OUTPUT.PUT_LINE('SALESMAN_ID      ' || ordRec.SALESMAN_ID );
                                              DBMS_OUTPUT.PUT_LINE('ORDER_DATE ' || ordRec.ORDER_DATE );
                                              DBMS_OUTPUT.PUT_LINE('++++++++++++++++++++++' );
                                        end if;
                                    
                                    end loop;   
                                       
                end loop;
                         

END;



      