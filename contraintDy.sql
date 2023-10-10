--- 1
CREATE OR REPLACE TRIGGER nbMax_ingredients
  BEFORE INSERT OR UPDATE
  ON ingredients
  FOR EACH ROW

DECLARE
  cursor c1 IS
    select COUNT(*) 
      FROM ingredients
      WHERE id_recette = :new.id_recette;
      v_nb INTEGER;

BEGIN
OPEN c1;
LOOP
FETCH c1 INTO v_nb;
    if c1%rowcount>=20 then 
      raise_application_error(-20003, 'impossible!');
    END IF;
    EXIT WHEN c1 %NOTFOUND;
    END LOOP;
END;
/
SHOW ERRORS;


----------2


CREATE OR REPLACE TRIGGER date_valid
  BEFORE INSERT OR UPDATE
  ON LISTE_D_ACHATS
  FOR EACH ROW
BEGIN
  ---JE prend le moi comme 30 jour 
    /*IF (:new.date_ - TO_DATE(SYSDATE, 'DD/MM/YYYY')) >= 31 THEN
      raise_application_error(-20003, 'la liste ne peut pas');
    END IF;*/
    IF :new.date_expir_recette >= ADD_MONTHS(SYSDATE,1) THEN
      raise_application_error(-20003, 'liste ne peut pas');
    END IF;
  END;
/
SHOW ERRORS;

----------3
CREATE OR REPLACE trigger duree_eta
  BEFORE INSERT OR UPDATE 
  ON ETAPE
  for each row
BEGIN
  declare
    dure_recet INTEGER;
    dure_etape INTEGER;
  BEGIN 
    select duree_preparation into dure_recet 
      from recette 
        where :new.id_recette = id_recette;
    select sum(temps_estime) into dure_etape 
      from etape 
        where :new.id_recette = id_recette;
    dure_etape := dure_etape + :new.temps_estime;
    if(dure_etape > dure_recet) THEN
      raise_application_error(-20003,'non modifie');
END IF;
END;
END;
/

SHOW ERRORS;
