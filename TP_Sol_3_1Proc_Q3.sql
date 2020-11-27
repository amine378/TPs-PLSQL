DECLARE
    v_TargetWarehouseID         NUMBER :=: v_TargetWarehouseID;
    v_WarehouseExist            NUMBER;

    CURSOR c_CheckWarehouseIDExist IS
        SELECT WAREHOUSE_ID FROM WAREHOUSES WHERE WAREHOUSE_ID = v_TargetWarehouseID;

BEGIN
    OPEN  c_CheckWarehouseIDExist;
    FETCH c_CheckWarehouseIDExist INTO v_WarehouseExist;
    CLOSE c_CheckWarehouseIDExist;

    IF v_WarehouseExist IS NULL THEN
        DBMS_OUTPUT.PUT_LINE('ERROR: Invalid Warehouse ID !!');

    ELSE
        DELETE FROM WAREHOUSES WHERE WAREHOUSE_ID = v_TargetWarehouseID;
        DBMS_OUTPUT.PUT_LINE('DONE: Warehouse Deleted !!');
    END IF;
END;