CREATE DATABASE IF NOT EXISTS bibliotheque;

USE bibliotheque;

CREATE TABLE
  abonne (
    id_abonne INT (11) NOT NULL AUTO_INCREMENT,
    prenom VARCHAR(255) NOT NULL,
    PRIMARY KEY (id_abonne)
  ) ENGINE = InnoDB;

CREATE TABLE
  livre (
    id_livre INT (11) NOT NULL AUTO_INCREMENT,
    auteur VARCHAR(255) NOT NULL,
    titre VARCHAR(255) NOT NULL,
    PRIMARY KEY (id_livre)
  ) ENGINE = InnoDB;

CREATE TABLE
  emprunt (
    id_emprunt INT (11) NOT NULL AUTO_INCREMENT,
    livre_id INT (11) NOT NULL,
    abonne_id INT (11) NOT NULL,
    date_sortie DATE NOT NULL,
    date_rendu DATE DEFAULT NULL,
    PRIMARY KEY (id_emprunt)
  ) ENGINE = InnoDB;

INSERT INTO
  abonne (id_abonne, prenom)
VALUES
  (1, 'Guillaume'),
  (2, 'Benoît'),
  (3, 'Chloé'),
  (4, 'Laura');

INSERT INTO
  livre (id_livre, auteur, titre)
VALUES
  (100, 'GUY DE MAUPASSANT', 'Une vie'),
  (101, 'GUY DE MAUPASSANT', 'Bel-ami'),
  (102, 'HONORE DE BALZAC', 'Le pere Goriot'),
  (103, 'ALPHONSE DAUDET', 'Le petit chose'),
  (104, 'ALEXANDRE DUMAS', 'La reine Margot'),
  (105, 'ALEXANDRE DUMAS', 'Les trois mousquetaires');

INSERT INTO
  emprunt (
    id_emprunt,
    livre_id,
    abonne_id,
    date_sortie,
    date_rendu
  )
VALUES
  (1, 100, 1, '2014-12-17', '2014-12-18'),
  (2, 101, 2, '2014-12-18', '2014-12-20'),
  (3, 102, 3, '2014-12-19', '2014-12-22'),
  (4, 103, 4, '2014-12-19', '2014-12-22'),
  (5, 104, 1, '2014-12-19', '2014-12-28'),
  (6, 105, 2, '20/03/2015', '2015-03-26'),
  (7, 105, 3, '2015-06-13', NULL),
  (8, 100, 2, '2015-06-15', NULL);