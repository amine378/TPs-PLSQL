DECLARE
    v_CustomerID            NUMBER;
    v_OrderID               NUMBER;
    v_OrdersTotalCost       NUMBER := 0;
    v_BonusCredit           NUMBER := 50;
    v_OrderThreshold        NUMBER := 100000;
    v_EditedRowsCount       NUMBER := 0;
    r_OrderItems            ORDER_ITEMS%ROWTYPE;
    CURSOR c_GetCustomerID  IS SELECT CUSTOMER_ID FROM CUSTOMERS;
    CURSOR c_GetOrdersID    IS SELECT ORDER_ID FROM ORDERS WHERE CUSTOMER_ID=v_CustomerID;
    CURSOR c_GetOrderItems  IS SELECT * FROM ORDER_ITEMS WHERE ORDER_ID=v_OrderID;

BEGIN
    OPEN c_GetCustomerID;
    LOOP FETCH c_GetCustomerID INTO v_CustomerID; EXIT WHEN c_GetCustomerID%NOTFOUND;
        v_OrdersTotalCost := 0;
        OPEN c_GetOrdersID;
        LOOP FETCH c_GetOrdersID INTO v_OrderID; EXIT WHEN c_GetOrdersID%NOTFOUND;
            OPEN c_GetOrderItems;
            LOOP FETCH c_GetOrderItems INTO r_OrderItems; EXIT WHEN c_GetOrderItems%NOTFOUND;
                v_OrdersTotalCost := v_OrdersTotalCost + (r_OrderItems.UNIT_PRICE * r_OrderItems.QUANTITY);
            END LOOP;
            CLOSE c_GetOrderItems;
        END LOOP;
        CLOSE c_GetOrdersID;

        IF v_OrdersTotalCost > v_OrderThreshold THEN
            UPDATE CUSTOMERS
                SET CUSTOMERS.CREDIT_LIMIT = CUSTOMERS.CREDIT_LIMIT + v_BonusCredit
                WHERE CUSTOMERS.CUSTOMER_ID = v_CustomerID;
            v_EditedRowsCount := v_EditedRowsCount + 1;
            DBMS_OUTPUT.PUT_LINE('Customer: ' || v_CustomerID || ' .. Orders Total Cost: ' || v_OrdersTotalCost);
        END IF;
    END LOOP;
            DBMS_OUTPUT.PUT_LINE('v_EditedRowsCount: ' || v_EditedRowsCount);

    CLOSE c_GetCustomerID;
END;