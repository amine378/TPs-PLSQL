DECLARE
    v_CustomerID        NUMBER;
    v_CustomerExist     NUMBER;
    v_OrderID           NUMBER;
    v_OrderExist        NUMBER;
    v_OrderTotalPrice   NUMBER;

    FUNCTION f_CheckCustomerExist(v_CustomerID IN NUMBER) RETURN NUMBER IS v_CustomerExist NUMBER;
    BEGIN
        SELECT COUNT(CUSTOMER_ID) INTO v_CustomerExist FROM CUSTOMERS WHERE CUSTOMER_ID = v_CustomerID;
        RETURN v_CustomerExist;
    END f_CheckCustomerExist;

    FUNCTION f_CheckOrderExist(v_OrderID IN NUMBER) RETURN NUMBER IS v_OrderExist NUMBER;
    BEGIN
        SELECT COUNT(ORDER_ID) INTO v_OrderExist FROM ORDERS WHERE ORDER_ID = v_OrderID AND CUSTOMER_ID = v_CustomerID;
        RETURN v_OrderExist;
    END f_CheckOrderExist;

    FUNCTION f_CalculateOrderPrice(v_OrderID IN ORDERS.ORDER_ID%TYPE) RETURN NUMBER IS
        v_OrderTotalPrice NUMBER;
    BEGIN
        SELECT SUM(QUANTITY*UNIT_PRICE) INTO v_OrderTotalPrice FROM ORDER_ITEMS WHERE ORDER_ID = v_OrderID;
        RETURN v_OrderTotalPrice;
    END f_CalculateOrderPrice;

BEGIN
    v_CustomerID    :=: v_CustomerID;
    v_OrderID       :=: v_OrderID;
    v_CustomerExist := f_CheckCustomerExist(v_CustomerID);

    IF v_CustomerExist = 0 THEN
        DBMS_OUTPUT.PUT_LINE('ERROR: This Customer Doesnt Exist !!');
    ELSE
        v_OrderExist := f_CheckOrderExist(v_OrderID);

        IF v_OrderExist = 0 THEN
            DBMS_OUTPUT.PUT_LINE('ERROR: This Order Doesnt Exist For this Customer!!');
        ELSE
            v_OrderTotalPrice := f_CalculateOrderPrice(v_OrderID);
            DBMS_OUTPUT.PUT_LINE('The total price for the Order N°' || v_OrderID || ' for the Customer N°'
                                     || v_CustomerID || ' is: ' || v_OrderTotalPrice);
        END IF;
    END IF;
END;