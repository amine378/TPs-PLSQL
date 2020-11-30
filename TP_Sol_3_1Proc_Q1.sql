DECLARE
    r_Warehouse         WAREHOUSES%ROWTYPE;
    v_LocationExist     NUMBER;
    v_WarehouseExist    NUMBER;

    PROCEDURE p_InputWarehouse IS
    BEGIN
        r_Warehouse.WAREHOUSE_ID    :=: WAREHOUSE_ID;
        r_Warehouse.WAREHOUSE_NAME  :=: WAREHOUSE_NAME;
        r_Warehouse.LOCATION_ID     :=: LOCATION_ID;
    end p_InputWarehouse;

    FUNCTION f_CheckWarehouseExist(v_WarehouseID IN NUMBER) RETURN NUMBER IS v_WarehouseExist NUMBER;
    BEGIN
        SELECT COUNT(WAREHOUSE_ID) INTO v_WarehouseExist FROM WAREHOUSES WHERE WAREHOUSE_ID = v_WarehouseID;
        RETURN v_WarehouseExist;
    END f_CheckWarehouseExist;

    FUNCTION f_CheckLocationExist(v_LocationID IN NUMBER) RETURN NUMBER IS v_LocationExist NUMBER;
    BEGIN
        SELECT COUNT(LOCATION_ID) INTO v_LocationExist FROM LOCATIONS WHERE LOCATION_ID = v_LocationID;
        RETURN v_LocationExist;
    END f_CheckLocationExist;

    PROCEDURE p_AddWarehouse(r_Warehouse IN WAREHOUSES%ROWTYPE) IS
    BEGIN
        INSERT INTO WAREHOUSES VALUES (r_Warehouse.WAREHOUSE_ID, r_Warehouse.WAREHOUSE_NAME, r_Warehouse.LOCATION_ID);
        DBMS_OUTPUT.PUT_LINE('DONE : Warehouse Added. ');
    END p_AddWarehouse;

BEGIN
    p_InputWarehouse();
    v_LocationExist   := f_CheckLocationExist(r_Warehouse.LOCATION_ID);
    v_WarehouseExist  := f_CheckWarehouseExist(r_Warehouse.WAREHOUSE_ID);

    IF v_LocationExist = 0 THEN
        DBMS_OUTPUT.PUT_LINE('ERROR : The Location ID Does Not Exist !! ');
    ELSIF v_WarehouseExist != 0 THEN
        DBMS_OUTPUT.PUT_LINE('ERROR : The Warehouse ID Already Exist !! ');
    ELSE
        p_AddWarehouse(r_Warehouse);
    END IF;
END;