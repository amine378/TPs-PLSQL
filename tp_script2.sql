-- Quest 1
DECLARE
    CURSOR employeeCursor is
        SELECT  EMPLOYEE_ID,  FIRST_NAME, LAST_NAME, JOB_TITLE, HIRE_DATE, MANAGER_ID
        FROM EMPLOYEES;
    managerLastName EMPLOYEES.LAST_NAME%TYPE;
    output VARCHAR(200);
BEGIN
    FOR fetchedData IN employeeCursor
    LOOP
        output := 'l’employé: ' || fetchedData.FIRST_NAME || fetchedData.LAST_NAME
                || ' (ID: ' || fetchedData.EMPLOYEE_ID || ') travaille comme '
                || fetchedData.JOB_TITLE || ' depuis ' || fetchedData.HIRE_DATE;

        IF fetchedData.MANAGER_ID IS NOT NULL THEN
            SELECT LAST_NAME INTO managerLastName FROM EMPLOYEES WHERE EMPLOYEE_ID = fetchedData.MANAGER_ID;
            output := output || ' sous la direction de ' || managerLastName
                            || ' (matricule: '|| fetchedData.MANAGER_ID || ')';
        END IF;

        DBMS_OUTPUT.PUT_LINE(output);
    END LOOP;
END;

-- Quest 2
DECLARE
    clientId CUSTOMERS.CUSTOMER_ID%type;
    CURSOR cusOrdCursor is
        SELECT C.CUSTOMER_ID, NAME, COUNT(ORDER_ID) AS CNT
        FROM CUSTOMERS C Join ORDERS O on C.CUSTOMER_ID = O.CUSTOMER_ID
        WHERE C.CUSTOMER_ID = clientId
        GROUP BY  C.CUSTOMER_ID, NAME;

    CURSOR empOrdCursor IS
        SELECT EMPLOYEE_ID, FIRST_NAME, LAST_NAME, COUNT(ORDER_ID) AS CNT
        FROM EMPLOYEES E JOIN ORDERS O on E.EMPLOYEE_ID = O.SALESMAN_ID
        GROUP BY EMPLOYEE_ID, FIRST_NAME, LAST_NAME;

BEGIN
    clientId :=: clientId;

    FOR customer IN cusOrdCursor
    LOOP
        DBMS_OUTPUT.PUT_LINE('Client : ' || customer.CUSTOMER_ID || ' ' || customer.NAME
                                 || ' a commandé ' || customer.CNT);
    END LOOP;

    DBMS_OUTPUT.NEW_LINE();
    FOR employee IN empOrdCursor
    LOOP
        DBMS_OUTPUT.PUT_LINE('Employé : ' || employee.EMPLOYEE_ID || ' ' || employee.FIRST_NAME
                                 || ' ' || employee.LAST_NAME || ' a vendu ' || employee.CNT);
    END LOOP;
END;

-- Quest 3
CREATE PROCEDURE checkClientSpendings(cond IN INTEGER)
AS
    CURSOR creditCursor IS
    SELECT C.CUSTOMER_ID, SUM(OI.UNIT_PRICE * OI.QUANTITY) AS MONEY
    FROM ORDERS O JOIN CUSTOMERS C on C.CUSTOMER_ID = O.CUSTOMER_ID  JOIN ORDER_ITEMS OI on O.ORDER_ID = OI.ORDER_ID
    WHERE O.STATUS = 'Shipped'
    GROUP BY C.CUSTOMER_ID;
    counter INTEGER := 0;
BEGIN
    FOR fetchedData IN creditCursor LOOP
        DBMS_OUTPUT.PUT_LINE(fetchedData.CUSTOMER_ID || ' : ' || fetchedData.MONEY);
        IF fetchedData.MONEY >= cond THEN
            UPDATE OT.CUSTOMERS
            SET CREDIT_LIMIT = CREDIT_LIMIT + 50 WHERE CUSTOMER_ID = fetchedData.CUSTOMER_ID;
            counter := counter + 1;
        END IF;
    END LOOP;

    DBMS_OUTPUT.PUT_LINE(counter);
END;

BEGIN
    checkClientSpendings(2000);
END;
-- Quest 4
BEGIN
    checkClientSpendings(10000);
END;

-- Quest 5
DECLARE
    avgCnt FLOAT := 0;
    empId EMPLOYEES.EMPLOYEE_ID%type;
    dateStart VARCHAR(25);
    dateEnd VARCHAR(25);
    qt ORDER_ITEMS.QUANTITY%type;
    total INTEGER;
    CURSOR traverseCursor IS
    SELECT ORDER_ID ,ORDER_DATE , EMPLOYEE_ID
    FROM EMPLOYEES E JOIN ORDERS O
    ON E.EMPLOYEE_ID = O.SALESMAN_ID;
BEGIN
    empId :=: empId;
    dateStart :=: dateStart;
    dateEnd :=: dateEnd;

    SELECT SUM(QUANTITY) INTO total
    FROM ORDER_ITEMS OI JOIN  ORDERS O on OI.ORDER_ID = O.ORDER_ID
    WHERE SALESMAN_ID = empId;

    FOR sales IN traverseCursor LOOP
        IF empId = sales.EMPLOYEE_ID
               AND sales.ORDER_DATE >= TO_DATE(dateStart, 'yyyy-mm-dd hh24:mi:ss')
               AND sales.ORDER_DATE <= TO_DATE(dateEnd, 'yyyy-mm-dd hh24:mi:ss') THEN
            SELECT SUM(QUANTITY) INTO qt FROM ORDER_ITEMS WHERE ORDER_ID = sales.ORDER_ID;
            avgCnt := avgCnt + qt;
        END IF;
    END LOOP;

    avgCnt := 100 * avgCnt / total;

    DBMS_OUTPUT.PUT_LINE('L`employe ' || empId || ' a vendu un taux de ' || avgCnt || ' dans cette duree');
END;

-- Quest 6
DECLARE
    idManager EMPLOYEES.EMPLOYEE_ID%TYPE;
    idEmp EMPLOYEES.EMPLOYEE_ID%TYPE;
    CURSOR cursEmployeeData IS
    SELECT EMPLOYEE_ID FROM EMPLOYEES WHERE MANAGER_ID = idManager;
    cnt Integer := 0;
    n Integer := 0;
BEGIN
    idManager :=: idManager;

    OPEN cursEmployeeData;
    LOOP
        FETCH cursEmployeeData INTO idEmp;
        EXIT WHEN cursEmployeeData%NOTFOUND;

        SELECT SUM(QUANTITY) INTO n FROM ORDERS JOIN ORDER_ITEMS
            ON ORDERS.ORDER_ID = ORDER_ITEMS.ORDER_ID
            WHERE SAlESMAN_ID = idEmp;

        IF n IS NOT NULL THEN
            cnt := cnt + n;
        END IF;
    END LOOP;
    CLOSE cursEmployeeData;

    DBMS_OUTPUT.PUT_LINE('Les employes du manager Id ' || idManager
                             || ' ont vendu ' || cnt || '.' );
END;