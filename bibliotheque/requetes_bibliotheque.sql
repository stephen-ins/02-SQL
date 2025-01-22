-- Afficher l'id des livres qui n'ont pas été rendu à la bibliothèque
-- Un champ NULL se test avec IS (fonction ISNULL(colonne))
SELECT
  livre_id,
  abonne_id,
  date_sortie
FROM
  emprunt
WHERE
  date_rendu IS NULL;

-- +----------+-----------+-------------+
-- | livre_id | abonne_id | date_sortie |
-- +----------+-----------+-------------+
-- |      105 |         3 | 2015-06-13  |
-- |      100 |         2 | 2015-06-15  |
-- +----------+-----------+-------------+
-- #################### REQUETES IMBRIQUES ############################
-- Afficher le titre des livres qui n'ont pas été rendu à la bibliothèque
-- O titre des livres dans la nature (exemple)
SELECT
  titre,
  auteur
FROM
  livre
WHERE
  id_livre IN (
    SELECT
      livre_id
    FROM
      emprunt
    WHERE
      date_rendu IS NULL
  );

-- La requête exécutée en première et selectionne dans la table emprunt les id des livres qui n'ont pas été rendu, ensuite la deuxième requête est exécutée et selectionne dans la table livre les titres des livres
SELECT
  titre
FROM
  livre
WHERE
  id_livre IN (100, 105)
  -- +-------------------------+-------------------+
  -- | titre                   | auteur            |
  -- +-------------------------+-------------------+
  -- | Une vie                 | GUY DE MAUPASSANT |
  -- | Les trois mousquetaires | ALEXANDRE DUMAS   |
  -- +-------------------------+-------------------+
  -- Exo : Liste des abonnés n'ayant pas rendu les livres à la bibliothèque
SELECT
  prenom
FROM
  abonne
WHERE
  id_abonne IN (
    SELECT
      abonne_id
    FROM
      empruntI
    WHERE
      date_rendu IS NULL
  );

-- Exo : Nous aimerions connaitre les numéros des livres que Chloé a emprunté à la bibliothèque (exemple)
SELECT
  livre_id
FROM
  emprunt
WHERE
  abonne_id = (
    SELECT
      id_abonne
    FROM
      abonne
    WHERE
      prenom = 'Chloe'
  );

-- Exo : Afficher les prénoms des abonnés qui ont emprunté un livre le 19/12/2014
SELECT
  prenom
FROM
  abonne
WHERE
  id_abonne IN (
    SELECT
      abonne_id
    FROM
      emprunt
    WHERE
      date_sortie = '2014/12/19'
  );

-- Exo : Combien de livres ont été emprunté par Guillaume
SELECT
  COUNT(*) AS nb_livres_empruntes_par_guillaume
FROM
  emprunt
WHERE
  abonne_id = (
    SELECT
      id_abonne
    FROM
      abonne
    WHERE
      prenom = 'guillaume'
  );

-- Exo : Afficher la liste des abonnés ayant déjà emprunté un livre d'Alphonse Daudet.
SELECT
  prenom
FROM
  abonne
WHERE
  id_abonne IN (
    SELECT
      abonne_id
    FROM
      emprunt
    WHERE
      livre_id = (
        SELECT
          id_livre
        FROM
          livre
        WHERE
          auteur = 'alphonse daudet'
      )
  );

-- Exo : Nous aimerions connaitre le titre de(s) livre(s) que Chloé a emprunté à la bibliothèque
SELECT
  titre
FROM
  livre
WHERE
  id_livre IN (
    SELECT
      livre_id
    FROM
      emprunt
    WHERE
      abonne_id = (
        SELECT
          id_abonne
        FROM
          abonne
        WHERE
          prenom = 'chloe'
      )
  );

-- Exo : Nous aimerions connaitre les titres des livres que Chloé n'a pas encore emprunté
SELECT
  titre
FROM
  livre
WHERE
  id_livre NOT IN (
    SELECT
      livre_id
    FROM
      emprunt
    WHERE
      abonne_id = (
        SELECT
          id_abonne
        FROM
          abonne
        WHERE
          prenom = 'chloe'
      )
  );

-- Exo : Connaitre le titre de(s) livre(s) que Chloé n'a pas encore rendu à la bibliothèque
SELECT
  titre
FROM
  livre
WHERE
  id_livre IN (
    SELECT
      livre_id
    FROM
      emprunt
    WHERE
      date_rendu IS NULL
      AND abonne_id IN (
        SELECT
          id_abonne
        FROM
          abonne
        WHERE
          prenom = 'chloe'
      )
  );

-- Exo : Qui a emprunté le plus de livre à la bibliothèque
SELECT
  prenom
FROM
  abonne
WHERE
  id_abonne = (
    SELECT
      abonne_id
    FROM
      emprunt
    GROUP BY
      abonne_id
    ORDER BY
      COUNT(*) DESC
    LIMIT
      0, 1
  );

-- #################### JOINTURES ############################
-- Différence Jointure et requête imbriquée : une jointure et une requete imbriquée permettent de faire des relations entres plusieurs tables afin d'avoir des colonnes associées pour former qu'un seul résultat. 
-- Une jointure est possible dans tous les cas.
-- Une requête imbriquée est possible seulement dans le cas où le résultat est issue de la même table.
-- Dans ce cas précis, bien qu'une jointure soit possible, la requête imbriquée aura quand même l'avantage de s'exécuter plus rapidement (cependant, il n'est pas possible de la constater sur la console).
-- #######################
-- Jointure explicite:
SELECT
  abonne.prenom,
  emprunt.date_sortie,
  emprunt.date_rendu
