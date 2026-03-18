# ARIPA - Test Technique : Gestion de la Flotte APPECOR

## Choix d'architecture

### Mission 1 — Modélisation BDD

Le schéma repose sur **4 tables** :

| Table      | Rôle                                              |
|------------|---------------------------------------------------|
| `famille`  | Groupement (ex: APPECOR)                          |
| `adherent` | Personne physique ou morale                       |
| `bateau`   | Référentiel des bateaux (immatriculation unique à chacun)  |
| `adhesion` | Lien bateau entre adhérent et année               |

**Clé de l'historique** : la table `adhesion` est le cœur du système de gestion.
Elle stocke **qui possède quel bateau pour quelle année**, avec une contrainte
d'unicité `(id_bateau, annee)` qui garantit la règle métier "1 bateau = 1 adhésion par an".

Ainsi, si par exemple LE DODO change de propriétaire, il suffit d'insérer une nouvelle ligne pour la nouvelle année sans toucher à l'historique.

### Mission 2 — Script métier

Le script principal est écrit en **PHP**, j'ai choisi ce langage car c'est le langage avec lequel je suis le plus à l'aise, ce qui me permet de produire un code lisible et maintenable.

| Langage | Fichier            |
|---------|--------------------|
| PHP     | `php/mission2.php` |

### Mission 3 — Requête SQL

Fichier : `sql/mission3.sql`

La requête effectue une auto-jointure sur la table `adhesion` en comparant
deux années consécutives pour le même bateau. Si l'`id_adherent` diffère
entre l'année N et N+1, c'est une cession.

---

## Structure du projet
```
Aripa/
├── sql/
│   ├── schema.sql
│   |── mission3.sql
│   └── MCD - ARIPA.pdf
├── php/
│   └── mission2.php
└── README.md
```

---

## Exécution

### PHP
```bash
php php/mission2.php 2025
```

### SQL (PostgreSQL)
```bash
psql -U postgres -d Aripa -f sql/schema.sql
psql -U postgres -d Aripa -f sql/mission3.sql
```

---

## SGBD cible

Le fichier `schema.sql` est écrit pour **PostgreSQL**, choisi pour sa robustesse et sa gestion stricte des contraintes (clés étrangères, unicité).
Pour MySQL, remplacer `SERIAL` par `INT AUTO_INCREMENT`.