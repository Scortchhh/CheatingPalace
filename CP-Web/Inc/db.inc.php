<?php
$host = '149.210.177.126';
$db   = 'CheatingPalace';
$user = 'CPSuperUser';
$pass = '!@#$CheatingPalaceWillNeverStop2023%^&*';
$charset = 'utf8mb4';

$dsn = "mysql:host=$host;dbname=$db;charset=$charset";
$options = [
    PDO::ATTR_ERRMODE            => PDO::ERRMODE_EXCEPTION,
    PDO::ATTR_DEFAULT_FETCH_MODE => PDO::FETCH_ASSOC,
    PDO::ATTR_EMULATE_PREPARES   => false,
];
try {
     $pdo = new PDO($dsn, $user, $pass, $options);
} catch (\PDOException $e) {
     echo "Shits fucked\n$e->getMessage()\n$e->getCode()";
     throw new \PDOException($e->getMessage(), (int)$e->getCode());
}
?>