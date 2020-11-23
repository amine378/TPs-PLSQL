SET SERVEROUTPUT ON;

      DECLARE
            r_emp       EMPLOYEES%ROWTYPE;
            r_mgr        EMPLOYEES%ROWTYPE;
            v_EmpID   NUMBER := &v_EmpID;
      BEGIN
            SELECT * INTO r_emp FROM employees WHERE Employee_Id=v_EmpID;
            SELECT * INTO r_mgr  FROM employees WHERE Employee_Id=r_Emp.MANAGER_ID;
            
            dbms_output.put_line('---> EMPLOYEE N°' || v_EmpID || ' DATA : ');
            dbms_output.put_line('EMPLOYEE_ID : ' || r_emp.EMPLOYEE_ID);
            dbms_output.put_line('FIRST_NAME : ' || r_emp.FIRST_NAME);
            dbms_output.put_line('LAST NAME : ' || r_emp.LAST_NAME);
            dbms_output.put_line('EMAIL : ' || r_emp.EMAIL);
            dbms_output.put_line('PHONE : ' || r_emp.PHONE);
            dbms_output.put_line('HIRE DATE : ' || r_emp.HIRE_DATE);
            dbms_output.put_line('MANAGER_ID : ' || r_emp.MANAGER_ID);
            dbms_output.put_line('JOB_TITLE : ' || r_emp.JOB_TITLE);
            dbms_output.put_line('');

            dbms_output.put_line('---> MANAGER DATA : ');
            dbms_output.put_line('EMPLOYEE_ID : ' || r_mgr.EMPLOYEE_ID);
            dbms_output.put_line('FIRST_NAME : ' || r_mgr.FIRST_NAME);
            dbms_output.put_line('LAST NAME : ' || r_mgr.LAST_NAME);
            dbms_output.put_line('EMAIL : ' || r_mgr.EMAIL);
            dbms_output.put_line('PHONE : ' || r_mgr.PHONE);
            dbms_output.put_line('HIRE DATE : ' || r_mgr.HIRE_DATE);
            dbms_output.put_line('MANAGER_ID : ' || r_mgr.MANAGER_ID);
            dbms_output.put_line('JOB_TITLE : ' || r_mgr.JOB_TITLE);
      END;
