-- LE TEST DOIT ARRETER L'OPERATION GRACE A LA CONTRAINTE DATE_VALID 
INSERT INTO LISTE_D_ACHATS VALUES(71,1,to_date('01/02/2024', 'DD/MM/YYYY'));

--il doit accepter celle la
INSERT INTO LISTE_D_ACHATS VALUES(71,1,to_date('01/01/2022', 'DD/MM/YYYY'));