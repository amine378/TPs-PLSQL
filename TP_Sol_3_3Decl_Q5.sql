CREATE OR REPLACE TRIGGER t_ApplyDiscountToOrder
    BEFORE INSERT ON ORDER_ITEMS
    FOR EACH ROW
DECLARE
    v_CurrentInputAmount            NUMBER:= :new.QUANTITY * :new.UNIT_PRICE;
    v_ExistingAmount                NUMBER;
    v_TotalOrderAmount              NUMBER;
    v_Discount                      NUMBER:= 0.05;
    v_TotalOrderAmountWithDiscount  NUMBER;

    FUNCTION f_GetTotalOrderAmount RETURN NUMBER IS v_TotalOrderAmount NUMBER;
    BEGIN
        SELECT SUM(QUANTITY*UNIT_PRICE) INTO v_ExistingAmount FROM ORDER_ITEMS WHERE ORDER_ID = :new.ORDER_ID;

        IF v_ExistingAmount IS NULL THEN
            v_ExistingAmount := 0;
        END IF;
        v_TotalOrderAmount := v_CurrentInputAmount + v_ExistingAmount;

        RETURN v_TotalOrderAmount;
    END f_GetTotalOrderAmount;

    FUNCTION f_ApplyDiscount(v_TotalOrderAmount IN NUMBER)
        RETURN NUMBER IS v_TotalOrderAmountWithDiscount NUMBER;
    BEGIN
        v_TotalOrderAmountWithDiscount := v_TotalOrderAmount * (1 - v_Discount);

        RETURN v_TotalOrderAmountWithDiscount;
    END f_ApplyDiscount;

BEGIN
    v_TotalOrderAmount := f_GetTotalOrderAmount();
    DBMS_OUTPUT.PUT_LINE('Total Order Amount is: ' || v_TotalOrderAmount);

    IF v_TotalOrderAmount > 10000 THEN
        v_TotalOrderAmountWithDiscount := f_ApplyDiscount(v_TotalOrderAmount);
        DBMS_OUTPUT.PUT_LINE('Total order amount after Discount is: ' || v_TotalOrderAmountWithDiscount);

    end if;
END;