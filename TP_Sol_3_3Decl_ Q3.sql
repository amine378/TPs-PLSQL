CREATE OR REPLACE TRIGGER t_DeclineCreditLimitEdit
    BEFORE UPDATE ON CUSTOMERS
    FOR EACH ROW
DECLARE
    v_CurrentDay     NUMBER := EXTRACT(DAY FROM SYSDATE);
BEGIN
    IF v_CurrentDay >=28 AND v_CurrentDay <= 30 THEN
        DBMS_OUTPUT.PUT_LINE('==> ALERT: ');
        DBMS_OUTPUT.PUT_LINE('You cant change the CREDIT LIMIT, Today is: ' || v_CurrentDay);
        :new.CREDIT_LIMIT := :old.CREDIT_LIMIT;
    END IF;
END;