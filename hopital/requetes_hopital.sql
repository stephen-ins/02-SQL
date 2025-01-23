-- Création de la base de données
CREATE DATABASE nom_bdd;

-- Permet de voir, d'afficher la liste des bases de données
SHOW DATABASES;

-- Permet de sélectionner / utiliser une base de donnée
USE hopital;

-- Permet de supprimer une base de donnée
DROP DATABASE hopital;

-- Permet de supprimer une table
DROP TABLE hopital;

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

-- ################################# EXERCICES HOPITAL ###########################
-- 1 - Quelles sont les services de l'hôpital ?
SELECT
  nom
FROM
  service;

--   +-------------------------+
-- | nom                     |
-- +-------------------------+
-- | urgence                 |
-- | cardiologie             |
-- | neurologie              |
-- | orthopedie-rhumatologie |
-- | reanimation             |
-- +-------------------------+
-- 2 Afficher le prénom des patients
SELECT
  prenom
FROM
  patient;

--   -- +------------+
-- | prenom     |
-- +------------+
-- | william    |
-- | gaetan     |
-- | jean       |
-- | charles    |
-- | brigitte   |
-- | sarah      |
-- | lucas      |
-- | quentin    |
-- | patrick    |
-- | emmanuel   |
-- | elodie     |
-- | agathe     |
-- | valentine  |
-- | charlotte  |
-- | alice      |
-- | samuel     |
-- | mathieu    |
-- | noemie     |
-- | simon      |
-- | florian    |
-- | clement    |
-- | yvon       |
-- | lea        |
-- | chloe      |
-- | camille    |
-- | alexandre  |
-- | julie      |
-- | leo        |
-- | antoine    |
-- | lola       |
-- | celia      |
-- | anna       |
-- | caroline   |
-- | adele      |
-- | sabrina    |
-- | nathalie   |
-- | franck     |
-- | tom        |
-- | johan      |
-- | priscillia |
-- +------------+
-- 3 Afficher le numéro de téléphone du patient dont le prénom est "antoine"
SELECT
  telephone
FROM
  patient
WHERE
  prenom = 'antoine';

-- +------------+
-- | telephone  |
-- +------------+
-- | 0177033081 |
-- +------------+
-- 4 Afficher le premier enregistrement de la table personnel
SELECT
  *
FROM
  personnel
LIMIT
  0, 1;

--   +--------------+--------+---------+------+------------+----------+----------------+---------+------------+
-- | id_personnel | prenom | nom     | sexe | profession | qualite  | date_naissance | salaire | service_id |
-- +--------------+--------+---------+------+------------+----------+----------------+---------+------------+
-- |            1 | nathan | charvet | m    | infirmier  | employes | 1980-08-26     |    1600 | 1          |
-- +--------------+--------+---------+------+------------+----------+----------------+---------+------------+
-- 5 Afficher le nombre de patients (alias: Nombre_de_patients)
SELECT
  COUNT(*) AS Nombre_de_patients
FROM
  patient;

-- +--------------------+
-- | Nombre_de_patients |
-- +--------------------+
-- |                 40 |
-- +--------------------+
-- 6 Afficher les membres du personnel ayant un salaire supérieur à "1600" €
SELECT
  COUNT(*) AS nb
FROM
  personnel
WHERE
  salaire > 1600;

--   +----+
-- | nb |
-- +----+
-- |  5 |
-- +----+
-- 7 Combien de chambres peuvent recevoir plusieurs patients simultanément ?
SELECT
  COUNT(*) AS nb
FROM
  chambre
WHERE
  capacite > 1;

-- +----+
-- | nb |
-- +----+
-- | 12 |
-- +----+
-- 8 Afficher les prénoms des patients de sexe "féminin" dans l'ordre croissant des prénoms
SELECT
  prenom
FROM
  patient
WHERE
  sexe = "f";

