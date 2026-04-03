-- TP Cours Base de Données
-- Script de requêtes SQL

-- =============================================================
-- PARTIE 1 : Requêtes de base (SELECT, WHERE, ORDER BY)
-- =============================================================

-- Q1. Lister tous les étudiants par ordre alphabétique (nom, prénom)
SELECT nom, prenom, numero_etudiant, email
FROM Etudiants
ORDER BY nom, prenom;

-- Q2. Afficher les cours du département Informatique (id=1) avec leur nombre de crédits
SELECT c.code, c.intitule, c.credits
FROM Cours c
WHERE c.departement_id = 1
ORDER BY c.credits DESC;

-- Q3. Lister les professeurs dont la spécialité contient "données"
SELECT nom, prenom, specialite
FROM Professeurs
WHERE specialite LIKE '%données%';

-- =============================================================
-- PARTIE 2 : Jointures (JOIN)
-- =============================================================

-- Q4. Afficher le nom de chaque étudiant avec les cours auxquels il est inscrit
--     et la note obtenue
SELECT e.nom        AS etudiant_nom,
       e.prenom     AS etudiant_prenom,
       c.code       AS cours_code,
       c.intitule   AS cours_intitule,
       i.note
FROM Inscriptions i
JOIN Etudiants e ON e.id = i.etudiant_id
JOIN Cours     c ON c.id = i.cours_id
ORDER BY e.nom, e.prenom, c.code;

-- Q5. Afficher les professeurs avec les cours qu'ils enseignent en 2024-2025
SELECT p.nom        AS professeur_nom,
       p.prenom     AS professeur_prenom,
       c.code       AS cours_code,
       c.intitule   AS cours_intitule
FROM Enseignements cp
JOIN Professeurs p ON p.id = cp.professeur_id
JOIN Cours       c ON c.id = cp.cours_id
WHERE cp.annee_scolaire = '2024-2025'
ORDER BY p.nom, c.code;

-- Q6. Lister les étudiants avec le nom de leur département
SELECT e.numero_etudiant,
       e.nom, e.prenom,
       d.nom AS departement
FROM Etudiants e
LEFT JOIN Departements d ON d.id = e.departement_id
ORDER BY d.nom, e.nom;