FROM
  abonne,
  emprunt
WHERE
  abonne.id_abonne = emprunt.abonne_id
  AND abonne.prenom = 'guillaume';

-- SELECT : ce que nous voulons afficher, quelles colonnes on veut afficher dans notre résultat
-- FROM : de quelles tables porviennent les données
-- WHERE : lien entre les champs communs (id_abonne et abonne_id)
-- AND : condition supplémentaire
-- #######################
-- Jointure implicite:
-- avec clause INNER JOIN
-- INNER JOIN : jointure interne pour retourner les enregistrements quand la condition est vrai dans les 2 tables. C'est l'une des jointures les plus communes. Il faut spécifier le nom de la table et la condition de jointure (correspondance).
SELECT
  abonne.prenom,
  emprunt.date_sortie,
  emprunt.date_rendu
FROM
  abonne
  INNER JOIN emprunt
WHERE
  abonne.id_abonne = emprunt.abonne_id
  AND abonne.prenom = 'guillaume';

-- Exo : Nous aimerions connaitre les mouvements des livres (date sortie et date rendu, auteur et titre) écrit par Alphonse Daudet
SELECT
  abonne.prenom,
  emprunt.date_sortie,
  emprunt.date_rendu,
  livre.auteur,
  livre.titre
FROM
  abonne
  INNER JOIN emprunt
  INNER JOIN livre
WHERE
  abonne.id_abonne = emprunt.abonne_id
  AND livre.id_livre = emprunt.livre_id
  AND livre.auteur = 'alphonse daudet';

-- Exo : Qui a emprunté le livre "Une vie" sur l'année 2014 ? : (prenom, titre, date_sortie)
SELECT
  abonne.prenom,
  livre.titre,
  emprunt.date_sortie
FROM
  abonne
  INNER JOIN emprunt ON abonne.id_abonne = emprunt.abonne_id
  INNER JOIN livre ON emprunt.livre_id = livre.id_livre
WHERE
  livre.titre = 'Une vie'
  AND YEAR (emprunt.date_sortie) = 2014;

-- o exercice : Nous aimerions connaitre le nombre de livre(s) emprunté(s) par chaque abonné. : (prenom, nombre de livre)
SELECT
  abonne.prenom,
  COUNT(*) AS nb_livres_empruntes
FROM
  abonne
  INNER JOIN emprunt ON abonne.id_abonne = emprunt.abonne_id
GROUP BY
  abonne.prenom;

-- o exercice : Nous aimerions connaitre le nombre de livre(s) a rendre pour chaque abonné. : (prenom, nombre de livre)
SELECT
  abonne.prenom,
  COUNT(emprunt.abonne_id) AS nb_livres_a_rendre
FROM
  abonne
  INNER JOIN emprunt ON abonne.id_abonne = emprunt.abonne_id
GROUP BY
  emprunt.abonne_id;

-- o  exercice : Qui a emprunté Quoi ? et Quand ? (Titre des livres emprunté, à quel date, et savoir par qui).
SELECT
  abonne.prenom,
  COUNT(emprunt.abonne_id) AS nb_livres_empruntes
FROM
  abonne
  INNER JOIN emprunt ON abonne.id_abonne = emprunt.abonne_id
  AND emprunt.date_rendu IS NULL
GROUP BY
  emprunt.abonne_id;

-- exercice : Afficher les prenoms des abonnés avec les n° des livres quils ont emprunté.
SELECT
  abonne.prenom,
  emprunt.date_sortie,
  livre.titre
FROM
  abonne
  INNER JOIN emprunt
  INNER JOIN livre ON abonne.id_abonne = emprunt.abonne_id;

AND emprunt.livre_id = livre.id_livre;

-- Exo : Afficher les prénoms des abonnés avec les n° des livres qu'ils ont emprunté
SELECT
  abonne.prenom,
  emprunt.livre_id
FROM
  abonne
  INNER JOIN emprunt ON abonne.id_abonne = emprunt.abonne_id;

-- Exo : ajouter vous 'stephen' dans la base de donnée (faite un insert)
INSERT INTO
  abonne (prenom)
VALUES
  ('Stephen');

-- Jointure externe : LEFT JOIN
SELECT
  abonne.prenom,
  emprunt.livre_id
FROM
  abonne
  LEFT JOIN emprunt ON abonne.id_abonne = emprunt.abonne_id;

-- Si nous prenons le cas d'un site e-commerce, si nous voulons afficher toutes les commandes liées aux produits mais que certains ont été supprimés, ne sont plus disponible, sans une jointure externe, toute les commandes liées aux pro
-- -- LEFT JOIN : joindre par la table de gauche (toutes les données de la table de gauche sont rapatriés même s'il n'y a pas de correspondance dans l'autre table.
-- ON : sur la base de la liaison du champ commun. le ON remplace le WHERE dans le cadre des jointures externe (relations sans correspondance).
-- Si nous prenons le cas d'un site e-commerce, si nous voulons afficher toutes les commandes liées aux produits mais que certains ont été supprimés, ne sont plus disponible, sans une jointure externe, toute les commandes liées aux pro.