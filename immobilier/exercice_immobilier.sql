-- 1/ Affichez le nom des agences :
SELECT
  nom
FROM
  agence;

-- +---------------------+
-- | nom                 |
-- +---------------------+
-- | logic-immo          |
-- | century21           |
-- | laforet             |
-- | fnaim               |
-- | orpi                |
-- | foncia              |
-- | guy-hoquet          |
-- | seloger             |
-- | bouygues immobilier |
-- +---------------------+
-- 2/ Affichez le numéro de l’agence « Orpi » :
SELECT
  agence.id_agence
FROM
  agence
WHERE
  agence.nom = 'orpi';

-- +-----------+
-- | id_agence |
-- +-----------+
-- |    608870 |
-- +-----------+
-- 3/ Affichez le premier enregistrement de la table logement
SELECT
  *
FROM
  logement
LIMIT
  1;

-- +-------------+-------------+-------+--------+------------+-----------+
-- | id_logement | genre       | ville | prix   | superficie | categorie |
-- +-------------+-------------+-------+--------+------------+-----------+
-- |        5067 | appartement | paris | 685000 |         61 | vente     |
-- +-------------+-------------+-------+--------+------------+-----------+
-- 4/ Affichez le nombre de logements (Alias : Nombre de logements) :
SELECT
  COUNT(*) AS nombre
FROM
  logement;

-- +--------+
-- | nombre |
-- +--------+
-- |     28 |
-- +--------+
-- 5/ Affichez les logements à vendre à moins de 150 000€ dans l’ordre croissant des prix:
SELECT
  id_logement,
  genre,
  ville,
  prix,
  superficie,
  categorie
FROM
  logement
WHERE
  prix < 150000
  AND categorie = 'vente';

-- +-------------+-------------+----------+--------+------------+-----------+
-- | id_logement | genre       | ville    | prix   | superficie | categorie |
-- +-------------+-------------+----------+--------+------------+-----------+
-- |        5089 | appartement | paris    | 115000 |         15 | vente     |
-- |        5249 | appartement | lyon     | 110000 |         16 | vente     |
-- |        5378 | appartement | bordeaux | 121900 |         26 | vente     |
-- |        5860 | appartement | bordeaux |  98000 |         18 | vente     |
-- +-------------+-------------+----------+--------+------------+-----------+
-- 6/ Affichez le nombre de logements à la location (alias : nb) :
SELECT
  COUNT(*) AS nb
FROM
  logement
WHERE
  categorie = 'location';

-- +----+
-- | nb |
-- +----+
-- |  8 |
-- +----+
-- 7/ Affichez les villes différentes recherchées par les prospects pour accéder à un logement
SELECT DISTINCT
  ville
FROM
  demande;

-- +----------+
-- | ville    |
-- +----------+
-- | paris    |
-- | bordeaux |
-- | lyon     |
-- +----------+
-- 8/ Affichez le nombre de logements à vendre par ville (alias : nombre) :
SELECT
  ville,
  COUNT(*) AS nombre
FROM
  logement
GROUP BY
  ville;

-- +----------+--------+
-- | ville    | nombre |
-- +----------+--------+
-- | bordeaux |      9 |
-- | lyon     |      5 |
-- | paris    |     14 |
-- +----------+--------+
-- 9/ Quelles sont les références des logements à la location?
SELECT
  id_logement
FROM
  logement
WHERE
  categorie = 'location ';

-- +-------------+
-- | id_logement |
-- +-------------+
-- |        5122 |
-- |        5189 |
-- |        5246 |
-- |        5324 |
-- |        5412 |
-- |        5786 |
-- |        5898 |
-- |        5961 |
-- +-------------+
-- 10/ Quelles sont les références des logements entre 20 et 30m² ?
SELECT
  id_logement
FROM
  logement
WHERE
  superficie >= 20
  AND superficie <= 30;

