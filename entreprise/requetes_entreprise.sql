-- Création de la base de données
CREATE DATABASE nom_bdd;

-- Permet de voir, d'afficher la liste des bases de données
SHOW DATABASES;

-- Permet de sélectionner / utiliser une base de donnée
USE entreprise;

-- Permet de supprimer une base de donnée
DROP DATABASE entreprise;

-- Permet de supprimer une table
DROP TABLE employes;

-- Permet de vider / supprimer l'ensemble des données stockées dans une table SQL
TRUNCATE employes;

-- Afficher une description de la structure de la table ainsi que les champs (DESC pour DESCRIBE)
DESC employes;

-- ################################# REQUETES DE SELECTION (affichage) ###########################
-- Affichage complet de la table employes
SELECT
  id_employes,
  prenom,
  nom,
  sex,
  service,
  date_embauche,
  salaire
FROM
  employes;

-- Raccourci , qui veut dire 'all', permet de selectionner toutes les colonnes de la table SQL
SELECT
  *
FROM
  employes;

-- Affichage des noms et prénoms des employés de l'ETRS.
-- AFFICHE MOI colonne1, colonne2 DE LA TABEL nom_de_la_table
SELECT
  nom,
  prenom
FROM
  employes;

-- Exo : afficher les différents services occupés par les employés de l'ETRS, éliminer les doublons
SELECT
  service
FROM
  employes;

-- Eviter les doublons
SELECT DISTINCT
  service
FROM
  employes;

-- Affichage des employés travaillant dans le service informatique
-- Condition WHERE : à condition que 
-- AFFICHE MOI colonne1, colonne2 DE LA TABLE nom_table A CONDITION QUE colonne='valeur'
-- La condition ne peut être appelée qu'une seule fois dans la requête
SELECT
  prenom,
  nom,
  service FORM employes
WHERE
  service = 'informatique'
  -- BETWEEN
  -- Affichage des employés ayant été recrutés entre 2010 et aujourd'hui
  -- BETWEEN + AND : entre ... et ...
SELECT
  prenom,
  nom,
  date_embauche,
FROM
  employes
WHERE
  date_embauche BETWEEN '2010-01-01' AND '2025-01-20';

SELECT
  CURDATE ();

SELECT
  prenom,
  nom,
  date_embauche,
FROM
  employes
WHERE
  date_embauche BETWEEN '2010-01-01' AND CURDATE  ();

-- LIKE : valeur approchante
-- Affichage des employés ayant un prénom commençant par la lettre 's'
-- % ici veut 'peu importe la suite'
SELECT
  prenom
FROM
  employes
WHERE
  prenom LIKE 's%'
  -- % ici veut 'peut importe ce qui précède'
SELECT
  prenom
FROM
  employes
WHERE
  prenom LIKE '%s'
  -- %-% : ici veut dire 'qui contient'
SELECT
  prenom
FROM
  employes
WHERE
  prenom LIKE '%s'
  -- ID                     --nom                   --code_postal
  -- 1                    apt 1                     92130
  -- 2                    apt 2                     75300
  -- 3                    apt 3                     75600
  -- SELECT * FROM appartement WHERE code_postal = 75; --> résultats FALSE
  -- SELECT * FROM appartement WHERE code_postal LIKE '75'; --> résultats TRUE
  -- Affichage de tous les employés (sauf les informaticiens)
SELECT
  nom,
  prenom,
  service
FROM
  employes
WHERE
  service != 'informatique';

-- != différent de ...
-- Affichage des employés gagnant un salaire supérieur à 3000 €
SELECT
  prenom,
  nom,
  service,
  salaire
FROM
  employes
WHERE
  salaire > 3000;

-- ORDER BY
-- permet d'éffectuer un classement
SELECT
  prenom
FROM
  employes
ORDER BY
  prenom ASC;

-- ORDER BY par défaut ascendant
SELECT
  prenom
FROM
  employes
ORDER BY
  prenom;

-- ORDER BY par défaut déscendant 
SELECT
  prenom
FROM
  employes
ORDER BY
  prenom DESC;

-- LIMIT
-- Permet d'afficher une portion de résultat
-- LIMIT 0,3
-- 0 : position de départ 
-- 3 : nombre d'éléments souhaité
SELECT
  prenom
FROM
  employes
ORDER BY
  prenom
LIMIT
  0, 3;

SELECT
  prenom
FROM
  employes
ORDER BY
  prenom
LIMIT
  3, 3;

SELECT
  prenom
FROM
  employes
ORDER BY
  prenom
LIMIT
  6, 3;

-- SUM 
-- Affichage de la "masse salariale" sur 12 mois
SELECT
  SUM(salaire * 12)
FROM
  employes;

SELECT
  SUM(salaire * 12) AS masse salariale
FROM
  employes;

-- AS : alias, permet de générer un nom de colonne
-- AVG : Calcul du salaire moyen
-- ROUND : fonction pour arrondir
-- Calcul du salaire moyen
SELECT
  AVG(salaire) AS salaire_moyen
FROM
  employes
