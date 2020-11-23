DECLARE
    v_ManagerName VARCHAR2(255);
    r_Emp         EMPLOYEES%ROWTYPE;
    ex_NullManagerID EXCEPTION;
    CURSOR c_EmployeeSummary IS
        SELECT * FROM EMPLOYEES;
    CURSOR c_ManagerLastName IS
        SELECT EMPLOYEES.LAST_NAME INTO v_ManagerName FROM EMPLOYEES WHERE EMPLOYEE_ID = r_Emp.MANAGER_ID;
BEGIN
    OPEN c_EmployeeSummary;
    LOOP
        BEGIN
            FETCH c_EmployeeSummary INTO r_Emp;
            EXIT WHEN c_EmployeeSummary%NOTFOUND;
            IF r_Emp.MANAGER_ID is null THEN
                RAISE ex_NullManagerID;
            END IF;
            OPEN c_ManagerLastName;
            FETCH c_ManagerLastName INTO v_ManagerName;
            DBMS_OUTPUT.PUT_LINE('Employe ' || r_Emp.FIRST_NAME || ' ' || r_Emp.LAST_NAME || ' (ID: ' ||
                                 r_Emp.EMPLOYEE_ID || ') travaille comme ' || r_Emp.JOB_TITLE || ' depuis ' ||
                                 r_Emp.HIRE_DATE || ' sous la direction de ' || v_ManagerName || ' (Matricule: ' ||
                                 r_Emp.MANAGER_ID || ').');
            CLOSE c_ManagerLastName;
            EXCEPTION
                WHEN ex_NullManagerID THEN
                    DBMS_OUTPUT.PUT_LINE('Employe ' || r_Emp.FIRST_NAME || ' ' || r_Emp.LAST_NAME || ' (ID: ' ||
                                         r_Emp.EMPLOYEE_ID || ') travaille comme ' || r_Emp.JOB_TITLE || ' depuis ' ||
                                         r_Emp.HIRE_DATE);
                WHEN others THEN
                    DBMS_OUTPUT.PUT_LINE('ERROR !');
        END;
    END LOOP;
    CLOSE c_EmployeeSummary;
END;