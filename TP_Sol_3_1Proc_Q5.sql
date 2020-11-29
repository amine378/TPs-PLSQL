DECLARE
    v_EmployeeID        NUMBER :=: v_EmployeeID;
    v_EmployeeCashFlow   NUMBER;

    CURSOR c_CheckEmployeeExist IS
        SELECT EMPLOYEE_ID FROM EMPLOYEES WHERE EMPLOYEE_ID = v_EmployeeID;

    FUNCTION f_CalculateCashFlow(c_CheckEmployeeExist IN NUMBER) RETURN NUMBER IS
        v_EmployeeCashFlow NUMBER;
    BEGIN
        SELECT SUM(QUANTITY * UNIT_PRICE)
        INTO v_EmployeeCashFlow
        FROM ORDER_ITEMS OI JOIN ORDERS O ON O.ORDER_ID = OI.ORDER_ID
        WHERE O.SALESMAN_ID=c_CheckEmployeeExist;

        IF v_EmployeeCashFlow IS NULL THEN
            v_EmployeeCashFlow := 0;
        END IF;

        RETURN v_EmployeeCashFlow;
    END f_CalculateCashFlow;

BEGIN
    OPEN  c_CheckEmployeeExist;
    FETCH c_CheckEmployeeExist INTO v_EmployeeID;
    IF c_CheckEmployeeExist%NOTFOUND THEN
        DBMS_OUTPUT.PUT_LINE('ERROR: This Customer Doesnt Exist !!');
    ELSE
        v_EmployeeCashFlow :=f_CalculateCashFlow(v_EmployeeID);
        DBMS_OUTPUT.PUT_LINE('The CashFlow of this employee (ID: ' || v_EmployeeID ||
                             ') is: ' || v_EmployeeCashFlow || ' $.');
    END IF;
    CLOSE c_CheckEmployeeExist;
END;