-- +------------+
-- | prenom     |
-- +------------+
-- | brigitte   |
-- | sarah      |
-- | elodie     |
-- | agathe     |
-- | valentine  |
-- | charlotte  |
-- | alice      |
-- | noemie     |
-- | lea        |
-- | chloe      |
-- | camille    |
-- | julie      |
-- | lola       |
-- | celia      |
-- | anna       |
-- | caroline   |
-- | adele      |
-- | sabrina    |
-- | nathalie   |
-- | priscillia |
-- +------------+
-- 9 Quel est le membre du personnel le plus jeune ?
SELECT
  *
FROM
  personnel
ORDER BY
  date_naissance DESC
LIMIT
  1;

-- +--------------+--------+--------+------+---------------+----------+----------------+---------+------------+
-- | id_personnel | prenom | nom    | sexe | profession    | qualite  | date_naissance | salaire | service_id |
-- +--------------+--------+--------+------+---------------+----------+----------------+---------+------------+
-- |            6 | ines   | moulet | f    | aide soignant | employes | 1988-05-21     |    1400 | 1          |
-- +--------------+--------+--------+------+---------------+----------+----------------+---------+------------+
-- 10 Quels sont les salaires moyens dans les différentes professions représentées au sein de l'hôpital ? (en limitant à 2 chiffres après la virgule, en donnant l'alias "salaire moyen" en en classant dans l'ordre croissant)
SELECT
  profession,
  ROUND(AVG(salaire), 2) AS salaire_moyen
FROM
  personnel
GROUP BY
  profession
ORDER BY
  salaire_moyen ASC;

-- +---------------+---------------+
-- | profession    | salaire_moyen |
-- +---------------+---------------+
-- | secretaire    |       1300.00 |
-- | aide soignant |       1400.00 |
-- | infirmier     |       1505.00 |
-- | psychologue   |       1700.00 |
-- | medecin       |       1966.67 |
-- +---------------+---------------+
-- 11 Quel est le salaire annuel de "Ophélie" ayant l'id "13" ? (alias : salaire_annuel)
SELECT
  SUM(salaire * 12) AS salaire_annuel
FROM
  personnel
WHERE
  prenom = "ophelie";

-- +----------------+
-- | salaire_annuel |
-- +----------------+
-- |          24000 |
-- +----------------+
-- 12 Quelles étaient les chambres occupées entre le 01 février 2011 et le 15 février 2011
SELECT
  chambre.id_chambre,
  association_patient_chambre.id_patient,
  association_patient_chambre.date_entree,
  association_patient_chambre.date_sortie
FROM
  association_patient_chambre
  INNER JOIN chambre ON association_patient_chambre.chambre_id = chambre.id_chambre
WHERE
  association_patient_chambre.date_entree >= '2011-02-01'
  AND association_patient_chambre.date_sortie <= '2011-02-15';

-- +------------+------------+-------------+-------------+
-- | id_chambre | id_patient | date_entree | date_sortie |
-- +------------+------------+-------------+-------------+
-- |         10 |          1 | 2011-02-01  | 2011-02-15  |
-- |          3 |         14 | 2011-02-01  | 2011-02-02  |
-- |          4 |         15 | 2011-02-01  | 2011-02-05  |
-- |         16 |         16 | 2011-02-01  | 2011-02-09  |
-- |          4 |         17 | 2011-02-07  | 2011-02-09  |
-- |          7 |         18 | 2011-02-09  | 2011-02-11  |
-- |          7 |         20 | 2011-02-01  | 2011-02-02  |
-- |         18 |         21 | 2011-02-01  | 2011-02-13  |
-- |          8 |         29 | 2011-02-01  | 2011-02-06  |
-- |          9 |         30 | 2011-02-01  | 2011-02-08  |
-- |          5 |         34 | 2011-02-12  | 2011-02-13  |
-- |          3 |         38 | 2011-02-08  | 2011-02-10  |
-- |          2 |         39 | 2011-02-01  | 2011-02-01  |
-- |          1 |         40 | 2011-02-10  | 2011-02-10  |
-- +------------+------------+-------------+-------------+
-- 13 Quel sont les prénoms des membres du personnel travaillant au service "urgence" ?
SELECT
  personnel.prenom,
  personnel.service_id
