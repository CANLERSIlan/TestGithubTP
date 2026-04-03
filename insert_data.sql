-- TP Cours Base de Données
-- Script d'insertion des données de test

-- Départements
INSERT INTO Departements (nom, batiment, budget) VALUES
    ('Informatique',        'Bâtiment A', 500000.00),
    ('Mathématiques',       'Bâtiment B', 350000.00),
    ('Physique',            'Bâtiment C', 420000.00),
    ('Gestion',             'Bâtiment D', 280000.00);

-- Professeurs
INSERT INTO Professeurs (nom, prenom, email, specialite, departement_id) VALUES
    ('Martin',    'Alice',   'alice.martin@univ.fr',    'Bases de données',        1),
    ('Dupont',    'Bernard', 'bernard.dupont@univ.fr',  'Algorithmique',            1),
    ('Lambert',   'Claire',  'claire.lambert@univ.fr',  'Analyse numérique',        2),
    ('Girard',    'David',   'david.girard@univ.fr',    'Physique quantique',        3),
    ('Moreau',    'Elise',   'elise.moreau@univ.fr',    'Gestion de projet',         4),
    ('Petit',     'François','francois.petit@univ.fr',  'Réseaux et sécurité',       1);

-- Cours
INSERT INTO Cours (code, intitule, description, credits, departement_id) VALUES
    ('BD101',  'Introduction aux bases de données',  'Modélisation relationnelle, SQL de base',                     3, 1),
    ('BD201',  'Bases de données avancées',           'Transactions, indexation, optimisation des requêtes',         4, 1),
    ('ALGO101','Algorithmique et structures de données','Tri, recherche, complexité',                               4, 1),
    ('MATH101','Analyse mathématique',                 'Limites, dérivées, intégrales',                              4, 2),
    ('MATH201','Algèbre linéaire',                     'Vecteurs, matrices, espaces vectoriels',                     3, 2),
    ('PHY101', 'Physique générale',                    'Mécanique classique, thermodynamique',                       3, 3),
    ('GEST101','Management de projet',                 'Méthodes agiles, planification, gestion des risques',        3, 4),
    ('NET101', 'Réseaux informatiques',                'Modèle OSI, TCP/IP, protocoles de communication',            3, 1);

-- Association cours ↔ professeurs
INSERT INTO Enseignements (cours_id, professeur_id, annee_scolaire) VALUES
    (1, 1, '2024-2025'),  -- BD101 → Alice Martin
    (2, 1, '2024-2025'),  -- BD201 → Alice Martin
    (3, 2, '2024-2025'),  -- ALGO101 → Bernard Dupont
    (4, 3, '2024-2025'),  -- MATH101 → Claire Lambert
    (5, 3, '2024-2025'),  -- MATH201 → Claire Lambert
    (6, 4, '2024-2025'),  -- PHY101 → David Girard
    (7, 5, '2024-2025'),  -- GEST101 → Elise Moreau
    (8, 6, '2024-2025'),  -- NET101 → François Petit
    (3, 6, '2024-2025');  -- ALGO101 → François Petit (co-enseignement)

-- Étudiants
INSERT INTO Etudiants (numero_etudiant, nom, prenom, date_naissance, email, departement_id) VALUES
    ('E20240001', 'Durand',    'Sophie',   '2002-03-15', 'sophie.durand@etu.fr',    1),
    ('E20240002', 'Bernard',   'Thomas',   '2001-11-22', 'thomas.bernard@etu.fr',   1),
    ('E20240003', 'Leclerc',   'Camille',  '2003-06-08', 'camille.leclerc@etu.fr',  2),
    ('E20240004', 'Fontaine',  'Hugo',     '2002-01-30', 'hugo.fontaine@etu.fr',    1),
    ('E20240005', 'Rousseau',  'Léa',      '2001-09-12', 'lea.rousseau@etu.fr',     3),
    ('E20240006', 'Blanc',     'Nathan',   '2003-04-25', 'nathan.blanc@etu.fr',     1),
    ('E20240007', 'Garnier',   'Julie',    '2002-07-19', 'julie.garnier@etu.fr',    4),
    ('E20240008', 'Chevalier', 'Maxime',   '2001-12-05', 'maxime.chevalier@etu.fr', 2),
    ('E20240009', 'Morin',     'Emma',     '2003-02-14', 'emma.morin@etu.fr',       1),
    ('E20240010', 'Simon',     'Lucas',    '2002-08-03', 'lucas.simon@etu.fr',      1);

-- Inscriptions (année 2024-2025) avec notes
INSERT INTO Inscriptions (etudiant_id, cours_id, annee_scolaire, date_inscription, note) VALUES
    -- Sophie Durand
    (1, 1, '2024-2025', '2024-09-10', 15.50),
    (1, 2, '2024-2025', '2024-09-10', 13.00),
    (1, 3, '2024-2025', '2024-09-10', 17.00),
    -- Thomas Bernard
    (2, 1, '2024-2025', '2024-09-11', 11.00),
    (2, 3, '2024-2025', '2024-09-11',  8.50),
    (2, 8, '2024-2025', '2024-09-11', 14.00),
    -- Camille Leclerc
    (3, 4, '2024-2025', '2024-09-09', 18.00),
    (3, 5, '2024-2025', '2024-09-09', 16.50),
    -- Hugo Fontaine
    (4, 1, '2024-2025', '2024-09-12', 12.00),
    (4, 2, '2024-2025', '2024-09-12',  9.50),
    (4, 3, '2024-2025', '2024-09-12', 10.00),
    (4, 8, '2024-2025', '2024-09-12', 11.50),
    -- Léa Rousseau
    (5, 6, '2024-2025', '2024-09-10', 14.00),
    (5, 4, '2024-2025', '2024-09-10', 13.50),
    -- Nathan Blanc
    (6, 1, '2024-2025', '2024-09-13', 16.00),
    (6, 3, '2024-2025', '2024-09-13', 14.50),
    (6, 8, '2024-2025', '2024-09-13', 19.00),
    -- Julie Garnier
    (7, 7, '2024-2025', '2024-09-10',  NULL),  -- pas encore de note
    (7, 1, '2024-2025', '2024-09-10',  NULL),
    -- Maxime Chevalier
    (8, 4, '2024-2025', '2024-09-11',  7.00),
    (8, 5, '2024-2025', '2024-09-11', 10.50),
    -- Emma Morin
    (9, 1, '2024-2025', '2024-09-10', 18.50),
    (9, 2, '2024-2025', '2024-09-10', 17.00),
    (9, 3, '2024-2025', '2024-09-10', 20.00),
    -- Lucas Simon
    (10, 1, '2024-2025', '2024-09-12', 13.00),
    (10, 8, '2024-2025', '2024-09-12', 15.00),
    (10, 3, '2024-2025', '2024-09-12', 12.50);
