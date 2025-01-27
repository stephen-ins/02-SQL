-- conducteur 
-- +---------------+----------+-----------+
-- | id_conducteur | prenom   | nom       |
-- +---------------+----------+-----------+
-- |             1 | Julien   | Avigny    |
-- |             2 | Morgane  | Alamia    |
-- |             3 | Philippe | Pandre    |
-- |             4 | Amelie   | Blondelle |
-- |             5 | Alex     | Richy     |
-- +---------------+----------+-----------+
-- association_vehicule_conducteur
-- +----------------+-------------+---------------+
-- | id_association | vehicule_id | conducteur_id |
-- +----------------+-------------+---------------+
-- |              1 |         501 |             1 |
-- |              2 |         502 |             2 |
-- |              3 |         503 |             3 |
-- |              4 |         504 |             4 |
-- |              5 |         501 |             3 |
-- +----------------+-------------+---------------+
-- vehicule
-- +-------------+---------------------+---------+---------+-----------------+
-- | id_vehicule | marque		   		| modele  | couleur | immatriculation |
-- +-------------+---------------------+---------+---------+-----------------+
-- |         501 | Peugeot             | 807     | noir    | AB-355-CA       |
-- |         502 | Citroen             | C8      | bleu    | CE-122-AE       |
-- |         503 | Mercedes            | Cls     | vert    | FG-953-HI       |
-- |         504 | Volkswagen          | Touran  | noir    | SO-322-NV       |
-- |         505 | Skoda               | Octavia | gris    | PB-631-TK       |
-- |         506 | Volkswagen          | Passat  | gris    | XN-973-MM       |
-- +-------------+---------------------+---------+---------+-----------------+
------------------------------------------------------------------------------------------
-- Exercice 1
-- Pour éviter les erreurs, la société de taxis aimerait que l’on ne puisse pas faire une mauvaise association lors de la saisie.
-- Exemple : conducteur 58 avec le véhicule 900 (car ils n’existent pas).
-- Faite le test.
-- Exercice 2
-- La société de taxis peut modifier leurs conducteurs via leur logiciel, lorsqu’un conducteur est modifié (dans la table conducteur - changement d’id par exemple), la société aimerait que la modification soit répercutée dans la table « association_vehicule_conducteur ». 
-- Faite le test.
-- Exercice 3
-- La société de taxis peut supprimer des conducteurs via leur logiciel, ils aimeraient bloquer la possibilité de supprimer un conducteur (dans la table conducteur) tant que celui-ci conduit un véhicule.
-- Faite le test.
-- Exercice 4
-- La société de taxis peut modifier un véhicule via leur logiciel. Lorsqu’un véhicule est modifié (dans la table véhicule - changement d’id par exemple), la société aimerait que la modification soit répercutée dans la table « association_vehicule_conducteur ». 
-- Faite le test.
-- Exercice 5
-- Si un véhicule est supprimé alors qu’un ou plusieurs conducteurs le conduisaient, la société aimerait garder la présence de ces conducteurs dans la table « association_vehicule_conducteur » en précisant « null » comme valeur dans le champ correspondant puisque le véhicule aura été supprimé.
-- Faite le test. 
-- 6/	Qui conduit la voiture 503 ?
SELECT
  prenom
FROM
  conducteur
  INNER JOIN association_vehicule_conducteur ON conducteur_id = id_conducteur
WHERE
  vehicule_id = 503;

-- +----------+
-- | prenom   |
-- +----------+
-- | philippe |
-- +----------+
-- 7/	Qui conduit quoi ?
SELECT
  vehicule.modele,
  conducteur.prenom
FROM
  conducteur
  INNER JOIN association_vehicule_conducteur ON conducteur.id_conducteur = association_vehicule_conducteur.conducteur_id
  INNER JOIN vehicule ON association_vehicule_conducteur.vehicule_id = vehicule.id_vehicule;

-- +---------+----------+
-- | modele  | prenom   |
-- +---------+----------+
-- | 807     | julien   |
-- | octavia | morgane  |
-- | cls     | philippe |
-- | touran  | amelie   |
-- | 807     | philippe |
-- +---------+----------+
-- 8/	Ajoutez vous dans la liste des conducteurs.
-- 8/	Afficher les conducteurs (meme ceux qui n'ont pas de correspondance avec les vehicules)
INSERT INTO
  conducteur
VALUES
  (NULL, 'Stephen ', 'INS');

SELECT
  vehicule.modele,
  conducteur.prenom
FROM
  conducteur
  LEFT JOIN association_vehicule_conducteur ON conducteur.id_conducteur = association_vehicule_conducteur.conducteur_id
  LEFT JOIN vehicule ON association_vehicule_conducteur.vehicule_id = vehicule.id_vehicule;

-- +---------+----------+
-- | modele  | prenom   |
-- +---------+----------+
-- | 807     | julien   |
-- | octavia | morgane  |
-- | cls     | philippe |
-- | touran  | amelie   |
-- | 807     | philippe |
-- | NULL    | alex     |
-- | NULL    | Stephen  |
-- +---------+----------+
-- 9/	Ajoutez un nouvel enregistrement dans la table des v�hicules.
-- 9/	Afficher les vehicules (meme ceux qui n'ont pas de correspondance avec les conducteurs)
INSERT INTO
  vehicule
VALUES
  (NULL, 'mercedes', 'classe A', 'noir', 'AB-123-CD');

SELECT
  vehicule.modele,
  conducteur.prenom
FROM
  vehicule
  LEFT JOIN association_vehicule_conducteur ON vehicule.id_vehicule = association_vehicule_conducteur.vehicule_id
  LEFT JOIN conducteur ON association_vehicule_conducteur.conducteur_id = conducteur.id_conducteur;

-- 2ème exemple
SELECT
  vehicule.modele,
  conducteur.prenom
FROM
  conducteur
  RIGHT JOIN association_vehicule_conducteur ON conducteur.id_conducteur = association_vehicule_conducteur.conducteur_id
  RIGHT JOIN vehicule ON association_vehicule_conducteur.vehicule_id = vehicule.id_vehicule;

-- +----------+----------+
-- | modele   | prenom   |
-- +----------+----------+
-- | 807      | julien   |
-- | octavia  | morgane  |
-- | cls      | philippe |
-- | touran   | amelie   |
-- | 807      | philippe |
-- | octavia  | NULL     |
-- | passat   | NULL     |
-- | classe A | NULL     |
-- +----------+----------+
-- 10/	Afficher tous les conducteurs et tous les vehicules, peut importe les correspondances.
SELECT
  vehicule.modele,
  conducteur.prenom
FROM
  conducteur
  LEFT JOIN association_vehicule_conducteur ON conducteur.id_conducteur = association_vehicule_conducteur.conducteur_id
  LEFT JOIN vehicule ON association_vehicule_conducteur.vehicule_id = vehicule.id_vehicule
UNION
SELECT
  vehicule.modele,
  conducteur.prenom
FROM
  conducteur
  RIGHT JOIN association_vehicule_conducteur ON conducteur.id_conducteur = association_vehicule_conducteur.conducteur_id
  RIGHT JOIN vehicule ON association_vehicule_conducteur.vehicule_id = vehicule.id_vehicule;

--   +----------+----------+
-- | modele   | prenom   |
-- +----------+----------+
-- | 807      | julien   |
-- | octavia  | morgane  |
-- | cls      | philippe |
-- | touran   | amelie   |
-- | 807      | philippe |
-- | NULL     | alex     |
-- | NULL     | Stephen  |
-- | octavia  | NULL     |
-- | passat   | NULL     |
-- | classe A | NULL     |
-- +----------+----------+