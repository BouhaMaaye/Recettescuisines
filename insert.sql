
--REGIME ( id_regime, nom_regime )
INSERT INTO REGIME VALUES(10,'Regime Blé');
INSERT INTO REGIME VALUES(11,'Vegetarian');
INSERT INTO REGIME VALUES(12,'Méditerranéen');
INSERT INTO REGIME VALUES(13,'No Glutan');


--UTILISATEUR ( id_utilisateur, nom_utilisateur, login, mail, mot_de_pass ).
INSERT INTO UTILISATEUR VALUES(71,'Luc','John','luc-john@gmail.com','J12poi@_89');
INSERT INTO UTILISATEUR VALUES(70,'Mr Bean','BIN','mr.bean@binmail.bin','beanMr@1950');


--RECETTE ( id_recette, nom_recette, #auteur, descriptif, difficulté, prix, nb_personnes,
-- durée_préparation, calorie, lipides, glucides, protide, #id_régime ).
INSERT INTO RECETTE VALUES(20,'PETIT-DEJ-BIN',70, 'cette recette est le petit dejeuner de Mr Bean!','Difficile',4,1,25,199,10,199,18,11);
INSERT INTO RECETTE VALUES(21,'testRecette2',71, 'cette recette est le dejeuner de Mr Bean!','Facile',3,1,30,200,10,121,18,12);


--CATEGORIE ( id_catégorie, nom_catégorie )
INSERT INTO CATEGORIE VALUES(1,'epices');
INSERT INTO CATEGORIE VALUES(2,'Legumes');
INSERT INTO CATEGORIE VALUES(3,'Viandes');
INSERT INTO CATEGORIE VALUES(4,'Jus');
INSERT INTO CATEGORIE VALUES(5,'huiles');
INSERT INTO CATEGORIE VALUES(6,'Ble');
INSERT INTO CATEGORIE VALUES(7,'Fruits');


--INGREDIENT ( id_ingredient, nom_ingredient, calorie, lipides, glucides, protide,
-- #incompatible_regime, unite_de_mesure, #id_catégorie )
INSERT INTO INGREDIENT VALUES(1,'sel',13,10,10,11,'gramme');
INSERT INTO INGREDIENT VALUES(2,'blanc poulet ',110,65,13,44,'gramme');
INSERT INTO INGREDIENT VALUES(3,'tomate',0,0,0,0,'gramme');
INSERT INTO INGREDIENT VALUES(4,'concombre',0,0,0,0,'gramme');
INSERT INTO INGREDIENT VALUES(5,'huile d olives',14,10,90,40,'gramme');



INSERT INTO INGREDIENT VALUES(6,'huile d olives',14,10,90,40,'gramme');
INSERT INTO INGREDIENT VALUES(7,'CURCUM',7,3,65,10,'gramme');
INSERT INTO INGREDIENT VALUES(8,'OGNION',5,30,110,0,'gramme');
INSERT INTO INGREDIENT VALUES(9,'PERSIL',74,0,0,4,'gramme');
INSERT INTO INGREDIENT VALUES(10,'BEURE',14,10,90,40,'gramme');
INSERT INTO INGREDIENT VALUES(11,'OEUFS',50,10,90,410,'piece');
INSERT INTO INGREDIENT VALUES(12,'olives',22,14,56,71,'gramme');
INSERT INTO INGREDIENT VALUES(13,'comcombre ESPAGNE',14,78,30,50,'gramme');
INSERT INTO INGREDIENT VALUES(14,'chou',18,34,90,60,'piece');
INSERT INTO INGREDIENT VALUES(15,'ognion rouge',20,10,98,11,'gramme');
INSERT INTO INGREDIENT VALUES(16,'sucre',14,10,77,80,'gramme');
INSERT INTO INGREDIENT VALUES(17,'aubergine',11,18,34,50,'gramme');
INSERT INTO INGREDIENT VALUES(18,'lait',190,3,8,34,'litre');
INSERT INTO INGREDIENT VALUES(19,'dates',19,12,90,12,'gramme');
INSERT INTO INGREDIENT VALUES(20,'salades',12,19,90,45,'piece');



INSERT INTO INGREDIENT_CATEGORIE VALUES(1,1);
INSERT INTO INGREDIENT_CATEGORIE VALUES(2,3);
INSERT INTO INGREDIENT_CATEGORIE VALUES(3,4);
INSERT INTO INGREDIENT_CATEGORIE VALUES(3,7);
INSERT INTO INGREDIENT_CATEGORIE VALUES(4,4);
INSERT INTO INGREDIENT_CATEGORIE VALUES(4,7);
INSERT INTO INGREDIENT_CATEGORIE VALUES(5,5);


--INGREDIENT_REPLACEMENTS ( #id_ingredient, #id_remplaçant ) .
INSERT INTO INGREDIENT_REMPLACEMENT VALUES(3,4);


--ILLUSTRATION ( id_illustration, type_illustration, img, vid, #id_recette ).
INSERT INTO ILLUSTRATION VALUES(1,'video','testRecette/video/prepa.vid',20);
INSERT INTO ILLUSTRATION VALUES(2,'image','testRecette2/image/prepa.png',21);


--ETAPE ( id_etape, nom_etape, temps_estimé, #id_recette )
INSERT INTO ETAPE VALUES(1,'echaufement',7,20,'echafement pour 20 minutes toutes en mettant du sel et du poivre');
INSERT INTO ETAPE VALUES(2,'cuire',25,20,'cuire pour 20 minutes toutes en mettant du sel et du poivre et du curcum');
INSERT INTO ETAPE VALUES(3,'four',60,21,'mettez le au four a 220 degre en ajoutant un peu de salade et du sel');
INSERT INTO ETAPE VALUES(4,'au froid',5,21,'faites vous plaisir en mettant le plat a l exterieur pour que il froidisse en melangant du sel et de leau a cote et bon appetit');



--INGREDIENTS ( #id_ingredient, #id_recette , quantite)
INSERT INTO INGREDIENTS VALUES(3,20,220);
INSERT INTO INGREDIENTS VALUES(1,20,15);
INSERT INTO INGREDIENTS VALUES(5,20,10);
INSERT INTO INGREDIENTS VALUES(2,21,300);
INSERT INTO INGREDIENTS VALUES(3,21,100);
INSERT INTO INGREDIENTS VALUES(4,21,150);
INSERT INTO INGREDIENTS VALUES(5,21,10);



--PLANNING ( id_planning , #id_utilisateur, #id_recette )
INSERT INTO PLANNING VALUES(70,1,20,to_date('17/11/2021', 'DD/MM/YYYY'));
INSERT INTO PLANNING VALUES(70,2,21,to_date('18/11/2021', 'DD/MM/YYYY'));
INSERT INTO PLANNING VALUES(71,3,20,to_date('30/11/2021', 'DD/MM/YYYY'));


--UTILISATEUR_DISPOSE ( #id_utilisateur, #id_ingredient )
INSERT INTO UTILISATEUR_DISPOSE VALUES(70,5);
INSERT INTO UTILISATEUR_DISPOSE VALUES(70,4);
INSERT INTO UTILISATEUR_DISPOSE VALUES(70,2);
INSERT INTO UTILISATEUR_DISPOSE VALUES(71,1);
INSERT INTO UTILISATEUR_DISPOSE VALUES(71,5);
INSERT INTO UTILISATEUR_DISPOSE VALUES(71,2);


--LISTE_D_ACHATS (# id_utilisateur , #i d_ingredient , date_expir_recette ).
INSERT INTO LISTE_D_ACHATS VALUES(70,3,to_date('17/11/2021', 'DD/MM/YYYY'));
INSERT INTO LISTE_D_ACHATS VALUES(70,1,to_date('17/11/2021', 'DD/MM/YYYY'));
INSERT INTO LISTE_D_ACHATS VALUES(70,3,to_date('18/11/2021', 'DD/MM/YYYY'));



--INGREDIENT_REGIME ( #id_ingredient, #id_regime )
INSERT INTO INGREDIENT_REGIME VALUES(1,13);
INSERT INTO INGREDIENT_REGIME VALUES(3,13);
INSERT INTO INGREDIENT_REGIME VALUES(5,13);

--ARCHIVE_LISTE ( #id_utilisateur, #id_ingredient ,date_d_archivage_liste)

--ARCHIVE_PLANNING ( id_planning, #id_utilisateur, #id_recette, date_darchive_planning ).
