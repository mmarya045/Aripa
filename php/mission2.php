<?php

if ($argc !== 2) {
    echo "Erreur : donne une année en paramètre\n";
    echo "Exemple : php mission2.php 2025\n";
    exit(1);
}

$annee = (int)$argv[1];

$adherents = [
    1 => "Jean PAYET",
    2 => "Marie HOAREAU",
    3 => "Pêcheries du Port",
    4 => "Antoine TECHER",
    5 => "Luc GRONDIN",
    6 => "Armement Sud",
];

$bateaux = [
    1 => ["nom" => "LE DODO",         "immat" => "RU 987654"],
    2 => ["nom" => "LA FOURNAISE",    "immat" => "RU 123456"],
    3 => ["nom" => "PAILLE-EN-QUEUE", "immat" => "RU 112233"],
    4 => ["nom" => "BOURBON 1",       "immat" => "RU 445566"],
    5 => ["nom" => "BOURBON 2",       "immat" => "RU 778899"],
    6 => ["nom" => "ZOURIT",          "immat" => "RU 556677"],
    7 => ["nom" => "BOURBON 3",       "immat" => "RU 990011"],
];

$adhesions = [
    [1, 1, 2024, "2024-01-15", "2024-02-10"],
    [2, 1, 2024, "2024-01-15", "2024-02-10"],
    [3, 2, 2024, "2024-03-10", "2024-03-10"],
    [4, 3, 2024, "2024-02-01", "2024-04-05"],
    [5, 3, 2024, "2024-02-01", "2024-04-05"],
    [6, 4, 2024, "2024-08-20", "2024-08-20"],
    [2, 1, 2025, "2025-01-20", "2025-02-15"],
    [1, 5, 2025, "2025-02-10", "2025-02-10"],
    [3, 2, 2025, "2025-01-15", "2025-03-01"],
    [4, 3, 2025, "2025-01-10", "2025-02-28"],
    [5, 3, 2025, "2025-01-10", "2025-02-28"],
    [7, 3, 2025, "2025-06-15", "2025-07-01"],
    [6, 4, 2025, "2025-03-01", null],
    [1, 5, 2026, "2026-01-10", "2026-01-25"],
    [2, 1, 2026, "2026-02-05", "2026-02-20"],
    [3, 2, 2026, "2026-01-20", null],
    [4, 6, 2026, "2026-03-01", "2026-03-15"],
    [5, 3, 2026, "2026-01-15", "2026-02-10"],
    [7, 3, 2026, "2026-01-15", "2026-02-10"],
    [6, 4, 2026, "2026-11-05", "2026-11-10"],
];

$result = [];

foreach ($adhesions as $adhesion) {

    $bateauId     = $adhesion[0];
    $adherentId   = $adhesion[1];
    $anneeAdhesion = $adhesion[2];
    $dateAdhesion = $adhesion[3];
    $datePaiement = $adhesion[4];

    if ($anneeAdhesion !== $annee) {
        continue;
    }

    if (!isset($result[$adherentId])) {
        $result[$adherentId] = [
            "nom"                    => $adherents[$adherentId],
            "total_bateaux"          => 0,
            "cotisations_payees"     => 0,
            "cotisations_en_attente" => 0,
            "bateaux"                => [],
        ];
    }

    if ($datePaiement !== null) {
        $etat = "payée";
        $result[$adherentId]["cotisations_payees"]++;
    } else {
        $etat = "en attente";
        $result[$adherentId]["cotisations_en_attente"]++;
    }
    $result[$adherentId]["bateaux"][] = [
        "nom"             => $bateaux[$bateauId]["nom"],
        "immatriculation" => $bateaux[$bateauId]["immat"],
        "date_adhesion"   => $dateAdhesion,
        "date_paiement"   => $datePaiement,
        "cotisation"      => $etat,
    ];
    $result[$adherentId]["total_bateaux"]++;
}

if (empty($result)) {
    echo "Aucune adhésion trouvée pour l'année " . $annee . "\n";
    exit(0);
}

usort($result, function($a, $b) {
    return strcmp($a["nom"], $b["nom"]);
});

$output = [
    "annee"           => $annee,
    "total_adhesions" => array_sum(array_column($result, "total_bateaux")),
    "adherents"       => array_values($result),
];

echo json_encode($output, JSON_PRETTY_PRINT | JSON_UNESCAPED_UNICODE) . "\n";