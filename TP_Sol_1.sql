SET SERVEROUTPUT ON;

/*
--Q1
      accept v_nom varchar(100) prompt 'Entrer le Nom: '
      accept v_prenom varchar(100) prompt 'Entrer le Prenom: '

	DECLARE  
	BEGIN  
		dbms_output.put_line('Entrer le Nom');
		v_nom := $v_nom;
		dbms_output.put_line('Entrer le Prenom');
		v_prenom := $v_prenom;
		
		dbms_output.put_line('le Nom      : ' || v_nom);
		dbms_output.put_line('le Prenom : ' || v_prenom);
	END;
*/
/*
--Q2
      DECLARE
            v_EmpCount NUMBER;
            v_EmpCountManagerIs1 NUMBER;
            v_EmpCountManagerIs1Prop NUMBER;
      BEGIN
            SELECT COUNT(employee_Id) INTO v_EmpCount FROM EMPLOYEES;
            dbms_output.put_line(v_EmpCount);
--Q3
            SELECT COUNT(employee_Id) INTO v_EmpCountManagerIs1 FROM EMPLOYEES WHERE Manager_Id=1;
            dbms_output.put_line(v_EmpCountManagerIs1);
--Q4
            v_EmpCountManagerIs1Prop := (v_EmpCountManagerIs1 / v_EmpCount) * 100;
            dbms_output.put_line(v_EmpCountManagerIs1Prop);
      END;
*/
/*
--Q5
      DECLARE
            v_ID                      NUMBER;
            v_Last_Name      Employees.last_Name%TYPE;
            v_First_Name      Employees.first_Name%TYPE;
            v_Hire_Date        Employees.Hire_Date%TYPE;
            r_Employee         EMPLOYEES%ROWTYPE;
      BEGIN
            dbms_output.put_line('Enter the ID : ');
            v_ID := 14;
            SELECT Last_Name INTO v_Last_Name  FROM Employees WHERE Employee_Id=v_ID;
            SELECT First_Name INTO v_First_Name FROM Employees WHERE Employee_Id=v_ID;
            SELECT Hire_Date   INTO v_Hire_Date   FROM Employees WHERE Employee_Id=v_ID;
            dbms_output.put_line('v_Last_Name  : ' ||  v_Last_Name );
            dbms_output.put_line('v_First_Name  : ' || v_First_Name);
            dbms_output.put_line('v_Hire_Date    : ' || v_Hire_Date);
--Q6
            SELECT * INTO r_Employee FROM Employees WHERE Employee_Id=v_ID;
            dbms_output.put_line('LAST NAME  : ' || R_Employee.LAST_NAME);
            dbms_output.put_line('FIRST NAME : ' || R_Employee.FIRST_NAME);
            dbms_output.put_line('HIRE DATE    : ' || R_Employee.HIRE_DATE);
      END;
*/
/*
--Q7
      DECLARE
            r_Products        Products%ROWTYPE;
            v_ProductID     NUMBER;
      BEGIN
            dbms_output.put_line('Enter the Product ID : ');
            v_ProductID := 9;
            SELECT * INTO r_Products FROM Products WHERE Product_Id=v_ProductID;
            dbms_output.put_line('Product_Id  : ' || r_Products.Product_Id);
            dbms_output.put_line('Product_Name : ' || r_Products.Product_Name);
            dbms_output.put_line('Description    : ' || r_Products.Description);
            dbms_output.put_line('Standard_Cost    : ' || r_Products.Standard_Cost);
            dbms_output.put_line('List_Price    : ' || r_Products.List_Price);
            dbms_output.put_line('Category_ID    : ' || r_Products.Category_ID);
      END;
*/
/*
--Q8
      DECLARE
            r_emp       EMPLOYEES%ROWTYPE;
            r_mgr        EMPLOYEES%ROWTYPE;
            v_EmpID   NUMBER;
      BEGIN
            dbms_output.put_line('Enter the ID : ');
            v_EmpID := 98;
            SELECT * INTO r_emp FROM employees WHERE Employee_Id=v_EmpID;
            SELECT * INTO r_mgr  FROM employees WHERE Employee_Id=r_Emp.MANAGER_ID;
            
            dbms_output.put_line('---> EMPLOYEE N°' || v_EmpID || ' DATA : ');
            dbms_output.put_line('EMPLOYEE_ID   : ' || r_emp.EMPLOYEE_ID);
            dbms_output.put_line('FIRST_NAME     : ' || r_emp.FIRST_NAME);
            dbms_output.put_line('LAST NAME       : ' || r_emp.LAST_NAME);
            dbms_output.put_line('EMAIL                 : ' || r_emp.EMAIL);
            dbms_output.put_line('PHONE                : ' || r_emp.PHONE);
            dbms_output.put_line('HIRE DATE         : ' || r_emp.HIRE_DATE);
            dbms_output.put_line('MANAGER_ID    : ' || r_emp.MANAGER_ID);
            dbms_output.put_line('JOB_TITLE           : ' || r_emp.JOB_TITLE);
            dbms_output.put_line('');

            dbms_output.put_line('---> MANAGER DATA : ');
            dbms_output.put_line('EMPLOYEE_ID   : ' || r_mgr.EMPLOYEE_ID);
            dbms_output.put_line('FIRST_NAME     : ' || r_mgr.FIRST_NAME);
            dbms_output.put_line('LAST NAME       : ' || r_mgr.LAST_NAME);
            dbms_output.put_line('EMAIL                 : ' || r_mgr.EMAIL);
            dbms_output.put_line('PHONE                : ' || r_mgr.PHONE);
            dbms_output.put_line('HIRE DATE         : ' || r_mgr.HIRE_DATE);
            dbms_output.put_line('MANAGER_ID    : ' || r_mgr.MANAGER_ID);
            dbms_output.put_line('JOB_TITLE           : ' || r_mgr.JOB_TITLE);
      END;
*/
/*
--Q9  >>WORK IN PROGRESS<<
      DECLARE
            v_CustomerID          NUMBER;
            r_Orders                   ORDERS%ROWTYPE;
            r_Customers             CUSTOMERS%ROWTYPE; 
            TYPE List_OrdersID IS TABLE OF NUMBER INDEX BY BINARY_INTEGER;
            L_OrdersID               List_OrdersID;
            i INTEGER :=0;
      BEGIN
            dbms_output.put_line('Enter the Customer ID : ');
            v_CustomerID := 98;
            SELECT * INTO r_Customers FROM CUSTOMERS WHERE Customer_Id=v_CustomerID;
            SELECT * INTO r_Orders FROM ORDERS WHERE Customer_Id=v_CustomerID;
            dbms_output.put_line('Order N°');

            --FOR n IN (SELECT * INTO r_Orders FROM ORDERS WHERE Customer_Id=v_CustomerID)
            LOOP
                  i := i + 1;
                  L_OrdersID(i) := N.order_Id;
                  dbms_output.put_line('Order N°' ||  i  ||  ' : '  ||  L_OrdersID(i));
            END LOOP;

      END; 
*/