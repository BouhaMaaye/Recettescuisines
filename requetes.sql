--requetes


--1
--requete : les recettes qui ont moins de 200 calories par personne, 
--dont tous les ingrédients sont sans glutan et qui apparaissent sur le planning d'un utilisateur

SELECT id_recette, nom_recette
    FROM RECETTE RE
    WHERE RE.id_recette IN (
        SELECT DISTINCT P.id_recette FROM PLANNING P WHERE RE.id_recette= P.id_recette
    ) 
    AND (RE.calorie/RE.nb_personnes <200) AND RE.id_recette NOT IN(
            SELECT id_recette FROM RECETTE WHERE id_recette IN (
                SELECT id_recette FROM INGREDIENTS WHERE id_ingredient IN(
                    SELECT id_recette FROM INGREDIENTS ING WHERE ING.id_ingredient IN(
                    SELECT IR.id_ingredient FROM REGIME R, INGREDIENT_REGIME IR WHERE R.id_regime = IR.id_regime AND R.nom_regime='No Glutan'
                    )
            )
        )
  );


  --2 La recette la plus souvent présente dans des plannings d’utilisateurs
  SELECT R.id_recette FROM RECETTE R WHERE R.id_recette IN (
      SELECT P.id_recette FROM PLANNING P HAVING (COUNT(P.id_recette) = 
        (SELECT MAX(COUNT(P.id_recette)) FROM PLANNING P
            GROUP BY P.id_recette
      ))
      GROUP BY P.id_recette
  );   

    --VERIF:
    SELECT id_recette AS "id pour verifier", COUNT(id_recette) AS nb_d_apparence FROM PLANNING P GROUP BY id_recette ;

--3
   SELECT ing.nom_ingredient,
   COUNT(DISTINCT igs.id_recette) AS apparence_dans_recettes ,
   COUNT(DISTINCT cat.id_categorie) AS apparence_dans_categories 
   FROM INGREDIENT ing, INGREDIENTS igs, INGREDIENT_CATEGORIE cat
   WHERE ing.id_ingredient = igs.id_ingredient AND ing.id_ingredient =cat.id_ingredient
   GROUP BY ing.nom_ingredient;


--4 
    SELECT DISTINCT id_utilisateur FROM planning WHERE id_utilisateur NOT IN (
        SELECT id_utilisateur FROM PLANNING WHERE id_recette NOT IN( 
            SELECT R.id_recette FROM RECETTE R WHERE  R.id_regime NOT IN (
                SELECT id_regime FROM REGIME WHERE nom_regime NOT LIKE 'Vegetarian%'
        )
        )
    );

--5 

SELECT log_in AS "LOGIN", nom_utilisateur AS "NOM",
  adresse_mail AS "E-MAIL",
  (SELECT COUNT(id_recette) FROM recette
    WHERE auteur = U.id_utilisateur) AS "NB DE RECETTES CRÉES",
  (SELECT COUNT(id_ingredient) FROM UTILISATEUR_DISPOSE
    WHERE id_utilisateur = u.id_utilisateur) AS "NB D'INGREDIENTS QU'IL DISPOSE",
  (SELECT COUNT(*) FROM LISTE_D_ACHATS
    WHERE id_utilisateur = u.id_utilisateur) AS "NB D'INGREDIENTS A ACHETER",
  (SELECT COUNT(*) FROM planning
    WHERE id_utilisateur = u.id_utilisateur AND date_recette >= SYSDATE) AS "NB DE RECETTES A FAIRE DANS L'AVENIR"
  FROM utilisateur U;

  --FIN PARTIE REQUETES