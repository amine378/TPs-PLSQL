DECLARE
    v_EmployeeID                NUMBER :=: v_EmployeeID;
    v_StartDate                 VARCHAR(20) :=: v_StartDate;
    v_FinishDate                VARCHAR(20) :=: v_FinishDate;
    v_TotalOrdersCount          NUMBER;
    v_successfulOrdersCount     NUMBER;
    v_EmployeeSaleRate          NUMBER;
    CURSOR c_GetTotalOrdersCount IS
        SELECT COUNT(ORDER_ID) FROM ORDERS WHERE SALESMAN_ID=v_EmployeeID;
    CURSOR c_GetSuccessfulOrdersCount IS
        SELECT COUNT(ORDER_ID) FROM ORDERS WHERE SALESMAN_ID=v_EmployeeID
                                             AND STATUS='Shipped'
                                             AND ORDER_DATE BETWEEN TO_DATE(v_StartDate, 'yyyy/mm/dd')
                                                                AND TO_DATE(v_FinishDate, 'yyyy/mm/dd');
BEGIN

    OPEN c_GetTotalOrdersCount;
    FETCH c_GetTotalOrdersCount INTO v_TotalOrdersCount;
    CLOSE c_GetTotalOrdersCount;

    OPEN c_GetSuccessfulOrdersCount;
    FETCH c_GetSuccessfulOrdersCount INTO v_successfulOrdersCount;
    CLOSE c_GetSuccessfulOrdersCount;

    v_EmployeeSaleRate := (v_successfulOrdersCount / v_TotalOrdersCount) * 100;

    DBMS_OUTPUT.PUT_LINE('Employee ID: ' || v_EmployeeID);
    DBMS_OUTPUT.PUT_LINE('v_TotalOrdersCount: ' || v_TotalOrdersCount);
    DBMS_OUTPUT.PUT_LINE('v_successfulOrdersCount: ' || v_successfulOrdersCount);
    DBMS_OUTPUT.PUT_LINE('Sale Rate  : ' || v_EmployeeSaleRate || '%');

END;