SELECT
    b.nom AS nom_bateau,
    b.immatriculation,
    a_ancien.nom AS ancien_proprietaire,
    a_nouveau.nom AS nouveau_proprietaire,
    adh_ancien.annee AS annee_ancienne,
    adh_nouveau.annee AS annee_nouvelle
FROM adhesion adh_ancien
JOIN adhesion adh_nouveau
    ON  adh_nouveau.id_bateau = adh_ancien.id_bateau
    AND adh_nouveau.annee = adh_ancien.annee + 1
    AND adh_nouveau.id_adherent != adh_ancien.id_adherent
JOIN bateau b ON b.id = adh_ancien.id_bateau
JOIN adherent a_ancien ON a_ancien.id = adh_ancien.id_adherent
JOIN adherent a_nouveau ON a_nouveau.id = adh_nouveau.id_adherent
ORDER BY b.nom, adh_ancien.annee;
