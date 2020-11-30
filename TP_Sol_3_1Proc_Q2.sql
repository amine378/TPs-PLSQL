DECLARE
    TYPE Warehouse IS RECORD(
        v_WarehouseName         WAREHOUSES.WAREHOUSE_NAME%TYPE,
        v_LocationID            WAREHOUSES.LOCATION_ID%TYPE
    );
    r_UpdatedWarehouse          Warehouse;
    v_TargetWarehouseID         NUMBER;
    v_WarehouseIDExist          NUMBER;
    v_NewLocationExist          NUMBER;

    PROCEDURE p_InputUpdatedWarehouse IS
    BEGIN
        v_TargetWarehouseID                 :=: v_TargetWarehouseID;
        r_UpdatedWarehouse.v_WarehouseName  :=: WAREHOUSE_NAME;
        r_UpdatedWarehouse.v_LocationID     :=: LOCATION_ID;
    END p_InputUpdatedWarehouse;

    FUNCTION f_CheckWarehouseIDExist(v_WarehouseID IN NUMBER) RETURN NUMBER IS v_WarehouseIDExist NUMBER;
    BEGIN
        SELECT COUNT(WAREHOUSE_ID) INTO v_WarehouseIDExist FROM WAREHOUSES WHERE WAREHOUSE_ID = v_WarehouseID;
        RETURN v_WarehouseIDExist;
    END f_CheckWarehouseIDExist;

    FUNCTION f_CheckLocationIDExist(v_LocationID IN NUMBER) RETURN NUMBER IS v_LocationIDExist NUMBER;
    BEGIN
        SELECT COUNT(LOCATION_ID) INTO v_LocationIDExist FROM LOCATIONS WHERE LOCATION_ID = v_LocationID;
        RETURN v_LocationIDExist;
    END f_CheckLocationIDExist;


    PROCEDURE p_UpdateWarehouseData(v_TargetWarehouseID IN NUMBER) IS
    BEGIN
        UPDATE WAREHOUSES
            SET WAREHOUSE_NAME  = r_UpdatedWarehouse.v_WarehouseName,
                LOCATION_ID     = r_UpdatedWarehouse.v_LocationID
            WHERE WAREHOUSE_ID  = v_TargetWarehouseID;
    END p_UpdateWarehouseData;

BEGIN
    p_InputUpdatedWarehouse();
    v_WarehouseIDExist := f_CheckWarehouseIDExist(v_TargetWarehouseID);
    v_NewLocationExist := f_CheckLocationIDExist(r_UpdatedWarehouse.v_LocationID);

    IF v_WarehouseIDExist = 0 THEN
        DBMS_OUTPUT.PUT_LINE('ERROR: Invalid Warehouse ID !!');
    ELSE
        IF v_NewLocationExist = 0 THEN
            DBMS_OUTPUT.PUT_LINE('ERROR: Invalid Location ID !!');
        ELSE
            p_UpdateWarehouseData(v_TargetWarehouseID);
            DBMS_OUTPUT.PUT_LINE('DONE: Warehouse Updated !!');
        END IF;
    END IF;
END;