-- +-------------+
-- | id_logement |
-- +-------------+
-- |        5336 |
-- |        5378 |
-- |        5786 |
-- +-------------+
-- 11/ Quel est le prix vendeur (hors commission) du logement le moins cher à vendre ? (Alias : prix_minimum) :
SELECT
  MIN(prix) AS prix_minimum
FROM
  logement
WHERE
  categorie = 'vente';

-- +--------------+
-- | prix_minimum |
-- +--------------+
-- |        98000 |
-- +--------------+
-- 12/ Dans quelle ville se trouve l’unique maison à vendre ?
SELECT DISTINCT
  genre,
  ville
FROM
  logement
WHERE
  genre = 'maison';

-- +--------+----------+
-- | genre  | ville    |
-- +--------+----------+
-- | maison | paris    |
-- | maison | bordeaux |
-- +--------+----------+
-- 13/ L’agence Orpi souhaite diminuer les frais qu’elle applique sur le logement ayant l‘id « 5246 ». Passez les frais de ce logement de 800 à 730€ :
UPDATE logement_agence
SET
  frais = 730
WHERE
  logement_id = 5246;

-- le montant des frais maintenant c'est quoi ?
-- Vérifier le montant des frais pour le logement ayant l'id "5246"
SELECT
  frais
FROM
  logement_agence
WHERE
  logement_id = 5246;

-- +-------+
-- | frais |
-- +-------+
-- |   730 |
-- +-------+
-- Query OK, 1 row affected (0.006 sec)
-- Rows matched: 1  Changed: 1  Warnings: 0
-- 14/ Quels sont les logements gérés par l’agence « laforet »
SELECT
  logement_agence.logement_id
FROM
  logement_agence
  INNER JOIN agence ON logement_agence.agence_id = agence.id_agence
WHERE
  agence.nom = 'laforet';

-- +-------------+
-- | logement_id |
-- +-------------+
-- |        5378 |
-- |        5723 |
-- |        5961 |
-- +-------------+
-- 15/ Affichez le nombre de propriétaires dans la ville de Paris (Alias : Nombre_de_proprietaires_dans_le_75) :
SELECT
  COUNT(DISTINCT logement_personne.personne_id) AS Nombre_de_proprietaires_dans_le_75
FROM
  logement
  INNER JOIN logement_personne ON logement.id_logement = logement_personne.logement_id
WHERE
  logement.ville = 'paris';

-- +------------------------------------+
-- | Nombre_de_proprietaires_dans_le_75 |
-- +------------------------------------+
-- |                                 13 |
-- +------------------------------------+
-- 16/ Affichez les informations des trois premiers personnes souhaitant acheter un logement
SELECT
  personne.prenom,
  logement_personne.personne_id,
  logement.genre,
  logement.ville,
  logement.prix,
  logement.superficie,
  logement.categorie
FROM
  personne
  INNER JOIN logement ON logement_personne.personne_id = personne.id_personne
  INNER JOIN logement ON
  -- 16/ Affichez les informations des trois premiers personnes souhaitant acheter un logement
SELECT
  personne.prenom,
  logement_personne.personne_id,
  logement.genre,
  logement.ville,
  logement.prix,
  logement.superficie,
  logement.categorie
FROM
  logement_personne
  INNER JOIN personne ON logement_personne.personne_id = personne.id_personne
  INNER JOIN logement ON logement_personne.logement_id = logement.id_logement
WHERE
  logement.categorie = 'vente'
LIMIT
  3;

