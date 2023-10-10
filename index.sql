--index--CREATE INDEX `index_nom` ON `table` (`colonne1`);
CREATE INDEX index_ingredient ON INGREDIENT (nom_ingredient);
CREATE INDEX index_recette_nbP ON RECETTE (nb_personnes);
CREATE INDEX index_regime ON REGIME (nom_regime);
CREATE INDEX index_ingredients ON INGREDIENTS (quantite);
CREATE INDEX index_etape ON ETAPE (id_recette);--car par defau id recette nest pas une cle primaire de la table
