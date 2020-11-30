DECLARE
    v_TargetWarehouseID         NUMBER;
    v_WarehouseExist            NUMBER;

    FUNCTION f_CheckWarehouseExist(v_WarehouseID IN NUMBER) RETURN NUMBER IS v_WarehouseExist NUMBER;
    BEGIN
        SELECT COUNT(WAREHOUSE_ID) INTO v_WarehouseExist FROM WAREHOUSES WHERE WAREHOUSE_ID = v_WarehouseID;
        RETURN v_WarehouseExist;
    END f_CheckWarehouseExist;

    PROCEDURE p_DeleteWarehouse(v_TargetWarehouseID IN NUMBER) IS
    BEGIN
        DELETE FROM WAREHOUSES WHERE WAREHOUSE_ID = v_TargetWarehouseID;
    END p_DeleteWarehouse;

BEGIN
    v_TargetWarehouseID :=: Enter_Warehouse_ID;
    v_WarehouseExist := f_CheckWarehouseExist(v_TargetWarehouseID);

    IF v_WarehouseExist = 0 THEN
        DBMS_OUTPUT.PUT_LINE('ERROR: Invalid Warehouse ID !!');
    ELSE
        p_DeleteWarehouse(v_TargetWarehouseID);
        DBMS_OUTPUT.PUT_LINE('DONE: Warehouse Deleted !!');
    END IF;
END;