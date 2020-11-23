DECLARE
    v_CustomerID            NUMBER:=:v_CustomerID;
    v_EmployeeID            NUMBER:=:v_EmployeeID;
    v_CustomerOrdersCount   NUMBER;
    v_EmployeeSalesCount    NUMBER;

BEGIN
    SELECT COUNT(ORDER_ID) INTO v_CustomerOrdersCount FROM ORDERS WHERE CUSTOMER_ID=v_CustomerID;
    DBMS_OUTPUT.PUT_LINE('Client order count: ' || v_CustomerOrdersCount );

    SELECT COUNT(ORDER_ID) INTO v_EmployeeSalesCount FROM ORDERS WHERE SALESMAN_ID=v_EmployeeID;
    DBMS_OUTPUT.PUT_LINE('Employee sales count: ' || v_EmployeeSalesCount );


END;