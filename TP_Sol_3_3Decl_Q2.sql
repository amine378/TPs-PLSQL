CREATE OR REPLACE TRIGGER t_ProductLowQuantityAlert
    AFTER INSERT OR UPDATE OR DELETE ON INVENTORIES
    FOR EACH ROW
DECLARE
    v_MinimumQuantityThreshold  NUMBER:= 10;
    v_TargetProductID           NUMBER:= :new.PRODUCT_ID;
    v_TargetProductQuantity     NUMBER:= :new.QUANTITY;
BEGIN
    IF v_TargetProductQuantity < v_MinimumQuantityThreshold THEN
        DBMS_OUTPUT.PUT_LINE('==> ALERT: ');
        DBMS_OUTPUT.PUT_LINE('Product (ID: ' || v_TargetProductID || ') Quantity in inventory is LOW !! (Quantity<10)');
    END IF;
END;