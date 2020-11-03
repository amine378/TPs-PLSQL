-- Question 1
DECLARE
    v_nom VARCHAR(20);
    v_prenom VARCHAR(20);
BEGIN
    v_nom:=:v_nom;
    v_prenom:=:v_prenom;
    dbms_output.put_line(v_nom || ' ' || v_prenom);
END;

-- Question 2
DECLARE
    v_count INTEGER NOT NULL := 0;
    v_countIdIsOne INTEGER NOT NULL := 0;
    v_percentage INTEGER NOT NULL;
BEGIN
    -- Question 2  
    FOR employee in (SELECT * From EMPLOYEES)
    LOOP
        v_count := v_count + 1;
    END LOOP;
    DBMS_OUTPUT.PUT_LINE('Employees number is :' || v_count);

    -- Question 3
    FOR employeeId in (SELECT MANAGER_ID FROM EMPLOYEES)
    LOOP
        IF employeeId.MANAGER_ID = 1 THEN
            v_countIdIsOne := v_countIdIsOne + 1;
        END if;
    END LOOP;
    DBMS_OUTPUT.PUT_LINE('Employees with manager id 1 is : ' || v_countIdIsOne);

    --  Question 4
    v_percentage := v_countIdIsOne / v_count;
    DBMS_OUTPUT.PUT_LINE('The proportion of manager with id I is : ' || v_percentage)
END;

-- Question 5
DECLARE
    v_last_name EMPLOYEES.LAST_NAME%TYPE;
    v_first_name EMPLOYEES.FIRST_NAME%TYPE;
    v_hire_date EMPLOYEES.HIRE_DATE%TYPE;
    empId Integer;
BEGIN
    empId:=:empId;

    SELECT LAST_NAME, FIRST_NAME, HIRE_DATE
    INTO v_last_name, v_first_name, v_hire_date
    FROM EMPLOYEES
    WHERE EMPLOYEE_ID = empId
    AND ROWNUM <= 1;

    DBMS_OUTPUT.PUT_LINE('Found ' || v_last_name || ' ' || v_first_name || ' ' || v_hire_date);
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('Employee with Id ' || empId || ' does not exist');
END;


-- Question 6
DECLARE
    TYPE EMPLOYEE_REC IS RECORD (
        last_name EMPLOYEES.LAST_NAME%TYPE,
        first_name EMPLOYEES.FIRST_NAME%TYPE,
        hire_date EMPLOYEES.HIRE_DATE%TYPE
    );

    employeeRecord EMPLOYEE_REC;
    empId INTEGER;
BEGIN
    empId :=: empId;
    SELECT LAST_NAME, FIRST_NAME, HIRE_DATE
    INTO employeeRecord
    FROM EMPLOYEES
    WHERE EMPLOYEE_ID = empId
    AND ROWNUM <= 1;

    DBMS_OUTPUT.PUT_LINE('found : ' || employeeRecord.last_name || ' ' || employeeRecord.first_name || ' ' || employeeRecord.hire_date);
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('Employee with Id ' || empId || ' does not exist');
END;

-- Question 7
DECLARE
    product_rec PRODUCTS%ROWTYPE;
    v_prod_id INteger;
BEGIN
    v_prod_id :=: v_prod_id;
    SELECT *
    INTO product_rec
    FROM PRODUCTS
    WHERE PRODUCT_ID = v_prod_id;
    DBMS_OUTPUT.PUT_LINE('found : ' || product_rec.PRODUCT_NAME || ' ' || product_rec.CATEGORY_ID || ' ' || product_rec.LIST_PRICE || ' ' || product_rec.STANDARD_COST || ' ' || product_rec.DESCRIPTION);
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('Product with Id ' || v_prod_id || ' does not exist');
END;

-- Question 8
DECLARE
    r_mgr EMPLOYEES%ROWTYPE;
    r_emp EMPLOYEES%ROWTYPE;
    v_emp_Id EMPLOYEES.EMPLOYEE_ID%TYPE;
BEGIN
    v_emp_Id :=: v_em_Id;
    SELECT *
        INTO r_emp
    FROM EMPLOYEES
        WHERE EMPLOYEE_ID = v_emp_Id;

    SELECT *
        INTO r_mgr
    FROM EMPLOYEES
        WHERE EMPLOYEE_ID = r_emp.MANAGER_ID;

    DBMS_OUTPUT.PUT_LINE('Employee: ' || r_emp.EMPLOYEE_ID || ' ' || r_emp.LAST_NAME || ' ' || r_emp.FIRST_NAME || ' ' || r_emp.EMAIL || ' ' || r_emp.PHONE || ' ' || r_emp.HIRE_DATE || ' ' || r_emp.MANAGER_ID || ' ' || r_emp.JOB_TITLE );
    DBMS_OUTPUT.PUT_LINE('Manager: ' || r_mgr.EMPLOYEE_ID || ' ' || r_mgr.LAST_NAME || ' ' || r_mgr.FIRST_NAME || ' ' || r_mgr.PHONE || ' ' || r_mgr.EMAIL ||  ' ' || r_mgr.HIRE_DATE || ' ' || r_mgr.MANAGER_ID || ' ' || r_mgr.JOB_TITLE );

EXCEPTION
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('Employee with Id ' || v_emp_Id || ' does not exist');
END;

-- Question 9
DECLARE
    v_customer_Id CUSTOMERS.CUSTOMER_ID%TYPE;
    v_customer_name CUSTOMERS.NAME%TYPE;
    CURSOR curs_Orders IS SELECT * FROM ORDERS WHERE CUSTOMER_ID = v_customer_Id;
    TYPE orderTable IS TABLE OF curs_Orders%ROWTYPE;
    v_orders_rec orderTable;
    n Int := 0;
BEGIN
    OPEN curs_Orders;
    v_customer_Id :=: v_customer_Id;
    SELECT NAME INTO v_customer_name FROM CUSTOMERS WHERE CUSTOMER_ID = v_customer_Id;
    DBMS_OUTPUT.PUT_LINE('Customer ' || v_customer_name || ' has the following orders :');


    LOOP
        n := n+1;
        FETCH curs_Orders INTO v_orders_rec(n);
        EXIT WHEN curs_Orders%notfound;
    END LOOP;

    CLOSE curs_Orders;

    FOR orderItr IN curs_Orders
        LOOP
            DBMS_OUTPUT.PUT_LINE(orderItr.ORDER_ID || ' ' || orderItr.STATUS || ' ' || orderItr.SALESMAN_ID || ' ' || orderItr.ORDER_DATE);
        end loop;
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('Customer with id ' || v_customer_id || ' not found ');
END;
