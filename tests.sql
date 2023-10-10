--1 
SET SERVEROUTPUT ON;

DECLARE
v_resultat VARCHAR(128):= 'test';

BEGIN 
v_resultat := remplace_ingredients(20,'sel','TEST');
dbms_output.put_line('Lingredient sel est remplace par lingredient test dans tous les etape de la recette 20');
END;
/


--2
SELECT* FROM LISTE_ING_DIFF(1,20);


--3
--DECLARE 
--v_res varchar;
--BEGIN  
-- v_res:= COPIE_RECETTE(20,'TEST','SEL',40);
--end;
--/


--4
DECLARE
RESULTAT BOOLEAN:= TRUE;
BEGIN 
dbms_output.put_line('Test de la fonction est_recette_compatible , 1 Vrai , 0 Faux');

RESULTAT:= EST_RECETTE_COMPATIBLE(20,'Regime Blé');
dbms_output.put_line('La recette 20, est il compatible au regime ble?  '||sys.diutil.bool_to_int(RESULTAT));
RESULTAT:= EST_RECETTE_COMPATIBLE(21,'Vegetarian');
dbms_output.put_line('La recette 21, est il compatible au regime Vegetarian?  '||sys.diutil.bool_to_int(RESULTAT));
RESULTAT:= EST_RECETTE_COMPATIBLE(20,'No Glutan');
dbms_output.put_line('La recette 20, est il compatible au regime No Glutan?  '||sys.diutil.bool_to_int(RESULTAT));

end;
/




BEGIN
dbms_output.put_line('Bonne Annee :)');
END;
/