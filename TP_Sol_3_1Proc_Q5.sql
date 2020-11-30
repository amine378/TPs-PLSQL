DECLARE
    v_EmployeeID        NUMBER;
    v_EmployeeExist     NUMBER;
    v_EmployeeCashFlow  NUMBER;

    FUNCTION f_CheckEmployeeExist(v_EmployeeID IN NUMBER) RETURN NUMBER IS v_EmployeeExist NUMBER;
    BEGIN
        SELECT COUNT(EMPLOYEE_ID) INTO v_EmployeeExist FROM EMPLOYEES WHERE EMPLOYEE_ID = v_EmployeeID;
        RETURN v_EmployeeExist;
    END f_CheckEmployeeExist;

    FUNCTION f_CalculateCashFlow(c_CheckEmployeeExist IN NUMBER) RETURN NUMBER IS
        v_EmployeeCashFlow NUMBER;
    BEGIN
        SELECT SUM(QUANTITY * UNIT_PRICE) INTO v_EmployeeCashFlow
        FROM ORDER_ITEMS OI JOIN ORDERS O ON O.ORDER_ID = OI.ORDER_ID
        WHERE O.SALESMAN_ID=c_CheckEmployeeExist;

        IF v_EmployeeCashFlow IS NULL THEN
            v_EmployeeCashFlow := 0;
        END IF;
        RETURN v_EmployeeCashFlow;
    END f_CalculateCashFlow;

BEGIN
    v_EmployeeID :=: Enter_Employee_ID;
    v_EmployeeExist := f_CheckEmployeeExist(v_EmployeeID);
    IF v_EmployeeExist = 0 THEN
        DBMS_OUTPUT.PUT_LINE('ERROR: This Customer Doesnt Exist !!');
    ELSE
        v_EmployeeCashFlow :=f_CalculateCashFlow(v_EmployeeID);
        DBMS_OUTPUT.PUT_LINE('The CashFlow of this employee (ID: ' || v_EmployeeID ||
                             ') is: ' || v_EmployeeCashFlow || ' $.');
    END IF;
END;