FROM
  personnel
  INNER JOIN service ON personnel.service_id = service.id_service
WHERE
  service.nom = 'urgence';

-- +--------+------------+
-- | prenom | service_id |
-- +--------+------------+
-- | nathan | 1          |
-- | aurore | 1          |
-- | marie  | 1          |
-- | oceane | 1          |
-- | enzo   | 1          |
-- | ines   | 1          |
-- | hugo   | 1          |
-- +--------+------------+
-- 14 Dans quelle(s) chambre(s) a séjourné la patiente ayant le prénom "elodie" ?
SELECT
  chambre.id_chambre
FROM
  association_patient_chambre
  INNER JOIN patient ON association_patient_chambre.id_patient = patient.id_patient
  INNER JOIN chambre ON association_patient_chambre.chambre_id = chambre.id_chambre
WHERE
  patient.prenom = 'elodie';

-- +------------+
-- | id_chambre |
-- +------------+
-- |          2 |
-- +------------+
-- 15 Dans quel(s) service(s) a séjourné la patiente ayant le prénom "elodie" ?
SELECT
  service.nom
FROM
  association_patient_chambre
  INNER JOIN patient ON association_patient_chambre.id_patient = patient.id_patient
  INNER JOIN chambre ON association_patient_chambre.chambre_id = chambre.id_chambre
  INNER JOIN service ON chambre.service_id = service.id_service
WHERE
  patient.prenom = 'elodie';

-- +---------+
-- | nom     |
-- +---------+
-- | urgence |
-- +---------+
-- 16 Affichez les informations sur les chambres du service "neurologie" ?
SELECT
  service.nom,
  chambre.id_chambre,
  chambre.capacite
FROM
  chambre
  INNER JOIN service ON chambre.service_id = service.id_service
WHERE
  service.nom = 'neurologie';

-- +------------+------------+----------+
-- | nom        | id_chambre | capacite |
-- +------------+------------+----------+
-- | neurologie |         19 |        2 |
-- | neurologie |         20 |        3 |
-- | neurologie |         21 |        2 |
-- | neurologie |         22 |        2 |
-- | neurologie |         23 |        2 |
-- | neurologie |         24 |        2 |
-- | neurologie |         25 |        3 |
-- | neurologie |         26 |        2 |
-- | neurologie |         27 |        2 |
-- +------------+------------+----------+
-- Compter -1 par chambre il y'a déjà une incrémentation suite à la question 18
-- #########################################################################
-- 17 Quels étaient les prénoms des patients se trouvant à l'hôpital entre le 01 février 2011 et le 15 février 2011, et dans quelle(s) chambre(s) se trouvaient-ils ?
SELECT
  patient.prenom,
  patient.id_patient,
  chambre.id_chambre,
  association_patient_chambre.date_entree,
  association_patient_chambre.date_sortie
FROM
  association_patient_chambre
  INNER JOIN patient ON association_patient_chambre.id_patient = patient.id_patient
  INNER JOIN chambre ON association_patient_chambre.chambre_id = chambre.id_chambre
WHERE
  association_patient_chambre.date_entree >= '2011-02-01'
  AND association_patient_chambre.date_sortie <= '2011-02-15';