SELECT
  ROUND(AVG(salaire), 2) AS salaire_moyen
FROM
  employes;

-- COUNT : fonction prédéfinie SQL, qui retourne  +1  à chaque ligne de résultat
-- Affichage du nombre de femme dans l'entreprise
SELECT
  COUNT(*) AS nb_femme
FROM
  employes
WHERE
  sexe = 'f';

-- MIN / MAX 
-- Affichage du salaire minimum et maximum 
SELECT
  MIN(salaire) AS salaire_minimum
FROM
  employes
SELECT
  MAX(salaire) AS salaire_maximum
FROM
  employes;

-- Exo : afficher le prénom et le salaire de l'employé qui gagne le salaire le plus bas dans l'entreprise
SELECT
  prenom,
  MIN(salaire) AS salaire_minimum
FROM
  employes;

-- /!\ résultat éronné !!
SELECT
  prenom,
  nom,
  salaire
FROM
  employes
ORDER BY
  salaire
LIMIT
  0, 1;

-- Requête imbriquée sur la même table (une requête dans une requête)
SELECT
  prenom,
  nom,
  salaire
FROM
  employes
WHERE
  salaire = (
    SELECT
      MIN(salaire)
    FROM
      employes
  );

-- La requête entre parenthèse est exécutée en première et retourne le salaire minimum
-- Une fois le salaire minimum récupéré, nous pouvons afficher le prénom, le nom et le salaire de l'employé
SELECT
  prenom,
  nom,
  salaire
FROM
  employes
WHERE
  salaire = 1390;

-- IN
-- Affichage des employés travaillant dans le service informatique et comptabilité
SELECT
  prenom,
  nom,
  service
FROM
  employes
WHERE
  service IN ('comptabilité', 'informatique');

-- = : permet d'inclure une seule valeur
-- IN : permet d'inclure plusieurs valeurs
-- Exo : Affichage des employés ne travaillant pas dans le service informatique et comptabilité (exclure plusieurs valeurs)
SELECT
  prenom,
  nom,
  service
FROM
  employes
WHERE
  service NOT IN ('comptabilité', 'informatique');

-- Affichage des commerciaux gagnant un salarie inférieur à 2000 €
SELECT
  prenom,
  nom,
  service,
  salaire
FROM
  employes
WHERE
  service = 'commercial'
  AND salaire < 2000;

-- AND : apporte une condition supplémentaire
-- Affichage des employés travaillant dans le service commercial et gagnant un salaire de 2300 € ou de 1900 €
SELECT
  nom,
  prenom,
  salaire,
  service
FROM
  employes
WHERE
  service = 'commercial'
  AND salaire = 2300
  OR salaire = 1900;

-- /!\ résultat éronné
-- Il faut respecter l'ordre des priorités des conditions entre les parenthèses
SELECT
  nom,
  prenom,
  salaire,
  service
FROM
  employes
WHERE
  service = 'commercial'
  AND (
    salaire = 2300
    OR salaire = 1900
  );

-- GROUP BY permet d'effectuer des regoupements, il va ré-associer les nombres (+1) par service
-- Affichage du nombre d'employé(s) par service
SELECT
  service,
  COUNT(*) AS nb
FROM
  employes
GROUP BY
  service;

-- ############################### REQUETE INSERTION ##############################################
-- Si nous insérons des données dans chaque colonne, il n'est pas nécessaire d'appeler les colonnes avant VALUES, en revanche, nous devons fournir une valeur pour la clé primaire id_employes (DEFAULT, NULL, '')
INSERT INTO
  employes
VALUES
  (
    DEFAULT,
    'Grégory',
    'LACROIX',
    'm',
    'PDG',
    '2025-01-21',
    40000
  );

-- Il n'est pas nécessaire d'appeler la colonne clé primaire id_employes puisqu'elle auto incrémente (+1) à chaque nouvelle insertion dans la base de donnée
INSERT INTO
  employes (
    id_employes,
    prenom,
    nom,
    sexe,
    service,
    date_embauche,
    salaire
  )
VALUES
  (
    DEFAULT,
    'Emmanuel',
    'MACRON',
    'm',
    'Technicien de surface',
    '2025-01-21',
    1
  );

-- ################################### REQUETE DE MODIFICATION #################################################
-- UPDATE nom_de_la_table SET colonne = 'nouvelle_valeur' A CONDITION QUE colonne = 'valeur'
UPDATE employes
SET
  service = 'marketing',
  salaire = 2500
WHERE
  id_employes = 699;

SELECT
  *
FROM
  employes
WHERE
  id_employes = 699;

-- Si la clé primaire (8054) n'existe pas en base de données, REPLACE se comporte comme INSERT  et ajoute une nouvelle entrée dans la table employé
-- INSERT
REPLACE INTO employes (
  id_employes,
  prenom,
  nom,
  sexe,
  service,
  date_embauche,
  salaire
)
VALUES
  (
    8054,
    'Toto',
    'Toto',
    'm',
    'Humour',
    '2025-01-21',
    1000
  );

