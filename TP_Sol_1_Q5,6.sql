--Q5
    DECLARE
        v_ID NUMBER :=: v_ID;
        v_Last_Name     Employees.last_Name%TYPE;
        v_First_Name    Employees.first_Name%TYPE;
        v_Hire_Date     Employees.Hire_Date%TYPE;
        TYPE EMPLOYEE IS RECORD (
            v_Last_Name     Employees.last_Name%TYPE,
            v_First_Name    Employees.first_Name%TYPE,
            v_Hire_Date     Employees.Hire_Date%TYPE
            );
        r_Employee EMPLOYEE;
    BEGIN
        SELECT Last_Name    INTO v_Last_Name    FROM Employees WHERE Employee_Id=v_ID;
        SELECT First_Name   INTO v_First_Name   FROM Employees WHERE Employee_Id=v_ID;
        SELECT Hire_Date    INTO v_Hire_Date    FROM Employees WHERE Employee_Id=v_ID;
        dbms_output.put_line('v_Last_Name   : ' || v_Last_Name );
        dbms_output.put_line('v_First_Name  : ' || v_First_Name);
        dbms_output.put_line('v_Hire_Date   : ' || v_Hire_Date);
--Q6
        SELECT  LAST_NAME, FIRST_NAME, HIRE_DATE
        INTO    r_Employee.v_Last_Name, r_Employee.v_First_Name, r_Employee.v_Hire_Date
        FROM    Employees
        WHERE   Employee_Id=v_ID;
        dbms_output.put_line('LAST NAME     : ' || r_Employee.v_Last_Name);
        dbms_output.put_line('FIRST NAME    : ' || r_Employee.v_First_Name);
        dbms_output.put_line('HIRE DATE     : ' || r_Employee.v_Hire_Date);
    END;