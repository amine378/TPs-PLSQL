CREATE OR REPLACE TRIGGER t_DeclineEmployeeInsert
    AFTER INSERT ON EMPLOYEES FOR EACH ROW
DECLARE
    v_CurrentDay            NUMBER := EXTRACT(DAY   FROM SYSDATE);
    v_CurrentMonth          NUMBER := EXTRACT(MONTH FROM SYSDATE);
    v_CurrentYear           NUMBER := EXTRACT(YEAR  FROM SYSDATE);
    v_EmployeeHiredDAY      NUMBER := EXTRACT(DAY   FROM :new.HIRE_DATE);
    v_EmployeeHiredMONTH    NUMBER := EXTRACT(MONTH FROM :new.HIRE_DATE);
    v_EmployeeHiredYEAR     NUMBER := EXTRACT(YEAR  FROM :new.HIRE_DATE);

BEGIN
    IF v_EmployeeHiredYEAR > v_CurrentYear THEN
        raise_application_error(-20827, 'ALERT!!: You wish you can hire a time traveler, but you cant !');
    ELSIF v_EmployeeHiredYEAR = v_CurrentYear THEN

        IF v_EmployeeHiredMONTH > v_CurrentMonth THEN
            raise_application_error(-20827, 'ALERT!!: You wish you can hire a time traveler, but you cant !');
        ELSIF v_EmployeeHiredMONTH = v_CurrentMonth THEN

            IF v_EmployeeHiredDAY > v_CurrentDay THEN
                raise_application_error(-20827, 'ALERT!!: You wish you can hire a time traveler, but you cant !');
            END IF;
        END IF;
    END IF;
END;