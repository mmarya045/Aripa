-- ========================
-- Schéma relationnel ARIPA
-- ========================

CREATE TABLE famille (
    id SERIAL PRIMARY KEY,
    nom VARCHAR(100) NOT NULL UNIQUE
);

CREATE TABLE bateau (
    id SERIAL PRIMARY KEY,
    nom VARCHAR(100) NOT NULL,
    immatriculation VARCHAR(20) NOT NULL UNIQUE,
    id_famille INTEGER REFERENCES famille(id) NOT NULL
);

CREATE TABLE adherent (
    id SERIAL PRIMARY KEY,
    nom VARCHAR(100) NOT NULL UNIQUE,
    type VARCHAR(20)  NOT NULL CHECK (type IN ('physique', 'morale')),
    email VARCHAR(100),
    telephone VARCHAR(20),
    created_at DATE NOT NULL DEFAULT CURRENT_DATE
);

CREATE TABLE adhesion (
    id SERIAL PRIMARY KEY,
    id_adherent INTEGER REFERENCES adherent(id) NOT NULL,
    id_bateau INTEGER REFERENCES bateau(id) NOT NULL,
    date_adhesion DATE NOT NULL DEFAULT CURRENT_DATE,
    date_paiement DATE,
    montant DECIMAL(10,2),
    annee INTEGER NOT NULL,
    CONSTRAINT unique_bateau_annee UNIQUE (id_bateau, annee)
);

CREATE INDEX idx_adhesion_annee ON adhesion(annee);
CREATE INDEX idx_adhesion_adherent ON adhesion(id_adherent);
CREATE INDEX idx_adhesion_bateau ON adhesion(id_bateau);

-- ===========================================
-- Données fictives (2024 - 2026)
-- ===========================================

INSERT INTO famille (nom) VALUES ('APPECOR');

INSERT INTO bateau (nom, immatriculation, id_famille) VALUES
    ('LE DODO', 'RU 987654', 1),
    ('LA FOURNAISE', 'RU 123456', 1),
    ('PAILLE-EN-QUEUE', 'RU 112233', 1),
    ('BOURBON 1', 'RU 445566', 1),
    ('BOURBON 2', 'RU 778899', 1),
    ('ZOURIT', 'RU 556677', 1),
    ('BOURBON 3', 'RU 990011', 1);

INSERT INTO adherent (nom, type) VALUES
    ('Jean PAYET', 'physique'),
    ('Marie HOAREAU', 'physique'),
    ('Pêcheries du Port', 'morale'),
    ('Antoine TECHER', 'physique'),
    ('Luc GRONDIN', 'physique'),
    ('Armement Sud', 'morale');

INSERT INTO adhesion (id_bateau, id_adherent, annee, date_adhesion, date_paiement) VALUES
-- Adhésions 2024
    (1, 1, 2024, '2024-01-15', '2024-02-10'),
    (2, 1, 2024, '2024-01-15', '2024-02-10'),
    (3, 2, 2024, '2024-03-10', '2024-03-10'),
    (4, 3, 2024, '2024-02-01', '2024-04-05'),
    (5, 3, 2024, '2024-02-01', '2024-04-05'),
    (6, 4, 2024, '2024-08-20', '2024-08-20'),
--  2025
    (2, 1, 2025, '2025-01-20', '2025-02-15'),
    (1, 5, 2025, '2025-02-10', '2025-02-10'),
    (3, 2, 2025, '2025-01-15', '2025-03-01'),
    (4, 3, 2025, '2025-01-10', '2025-02-28'),
    (5, 3, 2025, '2025-01-10', '2025-02-28'),
    (7, 3, 2025, '2025-06-15', '2025-07-01'),
    (6, 4, 2025, '2025-03-01', NULL),
--  2026
    (1, 5, 2026, '2026-01-10', '2026-01-25'),
    (2, 1, 2026, '2026-02-05', '2026-02-20'),
    (3, 2, 2026, '2026-01-20', NULL),
    (4, 6, 2026, '2026-03-01', '2026-03-15'),
    (5, 3, 2026, '2026-01-15', '2026-02-10'),
    (7, 3, 2026, '2026-01-15', '2026-02-10'),
    (6, 4, 2026, '2026-11-05', '2026-11-10');
