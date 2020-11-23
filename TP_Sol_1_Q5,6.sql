SET SERVEROUTPUT ON;

--Q5
      DECLARE
            v_Last_Name Employees.last_Name%TYPE;
            v_First_Name Employees.first_Name%TYPE;
            v_Hire_Date Employees.Hire_Date%TYPE;
            r_Employee EMPLOYEES%ROWTYPE;
            v_ID NUMBER := &v_ID;
      BEGIN
            SELECT Last_Name INTO v_Last_Name FROM Employees WHERE Employee_Id=v_ID;
            SELECT First_Name INTO v_First_Name FROM Employees WHERE Employee_Id=v_ID;
            SELECT Hire_Date INTO v_Hire_Date FROM Employees WHERE Employee_Id=v_ID;
            dbms_output.put_line('v_Last_Name  : ' ||  v_Last_Name );
            dbms_output.put_line('v_First_Name  : ' || v_First_Name);
            dbms_output.put_line('v_Hire_Date    : ' || v_Hire_Date);
--Q6
            SELECT * INTO r_Employee FROM Employees WHERE Employee_Id=v_ID;
            dbms_output.put_line('LAST NAME  : ' || R_Employee.LAST_NAME);
            dbms_output.put_line('FIRST NAME : ' || R_Employee.FIRST_NAME);
            dbms_output.put_line('HIRE DATE    : ' || R_Employee.HIRE_DATE);
      END;