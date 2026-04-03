# TP Cours Base de Données (TP_COURSBD)

Travaux pratiques du cours de Bases de Données relationnelles.

## Objectifs pédagogiques

- Concevoir un schéma relationnel (tables, clés primaires, clés étrangères, contraintes)
- Insérer et manipuler des données avec SQL
- Maîtriser les requêtes `SELECT`, `JOIN`, `GROUP BY`, sous-requêtes, vues et fonctions de fenêtrage

## Contenu du dépôt

| Fichier | Description |
|---|---|
| `create_db.sql` | Création de la base de données : tables, contraintes, relations |
| `insert_data.sql` | Insertion des données de test (départements, professeurs, étudiants, cours, inscriptions) |
| `queries.sql` | Requêtes SQL couvrant les 6 parties du TP |

## Modèle de données

```
Departements ──< Professeurs
Departements ──< Cours
Departements ──< Etudiants
Cours        ──< Enseignements    >── Professeurs
Cours        ──< Inscriptions    >── Etudiants
```

## Parties du TP

| Partie | Thème | Requêtes |
|--------|-------|----------|
| 1 | Requêtes de base (`SELECT`, `WHERE`, `ORDER BY`) | Q1 – Q3 |
| 2 | Jointures (`JOIN`, `LEFT JOIN`) | Q4 – Q6 |
| 3 | Agrégations (`GROUP BY`, `HAVING`, `AVG`, `COUNT`) | Q7 – Q10 |
| 4 | Sous-requêtes | Q11 – Q13 |
| 5 | Mises à jour et suppressions (`UPDATE`, `DELETE`) | Q14 – Q15 |
| 6 | Vues et fonctions de fenêtrage (`RANK`) | Q16 – Q17 |

## Utilisation

```bash
# Créer la base et les tables
mysql -u <utilisateur> -p <base_de_données> < create_db.sql

# Insérer les données de test
mysql -u <utilisateur> -p <base_de_données> < insert_data.sql

# Exécuter les requêtes
mysql -u <utilisateur> -p <base_de_données> < queries.sql
```

> Les scripts sont compatibles avec **MySQL 8.0+** (utilisation de `RANK()` et `CREATE OR REPLACE VIEW`).