-- +          +             +             +          +        +            +           +
-- | prenom  | personne_id | type        | ville    | budget | superficie | categorie |
-- +          +             +             +          +        +            +           +
-- | william |           1 | appartement | paris    | 530000 |        120 | vente     |
-- | mehdi   |           3 | appartement | bordeaux | 120000 |         18 | vente     |
-- | charles |           4 | appartement | bordeaux | 145000 |         21 | vente     |
-- +         +             +             +          +        +            +           +
-- 17/ Quel est le prénom du vendeur pour le logement ayant la référence « 5770 » ?
-- +        +
-- | prenom |
-- +        +
-- | robin  |
-- +        +
-- 18/ Quels sont les prénoms des personnes souhaitant accéder à un logement à Lyon?
-- +         +
-- | prenom  |
-- +         +
-- | sarah   |
-- | yvon    |
-- | camille |
-- | anna    |
-- | sabrina |
-- | franck  |
-- | axelle  |
-- | morgane |
-- +         +
-- 19/ Quels sont les prénoms des personnes souhaitant accéder à un logement en location dans la ville Paris?
-- +          +
-- | prenom   |
-- +          +
-- | julie    |
-- | aurore   |
-- | marie    |
-- | melissa  |
-- | kevin    |
-- | victoria |
-- +          +
-- 20/ Affichez les prénoms des prospects cherchant à acheter un logement de la plus grande à la plus petite superficie
-- +           +            +
-- | prenom    | superficie |
-- +           +            +
-- | william   |        120 |
-- | franck    |        100 |
-- | leo       |        100 |
-- | simon     |         80 |
-- | sabrina   |         70 |
-- | camille   |         65 |
-- | jonathan  |         60 |
-- | sarah     |         55 |
-- | ophelie   |         40 |
-- | patrick   |         40 |
-- | hugo      |         40 |
-- | enzo      |         40 |
-- | brigitte  |         26 |
-- | valentine |         25 |
-- | anna      |         21 |
-- | charles   |         21 |
-- | mehdi     |         18 |
-- | samuel    |         15 |
-- | celia     |         15 |
-- | axelle    |         12 |
-- 21/ Quel sont les prix finaux proposés par les agences pour la maison à la vente ayant la référence « 5091 » ? (Alias : prix final)
-- +                  +
-- |   prix final      |
-- +                  +
-- |           538621 |
-- |           544564 |
-- +                  +
-- 22/ Indiquez les frais ajoutés par l’agence immobilière pour le logement ayant la référence « 5873 » ?
-- +          +        +       +
-- | id_logement| prix   | frais |
-- +          +        +       +
-- |     5873 | 176700 | 13504 |
-- +          +        +       +
-- 23/ Si l’ensemble des logements était vendu ou loué demain, quel serait le bénéfice généré grâce aux frais d’agence et pour chaque agence (Alias : benefice, par ordre croissant des gains)
-- +                     +          +
-- | nom                 | benefice |
-- +                     +          +
-- | century21           |    26575 |
-- | laforet             |    28606 |
-- | seloger             |    29483 |
-- | bouygues immobilier |    65970 |
-- | guy-hoquet          |    66592 |
-- | foncia              |    76832 |
-- | orpi                |    90530 |
-- | logic-immo          |   116779 |
-- | fnaim               |   126163 |
-- +                     +          +
-- 24/ Affichez les références des logements en location, les prix suivis des frais d’agence (dans l’ordre croissant des prix) :
-- +                     +          +      +       +
-- | nom                 | logement_id| prix | frais |
-- +                     +          +      +       +
-- | orpi                |     5189 |  420 |   350 |
-- | seloger             |     5122 |  550 |   700 |
-- | century21           |     5786 |  570 |   520 |
-- | foncia              |     5786 |  570 |   898 |
-- | bouygues immobilier |     5961 |  650 |   890 |
-- | logic-immo          |     5961 |  650 |  1240 |
-- | laforet             |     5961 |  650 |   300 |
-- | orpi                |     5246 |  670 |   800 |
-- | logic-immo          |     5412 |  680 |   680 |
-- | century21           |     5898 |  690 |   250 |
-- | bouygues immobilier |     5898 |  690 |  1300 |
-- | logic-immo          |     5898 |  690 |   900 |
-- | fnaim               |     5324 |  690 |   600 |
-- +                     +          +      +       +
-- 25/ Quel est le prix du logement (hors frais) le moins cher à louer ? (Affichez également le prénom du propriétaire)
-- +        +      +
-- | prenom | prix |
-- +        +      +
-- | johan  |  420 |
-- +        +      +
-- 26/ Affichez le prénom et la ville où se trouve le logement de chaque propriétaire :
-- +            +          +
-- | prenom     | ville    |
-- +            +          +
-- | priscillia | paris    |
-- | assia      | paris    |
-- | nathan     | paris    |
-- | gaetan     | bordeaux |
-- | johan      | lyon     |
-- | lucas      | paris    |
-- | quentin    | paris    |
-- | emmanuel   | lyon     |
-- | noemie     | bordeaux |
-- | clement    | paris    |
-- | mathieu    | lyon     |
-- | nathalie   | bordeaux |
-- | florian    | bordeaux |
-- | antoine    | paris    |
-- | chloe      | paris    |
-- | adele      | bordeaux |
-- | charlotte  | bordeaux |
-- | robin      | paris    |
-- | alexandre  | bordeaux |
-- | alexis     | paris    |
-- | agathe     | paris    |
-- | elodie     | bordeaux |
-- | lea        | lyon     |
-- | tom        | lyon     |
-- | caroline   | paris    |
-- | alice      | bordeaux |
-- | lola       | paris    |
-- +            +          +
-- 27/ Quel est l’agence immobilière s’occupant de la plus grande gestion de logement répertorié à Paris ? (alias :nb, trié par ordre décroissant)
-- +                     +    +
-- | nom                 | nb |
-- +                     +    +
-- | logic-immo          |  6 |
-- | foncia              |  4 |
-- | century21           |  4 |
-- | fnaim               |  4 |
-- | bouygues immobilier |  4 |
-- | orpi                |  3 |
-- | guy-hoquet          |  1 |
-- +                     +    +
-- 28/ Affichez le prix et le prénom des vendeurs dont les logements sont proposés à 130000€ ou moins en prix final avec frais appliqués par les agences (alias : prix final, ordre croissant des prix) :
-- +          +          +
-- | prenom   | prix final|
-- +          +          +
-- | elodie   |   113905 |
-- | elodie   |   117566 |
-- | emmanuel |   117625 |
-- | assia    |   122623 |
-- | assia    |   123633 |
-- | emmanuel |   126358 |
-- +          +          +
-- 29/ Affichez le nombre de logements à la vente dans la même ville de recherche de « hugo » (alias : nb):
-- +    +
-- | nb |
-- +----+
-- |  9 |
-- +----+
-- 30/ Affichez le nombre de logements à la vente dans la ville de recherche de « hugo » et dans la superficie minimum qu’il attend ou dans une superficie supérieure (alias : nb):
-- +    +
-- | nb |
-- +----+
-- |  6 |
-- +----+
-- 31/ Affichez le nombre d’opportunités d’achats dans la ville de recherche de « hugo » dans la superficie minimum qu’il attend ou dans une superficie supérieure et en prenant en compte tous ses autres critères de sélection (alias : nb):
-- +    +
-- | nb |
-- +----+
-- |  3 |
-- +----+
-- 32/ Affichez les informations des logements à vendre répondant à tous les critères de sélection de « hugo » (alias) :
-- 33/ En prenant en compte le « fichier client » avec leurs critères de sélections répertorié sur la table « demande », quelle est l’agence immobilière susceptible de faire le plus de ventes ? (alias : nb)
-- +                     +    +
-- | agence              | nb |
-- +                     +    +
-- | logic-immo          |  8 |
-- | fnaim               |  7 |
-- | orpi                |  6 |
-- | century21           |  6 |
-- | guy-hoquet          |  4 |
-- | laforet             |  3 |
-- | foncia              |  2 |
-- | bouygues immobilier |  2 |
-- +                     +    +