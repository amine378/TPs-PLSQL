SET SERVEROUTPUT ON;

      DECLARE
            r_Products Products%ROWTYPE;
            v_ProductID NUMBER := &v_ProductID;
      BEGIN
            SELECT * INTO r_Products FROM Products WHERE Product_Id=v_ProductID;
            dbms_output.put_line('Product_Id : ' || r_Products.Product_Id);
            dbms_output.put_line('Product_Name : ' || r_Products.Product_Name);
            dbms_output.put_line('Description : ' || r_Products.Description);
            dbms_output.put_line('Standard_Cost : ' || r_Products.Standard_Cost);
            dbms_output.put_line('List_Price : ' || r_Products.List_Price);
            dbms_output.put_line('Category_ID : ' || r_Products.Category_ID);
      END;