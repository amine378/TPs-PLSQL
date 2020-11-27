DECLARE
    v_CustomerID        NUMBER :=: v_CustomerID;
    v_OrderID           NUMBER :=: v_OrderID;
    v_OrderTotalPrice   NUMBER;

    CURSOR c_CheckClientExist IS SELECT CUSTOMER_ID FROM CUSTOMERS WHERE CUSTOMER_ID = v_CustomerID;
    CURSOR c_CheckOrderExist IS SELECT ORDER_ID FROM ORDERS WHERE ORDER_ID = v_OrderID AND CUSTOMER_ID = v_CustomerID;

    FUNCTION f_CalculateOrderPrice(v_OrderID IN ORDERS.ORDER_ID%TYPE) RETURN NUMBER IS
        v_OrderTotalPrice NUMBER;
    BEGIN
        SELECT SUM(QUANTITY*UNIT_PRICE) INTO v_OrderTotalPrice FROM ORDER_ITEMS WHERE ORDER_ID = v_OrderID;
        RETURN v_OrderTotalPrice;
    END f_CalculateOrderPrice;

BEGIN
    OPEN  c_CheckClientExist;
    FETCH c_CheckClientExist INTO v_CustomerID;
    IF c_CheckClientExist%NOTFOUND THEN
        DBMS_OUTPUT.PUT_LINE('ERROR: This Customer Doesnt Exist !!');
        CLOSE c_CheckClientExist;
    ELSE

        OPEN  c_CheckOrderExist;
        FETCH c_CheckOrderExist INTO v_OrderID;
        IF c_CheckOrderExist%NOTFOUND THEN
            DBMS_OUTPUT.PUT_LINE('ERROR: This Order Doesnt Exist For this Customer!!');
            CLOSE c_CheckOrderExist;

        ELSE
            v_OrderTotalPrice := f_CalculateOrderPrice(v_OrderID);
            DBMS_OUTPUT.PUT_LINE('The total price for the Order N°' || v_OrderID || ' for the Customer N°'
                                     || v_CustomerID || ' is: ' || v_OrderTotalPrice);

        END IF;
    END IF;
END;