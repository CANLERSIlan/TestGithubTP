-- TP Cours Base de Données
-- Script de création de la base de données

-- Suppression des tables si elles existent déjà (dans l'ordre inverse des dépendances)
DROP TABLE IF EXISTS Inscriptions;
DROP TABLE IF EXISTS Enseignements;
DROP TABLE IF EXISTS Cours;
DROP TABLE IF EXISTS Etudiants;
DROP TABLE IF EXISTS Professeurs;
DROP TABLE IF EXISTS Departements;

-- Table des départements
CREATE TABLE Departements (
    id          INT PRIMARY KEY AUTO_INCREMENT,
    nom         VARCHAR(100) NOT NULL UNIQUE,
    batiment    VARCHAR(50),
    budget      DECIMAL(12, 2)
);

-- Table des professeurs
CREATE TABLE Professeurs (
    id              INT PRIMARY KEY AUTO_INCREMENT,
    nom             VARCHAR(50)  NOT NULL,
    prenom          VARCHAR(50)  NOT NULL,
    email           VARCHAR(100) NOT NULL UNIQUE,
    specialite      VARCHAR(100),
    departement_id  INT,
    CONSTRAINT fk_prof_departement FOREIGN KEY (departement_id)
        REFERENCES Departements(id)
        ON DELETE SET NULL
);

-- Table des cours
CREATE TABLE Cours (
    id              INT PRIMARY KEY AUTO_INCREMENT,
    code            VARCHAR(20)  NOT NULL UNIQUE,
    intitule        VARCHAR(150) NOT NULL,
    description     TEXT,
    credits         INT          NOT NULL CHECK (credits > 0),
    departement_id  INT,
    CONSTRAINT fk_cours_departement FOREIGN KEY (departement_id)
        REFERENCES Departements(id)
        ON DELETE SET NULL
);

-- Table de liaison cours ↔ professeurs (un cours peut avoir plusieurs professeurs)
CREATE TABLE Enseignements (
    cours_id        INT NOT NULL,
    professeur_id   INT NOT NULL,
    annee_scolaire  VARCHAR(9) NOT NULL,   -- ex. "2024-2025"
    PRIMARY KEY (cours_id, professeur_id, annee_scolaire),
    CONSTRAINT fk_cp_cours       FOREIGN KEY (cours_id)      REFERENCES Cours(id)      ON DELETE CASCADE,
    CONSTRAINT fk_cp_professeur  FOREIGN KEY (professeur_id) REFERENCES Professeurs(id) ON DELETE CASCADE
);

-- Table des étudiants
CREATE TABLE Etudiants (
    id              INT PRIMARY KEY AUTO_INCREMENT,
    numero_etudiant VARCHAR(20)  NOT NULL UNIQUE,
    nom             VARCHAR(50)  NOT NULL,
    prenom          VARCHAR(50)  NOT NULL,
    date_naissance  DATE         NOT NULL,
    email           VARCHAR(100) NOT NULL UNIQUE,
    departement_id  INT,
    CONSTRAINT fk_etudiant_departement FOREIGN KEY (departement_id)
        REFERENCES Departements(id)
        ON DELETE SET NULL
);

-- Table des inscriptions (étudiants ↔ cours) avec note finale
CREATE TABLE Inscriptions (
    id              INT PRIMARY KEY AUTO_INCREMENT,
    etudiant_id     INT NOT NULL,
    cours_id        INT NOT NULL,
    annee_scolaire  VARCHAR(9) NOT NULL,
    date_inscription DATE DEFAULT (CURRENT_DATE),
    note            DECIMAL(4, 2) CHECK (note >= 0 AND note <= 20),
    CONSTRAINT uq_inscription UNIQUE (etudiant_id, cours_id, annee_scolaire),
    CONSTRAINT fk_insc_etudiant FOREIGN KEY (etudiant_id) REFERENCES Etudiants(id) ON DELETE CASCADE,
    CONSTRAINT fk_insc_cours    FOREIGN KEY (cours_id)    REFERENCES Cours(id)    ON DELETE CASCADE
);
