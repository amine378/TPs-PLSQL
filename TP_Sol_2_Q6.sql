DECLARE
    v_ManagerID         NUMBER :=: v_ManagerID;
    v_SubordinateID     NUMBER;
    v_OrdersCount       NUMBER;
    v_TotalOrdersCount  NUMBER := 0;
    v_ManagerExist      NUMBER;
    ex_ManagerIDWrong   EXCEPTION;
    CURSOR c_GetManagerExist IS SELECT COUNT(EMPLOYEE_ID) FROM EMPLOYEES WHERE EMPLOYEE_ID=v_ManagerID;
    CURSOR c_GetSubordinates IS SELECT EMPLOYEE_ID FROM EMPLOYEES WHERE MANAGER_ID=v_ManagerID;
BEGIN
    OPEN  c_GetManagerExist;
    FETCH c_GetManagerExist INTO v_ManagerExist;
    CLOSE c_GetManagerExist;
    IF v_ManagerExist = 0 THEN
        RAISE ex_ManagerIDWrong;
    END IF;

    OPEN c_GetSubordinates;
    LOOP FETCH c_GetSubordinates INTO v_SubordinateID;
        EXIT WHEN c_GetSubordinates%NOTFOUND;
        SELECT COUNT(ORDER_ID) INTO v_OrdersCount FROM ORDERS WHERE SALESMAN_ID=v_SubordinateID;
        v_TotalOrdersCount := v_TotalOrdersCount + v_OrdersCount;
    END LOOP;
    CLOSE c_GetSubordinates;
    DBMS_OUTPUT.PUT_LINE('Total Orders Count for this manager is: ' || v_TotalOrdersCount);

EXCEPTION
    WHEN ex_ManagerIDWrong THEN
        DBMS_OUTPUT.PUT_LINE('Wrong Manager ID !!');
    WHEN others THEN
        DBMS_OUTPUT.PUT_LINE('ERROR !!');
END;