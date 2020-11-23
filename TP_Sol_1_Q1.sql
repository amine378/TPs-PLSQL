SET SERVEROUTPUT ON;

DECLARE  
      v_nom VARCHAR(100) := '&v_nom';
      v_prenom VARCHAR(100)  := '&v_prenom';
BEGIN        
      dbms_output.put_line('Le Nom      : ' || v_nom);
      dbms_output.put_line('Le Prenom : ' || v_prenom);
END;