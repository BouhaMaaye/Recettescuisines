SET SERVEROUTPUT ON;
--1 FONCTION QUI CHANGE UN INGREDIENT PAR UN AUTRE DANS LES DESCRIPTIFS
-- DES DIFFERENTS ETAPES D'UNE RECETTE DONNÉE EN PARAM.
CREATE OR REPLACE FUNCTION remplace_ingredients(
  ARG_ID_RCETTE IN RECETTE.id_recette%TYPE,  --parametres
  ING1 VARCHAR,
  ING2 VARCHAR
)RETURN VARCHAR IS
BEGIN 
  UPDATE ETAPE 
  SET descriptif= REPLACE(descriptif,ING1,ING2)
  WHERE ETAPE.id_recette = ARG_ID_RCETTE;
  RETURN 'FIN DE L OPERATION: ingredient remplace';
END;
/
show errors FUNCTION remplace_ingredients ;
COMMIT;

--2

CREATE TYPE TAB_RTRN AS OBJECT(
  t_id_recette number(8),
  t_id_ingredient number(8),
  t_quantite INTEGER
);
/

CREATE TYPE RESULTAT AS TABLE OF TAB_RTRN;
/

show errors type TAB_RTRN ;


CREATE OR REPLACE FUNCTION LISTE_ING_DIFF(
  arg_nb_personnes INTEGER,
  arg_id_recette   INTEGER
)RETURN RESULTAT 
--PIPELINED
AS
CURSOR CUR_ING IS
SELECT TAB_RTRN(I_S.id_recette,I_S.id_ingredient,(arg_nb_personnes*I_S.quantite)/R.nb_personnes) 
FROM INGREDIENTS I_S 
JOIN RECETTE R on R.id_recette=arg_id_recette
WHERE I_S.id_recette = arg_id_recette;

VAR RESULTAT := RESULTAT();

BEGIN 
OPEN CUR_ING ;
--FOR i IN CUR_ING
   LOOP
      --PIPE ROW (VAR (i.id_recette, i.id_ingredient, i.quantite));
      --EXIT WHEN CUR_ING%NOTFOUND;
          FETCH CUR_ING
          BULK COLLECT INTO VAR LIMIT 100;
          EXIT WHEN CUR_ING%NOTFOUND;
   END LOOP;
--SELECT * FROM VAR;
CLOSE CUR_ING;
RETURN VAR;
END;
/


show errors FUNCTION LISTE_ING_DIFF ;
COMMIT;


--3
CREATE OR REPLACE PROCEDURE COPIE_RECETTE (
  arg_id_recette RECETTE.id_recette%TYPE,
  arg_ingr1 VARCHAR,
  arg_ingr2 VARCHAR,
  arg_nb_personnes INTEGER
) IS
  VAR RESULTAT := RESULTAT();
  v_nom_origine VARCHAR2(256);
  v_nom_copie VARCHAR2(256);
  v_id_copie INTEGER;
  v_tmp VARCHAR(128);
  v_nbPersonnes_origine INTEGER;
  CURSOR CUR_INGRS IS 
  SELECT * FROM INGREDIENTS WHERE id_recette = arg_id_recette;
  v_RECETTE RECETTE %ROWTYPE;

BEGIN
SELECT * INTO v_RECETTE FROM RECETTE;
SELECT LISTE_ING_DIFF(arg_nb_personnes,arg_id_recette)
  INTO VAR   
  FROM DUAL;
SELECT nom_recette INTO v_nom_origine 
FROM RECETTE 
WHERE id_recette=arg_id_recette;
SELECT nb_personnes 
INTO v_nbPersonnes_origine 
FROM RECETTE 
WHERE id_recette = arg_id_recette;
v_nom_copie := CONCAT('copie de ',v_nom_origine);
v_id_copie := v_RECETTE.id_recette*15;
--INSERTION DE LA NOUVELLE RECETTE 
INSERT INTO RECETTE VALUES(
  v_id_copie,
  v_nom_copie,
  v_RECETTE.auteur,
  v_RECETTE.descriptif,
  v_RECETTE.difficulte,
  v_RECETTE.prix,
  arg_nb_personnes,--NOUVEAU NB DE PERSONNES
  v_RECETTE.duree_preparation,
  v_RECETTE.calorie,
  v_RECETTE.lipides,
  v_RECETTE.glucides,
  v_RECETTE.protide,
  v_RECETTE.id_regime
  );
  --changer deux ingredients DANS TOUTES LES ETAPE DE LA RECETTE 
  v_tmp:=remplace_ingredients(arg_id_recette,arg_ingr1,arg_ingr2);
--Maintenant il faut modifier les quantites de ses ingredientS selon 
--le nouveau nb de personnes
FOR i IN CUR_INGRS LOOP
IF(i.id_ingredient=arg_ingr1)THEN
  UPDATE INGREDIENTS 
  SET INGREDIENTS.id_ingredient=arg_ingr2 WHERE id_recette = arg_id_recette AND id_ingredient=arg_ingr1;
END IF;
UPDATE INGREDIENTS 
SET quantite = quantite * arg_nb_personnes / v_nbPersonnes_origine 
WHERE id_ingredient = i.id_ingredient AND id_recette = arg_id_recette;

END LOOP;
--RETURN;
END;
/

show errors PROCEDURE COPIE_RECETTE ;





--4
--idee : regarder les ingredients de la recette si il existe un ingredient interdit
-- par le regime donnee en parametre , la recette n'est pas compatble, sinon ouiCREATE OR REPLACE FUNCTION EST_RECETTE_COMPATIBLE(
CREATE OR REPLACE FUNCTION EST_RECETTE_COMPATIBLE(
  arg_id_recette RECETTE.id_recette%TYPE,
  arg_nom_regime REGIME.nom_regime%TYPE
)RETURN BOOLEAN IS

resultat BOOLEAN:=TRUE;
v_id_regime REGIME.id_regime%TYPE;
BEGIN
SELECT R.id_regime INTO v_id_regime FROM REGIME R 
WHERE upper(R.nom_regime)=upper(arg_nom_regime);
DECLARE
CURSOR CUR_INGS IS
SELECT * FROM INGREDIENTS I
WHERE I.id_ingredient IN(
  SELECT IR.id_ingredient FROM INGREDIENT_REGIME IR WHERE IR.id_regime=v_id_regime
);
BEGIN 
--OPEN CUR_INGS ;
FOR i IN CUR_INGS 
LOOP
IF i.id_recette = arg_id_recette
THEN resultat := FALSE;
END IF;
END LOOP;
--CLOSE CUR_INGS;
RETURN resultat;

END;
END;
/

show errors FUNCTION EST_RECETTE_COMPATIBLE ;
--COMMIT;


