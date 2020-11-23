SET SERVEROUTPUT ON;
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