-- +------------+------------+------------+-------------+-------------+
-- | prenom     | id_patient | id_chambre | date_entree | date_sortie |
-- +------------+------------+------------+-------------+-------------+
-- | william    |          1 |         10 | 2011-02-01  | 2011-02-15  |
-- | charlotte  |         14 |          3 | 2011-02-01  | 2011-02-02  |
-- | alice      |         15 |          4 | 2011-02-01  | 2011-02-05  |
-- | samuel     |         16 |         16 | 2011-02-01  | 2011-02-09  |
-- | mathieu    |         17 |          4 | 2011-02-07  | 2011-02-09  |
-- | noemie     |         18 |          7 | 2011-02-09  | 2011-02-11  |
-- | florian    |         20 |          7 | 2011-02-01  | 2011-02-02  |
-- | clement    |         21 |         18 | 2011-02-01  | 2011-02-13  |
-- | antoine    |         29 |          8 | 2011-02-01  | 2011-02-06  |
-- | lola       |         30 |          9 | 2011-02-01  | 2011-02-08  |
-- | adele      |         34 |          5 | 2011-02-12  | 2011-02-13  |
-- | tom        |         38 |          3 | 2011-02-08  | 2011-02-10  |
-- | johan      |         39 |          2 | 2011-02-01  | 2011-02-01  |
-- | priscillia |         40 |          1 | 2011-02-10  | 2011-02-10  |
-- +------------+------------+------------+-------------+-------------+
-- 18 Un lit a été ajouté dans toutes les chambres du service "neurologie". Modifier leur capacité.
UPDATE chambre
INNER JOIN service ON chambre.service_id = service.id_service
SET
  chambre.capacite = chambre.capacite + 1
WHERE
  service.nom = 'neurologie';

-- Query OK, 9 rows affected (0.012 sec)
-- Rows matched: 9  Changed: 9  Warnings: 0
-- Connaître le nombre de lits en neurologie pour controle après la question 18
SELECT
  SUM(chambre.capacite) AS total_lits
FROM
  chambre
  INNER JOIN service ON chambre.service_id = service.id_service
WHERE
  service.nom = 'neurologie';

-- +------------+
-- | total_lits |
-- +------------+
-- |         20 |
-- +------------+
-- 19 Combien y'a t'il d'infirmiers par services ?
SELECT
  service.nom,
  COUNT(personnel.id_personnel) AS 'count(p.prenom)'
FROM
  service
  INNER JOIN personnel ON service.id_service = personnel.service_id
WHERE
  personnel.profession = 'infirmier'
GROUP BY
  service.nom;

-- +-------------+-----------------+
-- | nom         | count(p.prenom) |
-- +-------------+-----------------+
-- | cardiologie |               3 |
-- | neurologie  |               3 |
-- | urgence     |               4 |
-- +-------------+-----------------+
-- 20 Quel est le médecin potentiel qui s'est occupé de la patiente ayant le prénom "charlotte" lors de sont passage à l'hôpital ?
SELECT
  personnel.prenom,
  personnel.nom,
  personnel.profession,
  patient.id_patient,
  chambre.id_chambre
FROM
  personnel
  INNER JOIN patient ON patient.id_patient = personnel.id_personnel
  INNER JOIN chambre ON chambre.id_chambre = personnel.WHERE patient.prenom = 'charlotte';

-- 20 Quel est le médecin potentiel qui s'est occupé de la patiente ayant le prénom "charlotte" lors de sont passage à l'hôpital ?
SELECT
  personnel.prenom,
  personnel.nom,
  personnel.profession,
  service.id_service,
  patient.id_patient,
  chambre.id_chambre
FROM
  association_patient_chambre
  INNER JOIN patient ON association_patient_chambre.id_patient = patient.id_patient
  INNER JOIN chambre ON association_patient_chambre.chambre_id = chambre.id_chambre
  INNER JOIN personnel ON chambre.service_id = personnel.service_id
  INNER JOIN service ON personnel.service_id = service.id_service
WHERE
  patient.prenom = 'charlotte'
  AND personnel.profession = 'medecin';

--   +--------+----------+------------+------------+------------+------------+
-- | prenom | nom      | profession | id_service | id_patient | id_chambre |
-- +--------+----------+------------+------------+------------+------------+
-- | hugo   | larousse | medecin    |          1 |         14 |          3 |
-- +--------+----------+------------+------------+------------+------------+


