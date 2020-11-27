DECLARE
    r_Warehouse             WAREHOUSES%ROWTYPE;
    v_LocationIDExist       NUMBER;
    v_WarehouseIDExist      NUMBER;

    CURSOR c_CheckLocationExist IS
        SELECT LOCATION_ID FROM LOCATIONS WHERE LOCATION_ID=r_Warehouse.LOCATION_ID;

    CURSOR c_CheckWarehouseIDExist IS
        SELECT WAREHOUSE_ID FROM WAREHOUSES WHERE WAREHOUSE_ID=r_Warehouse.WAREHOUSE_ID;

    PROCEDURE p_AddWarehouse(r_Warehouse IN WAREHOUSES%ROWTYPE) IS
    BEGIN
        INSERT INTO WAREHOUSES VALUES (r_Warehouse.WAREHOUSE_ID,
                                       r_Warehouse.WAREHOUSE_NAME,
                                       r_Warehouse.LOCATION_ID);
    END p_AddWarehouse;

BEGIN
    r_Warehouse.WAREHOUSE_ID    :=: WAREHOUSE_ID;
    r_Warehouse.WAREHOUSE_NAME  :=: WAREHOUSE_NAME;
    r_Warehouse.LOCATION_ID     :=: LOCATION_ID;
    OPEN  c_CheckLocationExist;
    fetch c_CheckLocationExist into v_LocationIDExist;
    OPEN  c_CheckWarehouseIDExist;
    FETCH c_CheckWarehouseIDExist INTO v_WarehouseIDExist;
    if v_LocationIDExist IS NULL THEN
        DBMS_OUTPUT.PUT_LINE('ERROR : The Location ID Does Not Exist !! ');
    ELSIF v_WarehouseIDExist IS NOT NULL THEN
        DBMS_OUTPUT.PUT_LINE('ERROR : The Warehouse ID Already Exist !! ');
    ELSE
        p_AddWarehouse(r_Warehouse);
    END IF;
    CLOSE c_CheckLocationExist;
    CLOSE c_CheckWarehouseIDExist;
END;