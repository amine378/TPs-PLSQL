SET SERVEROUTPUT ON;
--Q1

      DECLARE
            v_ID                           EMPLOYEES.EMPLOYEE_ID%TYPE;
            v_FirstName             EMPLOYEES.FIRST_NAME%TYPE;
            v_LastName              EMPLOYEES.LAST_NAME%TYPE;
            v_Email                      EMPLOYEES.EMAIL%TYPE;
            v_Phone                    EMPLOYEES.PHONE%TYPE;
            v_HireDate               EMPLOYEES.HIRE_DATE%TYPE;
            v_ManagerID           EMPLOYEES.MANAGER_ID%TYPE;
            v_JobTitle                 EMPLOYEES.JOB_TITLE%TYPE;
            v_ManagerName     EMPLOYEES.LAST_NAME%TYPE;
            CURSOR c_EmployeeSummary IS 
                  SELECT * FROM EMPLOYEES;
      BEGIN
            OPEN c_EmployeeSummary;
            LOOP
                  FETCH c_EmployeeSummary 
                        INTO v_ID, v_FirstName, v_LastName, v_Email, v_Phone, v_HireDate, v_ManagerID, v_JobTitle;
                  EXIT WHEN c_EmployeeSummary%NOTFOUND;
                  SELECT LAST_NAME INTO v_ManagerName FROM EMPLOYEES WHERE EMPLOYEE_ID=v_ManagerID;
                  DBMS_OUTPUT.PUT_LINE('Employe ' || v_FirstName || ' ' || v_LastName  || 
                        ' (ID: '  ||  v_ID  || ') travaille comme ' || v_JobTitle || ' depuis ' || v_HireDate || 
                        ' sous la direction de ' || v_ManagerName  || ' (Matricule: ' || v_ManagerID || '). ');
            END LOOP;
            CLOSE c_EmployeeSummary;
      END;