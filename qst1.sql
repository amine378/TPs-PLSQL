---Question 1---
SET SERVEROUTPUT ON
DECLARE 
    CURSOR c_employees IS
        SELECT first_name, last_name, employee_id, job_title, hire_date, manager_id from EMPLOYEES;
        last_name_mg employees.last_name%type;
   
    BEGIN
        FOR i IN c_employees LOOP
            IF i.manager_id IS NOT NULL THEN
                SELECT last_name INTO last_name_mg FROM employees WHERE employee_id=i.manager_id;
                DBMS_OUTPUT.PUT_LINE('La situation de l employee est: EMPLOYEE ' || i.first_name || i.last_name || ' de ID ' || i.employee_id || ' travaille comme ' || i.job_title || ' depuis ' || i.hire_date || ' sous la direction de ' || last_name_mg || ' de matricule:' || i.manager_id);
            ELSE
                DBMS_OUTPUT.PUT_LINE('La situation de l employee est: EMPLOYEE ' || i.first_name || i.last_name || ' de ID ' || i.employee_id || ' travaille comme ' || i.job_title || ' depuis ' || i.hire_date || ' le directeur n a pas de manager');
            END IF;
        END LOOP;
END;
