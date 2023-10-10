ALTER TABLE UTILISATEUR
ADD CONSTRAINT UN_user UNIQUE (nom_utilisateur); 

ALTER TABLE UTILISATEUR
ADD CONSTRAINT CHK_email CHECK (REGEXP_LIKE (adresse_mail, '^(\S+)\@(\S+)\.(\S+)$')); 

ALTER TABLE INGREDIENT--Je suppose que l'unité de mésure doit être soit unité soit gramme 
ADD CONSTRAINT CHK_ingredient CHECK (unite_de_mesure IN ('unité','gramme','piece','litre')); 


ALTER TABLE ILLUSTRATION--Je suppose qu'il y ait eux types 1)video  ET    2)image  .
ADD CONSTRAINT CHK_type_illust CHECK (type_illustration IN ('image','video')); 


ALTER TABLE RECETTE----Je suppose que c'est compris entre « Très facile » à « Difficile »
ADD CONSTRAINT CHK_Difficulte CHECK (difficulte IN ('Tres facile','Facile','Difficile')); 


ALTER TABLE RECETTE----Je suppose que c'est compris entre « Très facile » à « Difficile »
ADD CONSTRAINT CHK_prix CHECK (prix BETWEEN 1 AND 5); 
