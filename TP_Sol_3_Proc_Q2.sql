DECLARE
    TYPE Warehouse IS RECORD(
        v_WarehouseName         WAREHOUSES.WAREHOUSE_NAME%TYPE,
        v_LocationID            WAREHOUSES.LOCATION_ID%TYPE
    );
    v_TargetWarehouseID         NUMBER :=: v_TargetWarehouseID;
    r_UpdatedWarehouse          Warehouse;
    v_WarehouseExist            NUMBER;
    v_NewLocationExist          NUMBER;

    CURSOR c_CheckWarehouseIDExist IS
        SELECT WAREHOUSE_ID FROM WAREHOUSES WHERE WAREHOUSE_ID = v_TargetWarehouseID;

    CURSOR c_CheckNewLocationExist IS
        SELECT LOCATION_ID FROM LOCATIONS WHERE LOCATION_ID = r_UpdatedWarehouse.v_LocationID;

BEGIN
    OPEN  c_CheckWarehouseIDExist;
    FETCH c_CheckWarehouseIDExist INTO v_WarehouseExist;
    CLOSE c_CheckWarehouseIDExist;

    IF v_WarehouseExist IS NULL THEN
        DBMS_OUTPUT.PUT_LINE('ERROR: Invalid Warehouse ID !!');

    ELSE
        r_UpdatedWarehouse.v_WarehouseName   :=: WAREHOUSE_NAME;
        r_UpdatedWarehouse.v_LocationID      :=: LOCATION_ID;
        OPEN  c_CheckNewLocationExist;
        FETCH c_CheckNewLocationExist INTO v_NewLocationExist;
        CLOSE c_CheckNewLocationExist;

        IF v_NewLocationExist IS NULL THEN
            DBMS_OUTPUT.PUT_LINE('ERROR: Invalid Location ID !!');

        ELSE
            UPDATE WAREHOUSES
            SET WAREHOUSE_NAME  = r_UpdatedWarehouse.v_WarehouseName,
                LOCATION_ID     = r_UpdatedWarehouse.v_LocationID
            WHERE WAREHOUSE_ID  = v_TargetWarehouseID;
                DBMS_OUTPUT.PUT_LINE('DONE: Warehouse Updated !!');

        END IF;
    END IF;
END;