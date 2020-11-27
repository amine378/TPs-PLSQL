DECLARE
    r_Warehouse             WAREHOUSES%ROWTYPE;
    v_TargetLocationID      NUMBER :=: v_TargetLocationID;
    v_LocationExist         NUMBER;

    CURSOR c_CheckLocationIDExist IS
        SELECT LOCATION_ID FROM LOCATIONS WHERE LOCATION_ID = v_TargetLocationID;
    CURSOR c_GetWarehousesInLocation IS
        SELECT * FROM WAREHOUSES WHERE LOCATION_ID = v_TargetLocationID;

BEGIN
    OPEN  c_CheckLocationIDExist;
    FETCH c_CheckLocationIDExist INTO v_LocationExist;
    CLOSE c_CheckLocationIDExist;

    IF v_LocationExist IS NULL THEN
        DBMS_OUTPUT.PUT_LINE('ERROR: Invalid Location ID !!');

    ELSE
        DBMS_OUTPUT.PUT_LINE('---> LOCATION ID : ' || v_TargetLocationID);
        OPEN  c_GetWarehousesInLocation;
        FETCH c_GetWarehousesInLocation INTO r_Warehouse;

        IF c_GetWarehousesInLocation%NOTFOUND THEN
            DBMS_OUTPUT.PUT_LINE('There are no Warehouses in this Location.');

        ELSE
            LOOP
                DBMS_OUTPUT.PUT_LINE('Warehouse ID: ' || r_Warehouse.WAREHOUSE_ID ||
                                     '.. Warehouse Name: ' || r_Warehouse.WAREHOUSE_NAME);
                FETCH c_GetWarehousesInLocation INTO r_Warehouse;
                EXIT WHEN c_GetWarehousesInLocation%NOTFOUND;
            END LOOP;
        END IF;
        CLOSE c_GetWarehousesInLocation;
    END IF;
END;