-- =============================================================
-- PARTIE 3 : Agrégations (GROUP BY, HAVING, fonctions d'agrégat)
-- =============================================================

-- Q7. Calculer la moyenne des notes par cours (en ignorant les notes NULL)
SELECT c.code,
       c.intitule,
       ROUND(AVG(i.note), 2) AS moyenne,
       MIN(i.note)           AS note_min,
       MAX(i.note)           AS note_max,
       COUNT(i.note)         AS nb_notes
FROM Cours c
LEFT JOIN Inscriptions i ON i.cours_id = c.id
GROUP BY c.id, c.code, c.intitule
ORDER BY moyenne DESC;

-- Q8. Trouver les étudiants ayant une moyenne générale supérieure à 14
SELECT e.nom, e.prenom,
       ROUND(AVG(i.note), 2) AS moyenne_generale
FROM Etudiants e
JOIN Inscriptions i ON i.etudiant_id = e.id
WHERE i.note IS NOT NULL
GROUP BY e.id, e.nom, e.prenom
HAVING AVG(i.note) > 14
ORDER BY moyenne_generale DESC;

-- Q9. Compter le nombre d'étudiants inscrits dans chaque cours
SELECT c.code,
       c.intitule,
       COUNT(i.etudiant_id) AS nb_inscrits
FROM Cours c
LEFT JOIN Inscriptions i ON i.cours_id = c.id
GROUP BY c.id, c.code, c.intitule
ORDER BY nb_inscrits DESC;

-- Q10. Calculer le total de crédits validés par étudiant
--      (un cours est validé si la note est >= 10)
SELECT e.nom, e.prenom,
       SUM(c.credits) AS credits_valides
FROM Etudiants e
JOIN Inscriptions i ON i.etudiant_id = e.id
JOIN Cours        c ON c.id = i.cours_id
WHERE i.note >= 10
GROUP BY e.id, e.nom, e.prenom
ORDER BY credits_valides DESC;

-- =============================================================
-- PARTIE 4 : Sous-requêtes
-- =============================================================

-- Q11. Lister les étudiants qui ont obtenu au moins une note supérieure à la
--      moyenne de toutes les notes
SELECT DISTINCT e.nom, e.prenom
FROM Etudiants e
JOIN Inscriptions i ON i.etudiant_id = e.id
WHERE i.note > (
    SELECT AVG(note)
    FROM Inscriptions
    WHERE note IS NOT NULL
)
ORDER BY e.nom;

-- Q12. Afficher les cours dans lesquels aucun étudiant n'est inscrit
SELECT c.code, c.intitule
FROM Cours c
WHERE c.id NOT IN (
    SELECT DISTINCT cours_id
    FROM Inscriptions
);

-- Q13. Trouver l'étudiant ayant obtenu la meilleure note au cours BD101
SELECT e.nom, e.prenom, i.note
FROM Etudiants e
JOIN Inscriptions i ON i.etudiant_id = e.id
JOIN Cours        c ON c.id = i.cours_id
WHERE c.code = 'BD101'
  AND i.note = (
      SELECT MAX(i2.note)
      FROM Inscriptions i2
      JOIN Cours c2 ON c2.id = i2.cours_id
      WHERE c2.code = 'BD101'
  );

-- =============================================================
-- PARTIE 5 : Mises à jour et suppressions (UPDATE / DELETE)
-- =============================================================

-- Q14. Attribuer la note 12.00 aux inscriptions sans note du cours GEST101
UPDATE Inscriptions i
JOIN Cours c ON c.id = i.cours_id
SET i.note = 12.00
WHERE c.code = 'GEST101'
  AND i.note IS NULL;

-- Q15. Supprimer les inscriptions dont la note est inférieure à 5
--      (abandon de cours)
DELETE FROM Inscriptions
WHERE note IS NOT NULL
  AND note < 5;

-- =============================================================
-- PARTIE 6 : Requêtes avancées (vues, classements)
-- =============================================================

-- Q16. Créer une vue récapitulant le bulletin de chaque étudiant
CREATE OR REPLACE VIEW v_bulletin AS
SELECT e.numero_etudiant,
       e.nom              AS etudiant_nom,
       e.prenom           AS etudiant_prenom,
       d.nom              AS departement,
       c.code             AS cours_code,
       c.intitule         AS cours_intitule,
       c.credits,
       i.note,
       CASE
           WHEN i.note IS NULL  THEN 'Non noté'
           WHEN i.note >= 16    THEN 'Mention Très Bien'
           WHEN i.note >= 14    THEN 'Mention Bien'
           WHEN i.note >= 12    THEN 'Mention Assez Bien'
           WHEN i.note >= 10    THEN 'Passable'
           ELSE                      'Ajourné'
       END AS appreciation,
       i.annee_scolaire
FROM Inscriptions i
JOIN Etudiants   e ON e.id = i.etudiant_id
JOIN Cours       c ON c.id = i.cours_id
LEFT JOIN Departements d ON d.id = e.departement_id;

-- Utilisation de la vue : bulletin de Sophie Durand
SELECT *
FROM v_bulletin
WHERE etudiant_nom = 'Durand'
  AND etudiant_prenom = 'Sophie'
ORDER BY cours_code;

-- Q17. Classer les étudiants par moyenne générale (tous cours confondus)
SELECT e.nom, e.prenom,
       ROUND(AVG(i.note), 2)                                      AS moyenne,
       RANK() OVER (ORDER BY AVG(i.note) DESC)                       AS classement
FROM Etudiants e
JOIN Inscriptions i ON i.etudiant_id = e.id
WHERE i.note IS NOT NULL
GROUP BY e.id, e.nom, e.prenom
ORDER BY classement;
