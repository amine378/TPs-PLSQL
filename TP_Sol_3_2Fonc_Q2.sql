DECLARE
    v_TotalPendingOrders   NUMBER;

    FUNCTION f_CountPendingOrders RETURN NUMBER IS v_TotalPendingOrders NUMBER;
    BEGIN
        SELECT COUNT(ORDER_ID) INTO v_TotalPendingOrders FROM ORDERS WHERE STATUS = 'Pending';
        RETURN v_TotalPendingOrders;
    END f_CountPendingOrders;

BEGIN
    v_TotalPendingOrders := f_CountPendingOrders();
    DBMS_OUTPUT.PUT_LINE('The Number of orders with status "Pending" is: ' || v_TotalPendingOrders);
END;