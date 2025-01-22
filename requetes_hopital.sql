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

-- 2 Afficher le prénom des patients
SELECT
  prenom
FROM
  patient;

-- 3 Afficher le numéro de téléphone du patient dont le prénom est "antoine"
SELECT
  telephone
FROM
  patient
WHERE
  prenom = 'antoine';

-- 4 Afficher le premier enregistrement de la table personnel
SELECT
  *
FROM
  personnel
LIMIT
  0, 1;

-- 5 Afficher le nombre de patients (alias: Nombre_de_patients)
SELECT
  COUNT(*) AS Nombre_de_patients
FROM
  patient;

-- 6 Afficher les membres du personnel ayant un salaire supérieur à "1600" €
SELECT
  COUNT(*) AS nb
FROM
  personnel
WHERE
  salaire > 1600;

-- 7 Combien de chambres peuvent recevoir plusieurs patients simultanément ?
SELECT
  COUNT(*) AS nb
FROM
  chambre
WHERE
  capacite > 1;

-- 8 Afficher les prénoms des patients de sexe "féminin" dans l'ordre croissant des prénoms
SELECT
  prenom
FROM
  patient
WHERE
  sexe = "f";

-- 9 Quel est le membre du personnel le plus jeune ?
SELECT
  *
FROM
  personnel
ORDER BY
  date_naissance DESC
LIMIT
  1;

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

-- 11 Quel est le salaire annuel de "Ophélie" ayant l'id "13" ? (alias : salaire_annuel)
SELECT
  SUM(salaire * 12) AS salaire_annuel
FROM
  personnel
WHERE
  prenom = "ophelie";

-- 12 Quelles étaient les chambres occupées entre le 01 février 2011 et le 15 février 2011