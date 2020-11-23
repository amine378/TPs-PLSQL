SET SERVEROUTPUT ON;

      DECLARE
            v_CustomerID NUMBER := &v_CustomerID;
            r_Orders ORDERS%ROWTYPE;
            r_Customers CUSTOMERS%ROWTYPE; 
            TYPE List_OrdersID IS TABLE OF NUMBER INDEX BY BINARY_INTEGER;
            L_OrdersID List_OrdersID;
            i INTEGER :=0;
            CURSOR c_Orders IS
                  SELECT * INTO r_Orders FROM ORDERS WHERE Customer_Id=v_CustomerID;
      BEGIN
            SELECT * INTO r_Customers FROM CUSTOMERS WHERE Customer_Id=v_CustomerID;
            FOR n IN c_Orders  LOOP
                  i := i + 1;
                  L_OrdersID(i) := N.order_Id;
                  dbms_output.put_line('Order N°' ||  i  ||  ' : '  ||  L_OrdersID(i));
            END LOOP;
      END; 