-- Si la clé primaire (8054) existe en base de données, REPLACE se comporte comme un UPDATE, il va supprimer la ligne 8054 et la ré-insérer avec les modifications
-- UPDATE
REPLACE INTO employes (
  id_employes,
  prenom,
  nom,
  sexe,
  service,
  date_embauche,
  salaire
)
VALUES
  (
    8054,
    'Titi',
    'Titi',
    'm',
    'Humour',
    '2025-01-21',
    2000
  );

-- ############################### REQUETE DE SUPPRESSION ################################################
DELETE FROM employes;

-- Supprime l'ensemble des données de la table employés
-- DELETE * FROM --> syntaxe incorrect 
DELETE FROM employes
WHERE
  id_employes = 992;

DELETE FROM employes
WHERE
  id_employes IN (991, 8054);

-- ##############################################  EXERCICES : ########################################
-- 1 -- Afficher la profession de l'employé 547
SELECT
  prenom,
  service
FROM
  employes
WHERE
  id_employes = 547;

-- 2 -- Afficher la date d'embauche d'Amandine.
SELECT
  date_embauche
FROM
  employes
WHERE
  prenom = 'Amandine';

-- 3 -- Afficher le nom de famille de Guillaume
SELECT
  nom
FROM
  employes
WHERE
  prenom = 'Guillaume';

-- 4 -- Afficher le nombre de personne ayant un n° id_employes commen�ant par le chiffre 5.
SELECT
  COUNT(*) AS nb
FROM
  employes
WHERE
  id_employes LIKE '5%';

-- 5 -- Afficher le nombre de commerciaux.
SELECT
  COUNT(*) AS nb_commerciaux
FROM
  employes
WHERE
  service = 'commercial';

-- 6 -- Afficher le salaire moyen des informaticiens (+arrondie).
SELECT
  ROUND(AVG(salaire))
FROM
  employes
WHERE
  service = 'informatique';

-- 7 -- Afficher les 5 premiers employés aprés avoir classer leur nom de famille par ordre alphabétique.
SELECT
  *
FROM
  employes
ORDER BY
  nom ASC
LIMIT
  0, 5;

-- 8 -- Afficher le coût des commerciaux sur 1 année.
SELECT
  SUM(salaire * 12)
FROM
  employes
WHERE
  service = 'commercial';

-- 9 -- Afficher le salaire moyen par service. (service + salaire moyen)
SELECT
  AVG(salaire) As salaire_moyen_par_service
FROM
  employes
GROUP BY
  service;

-- 10 -- Afficher le nombre de recrutement sur l'année 2010 (+alias).
SELECT
  COUNT(*) AS nb_recrutement
FROM
  employes
WHERE
  date_embauche BETWEEN '2010-01-01' AND '2010-12-31';

-- 11 -- Afficher le salaire moyen appliqu� lors des recrutements sur la période allant de 2005 a 2007
SELECT
  ROUND(AVG(salaire), 2) AS salaire_moyen_des_recrutements_2005_2007
FROM
  employes
WHERE
  date_embauche BETWEEN '2005-01-01' AND '2007-12-31';

-- 12 -- Afficher le nombre de service différent
SELECT
  COUNT(DISTINCT service) AS NB_SERVICE
FROM
  employes;

SELECT DISTINCT
  service
FROM
  employes;

-- 13 -- Afficher tous les employés (sauf ceux du service production et secrétariat)
SELECT
  *
FROM
  employes
WHERE
  service NOT IN ('production', 'secrétariat');

-- 14 -- Afficher conjointement le nombre d'homme et de femme dans l'entreprise
SELECT
  sexe,
  COUNT(*) AS nb
FROM
  employes
GROUP BY
  sexe;

-- 15 -- Afficher les commerciaux ayant été recrutés avant 2005 de sexe masculin et gagnant un salaire supérieur a 2500€
SELECT
  *
FROM
  employes
WHERE
  service = 'commercial'
  AND date_embauche < '2005-01-01'
  AND sexe = 'm'
  AND salaire > 2500;

-- 16 -- Qui a été embauché en dernier
SELECT
  *
FROM
  employes
ORDER BY
  date_embauche DESC
LIMIT
  1;

-- 17 -- Afficher les informations sur l'employé du service commercial gagnant le salaire le plus élevé
SELECT
  *
FROM
  employes
WHERE
  service = 'commercial'
ORDER BY
  salaire DESC
LIMIT
  1;

-- 18 -- Afficher le prénom du comptable gagnant le meilleur salaire
SELECT
  prenom AS comptable_mieux_payé
FROM
  employes
WHERE
  service = 'comptabilité'
ORDER BY
  salaire DESC
LIMIT
  1;

-- 19 -- Afficher le prénom de l'informaticien ayant été recruté en premier
SELECT
  prenom AS premier_informaticien
FROM
  employes
WHERE
  service = 'informatique'
ORDER BY
  date_embauche ASC
LIMIT
  1;

-- 20 -- Augmenter chaque employé de 100€
UPDATE employes
SET
  salaire = salaire + 100;

-- 21 -- Supprimer les employés du service secrétariat
DELETE FROM employes
WHERE
  service = 'secrétariat';