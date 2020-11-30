DECLARE
    r_Warehouse             WAREHOUSES%ROWTYPE;
    v_TargetLocationID      NUMBER;
    v_LocationExist         NUMBER;
    v_WarehouseExist        NUMBER;

    FUNCTION f_CheckLocationExist(v_LocationID IN NUMBER) RETURN NUMBER IS v_LocationExist NUMBER;
    BEGIN
        SELECT COUNT(LOCATION_ID) INTO v_LocationExist FROM LOCATIONS WHERE LOCATION_ID = v_LocationID;
        RETURN v_LocationExist;
    END f_CheckLocationExist;

    FUNCTION f_CheckWarehouseExistInLocation(v_LocationID IN NUMBER) RETURN NUMBER IS v_WarehouseExist NUMBER;
    BEGIN
        SELECT COUNT(WAREHOUSE_ID) INTO v_WarehouseExist FROM WAREHOUSES WHERE LOCATION_ID = v_LocationID;
        RETURN v_WarehouseExist;
    END f_CheckWarehouseExistInLocation;

    Procedure p_PrintWarehousesInLocation(v_LocationID IN NUMBER) IS
        CURSOR c_GetWarehousesInLocation IS
            SELECT * FROM WAREHOUSES WHERE LOCATION_ID = v_LocationID;
    BEGIN
        OPEN c_GetWarehousesInLocation;
        LOOP FETCH c_GetWarehousesInLocation INTO r_Warehouse;
            EXIT WHEN c_GetWarehousesInLocation%NOTFOUND;
            DBMS_OUTPUT.PUT_LINE('Warehouse ID: ' || r_Warehouse.WAREHOUSE_ID ||
                                 '.. Warehouse Name: ' || r_Warehouse.WAREHOUSE_NAME);
        END LOOP;
        CLOSE c_GetWarehousesInLocation;
    END p_PrintWarehousesInLocation;

BEGIN
    v_TargetLocationID :=: Enter_Location_ID;
    v_LocationExist := f_CheckLocationExist(v_TargetLocationID);

    IF v_LocationExist = 0 THEN
        DBMS_OUTPUT.PUT_LINE('ERROR: Invalid Location ID !!');
    ELSE
        DBMS_OUTPUT.PUT_LINE('---> LOCATION ID : ' || v_TargetLocationID);
        v_WarehouseExist := f_CheckWarehouseExistInLocation(v_TargetLocationID);

        IF v_WarehouseExist = 0 THEN
            DBMS_OUTPUT.PUT_LINE('There are no Warehouses in this Location.');
        ELSE
                p_PrintWarehousesInLocation(v_TargetLocationID);
        END IF;
    END IF;
END;