<?php 
header("BTCPAY-SIG: 2SYjD57nbzNrdXSQjTBUCD16c6NH");
session_start();
include '../Inc/db.inc.php';
$data = file_get_contents("php://input");
$name = "";
$data = json_decode($data, true);
if ($data['type'] == "InvoiceCreated") {
    $stmt = $pdo->query("SELECT * FROM payments_reseller WHERE invoiceID = '' ORDER BY id DESC LIMIT 1");
    while($row = $stmt->fetch()) {
        $name = $row['name'];
    }
    $insertStmt = $pdo->prepare("UPDATE payments_reseller SET invoiceID = ?, status = ? WHERE name = ? ORDER BY id DESC LIMIT 1");
    $insertStmt->execute([$data['invoiceId'], $data['type'], $name]); 
}

if ($data['type'] == "InvoiceSettled") {
    $allKeys = "";
    $stmt = $pdo->prepare('SELECT * FROM payments_reseller WHERE invoiceID = ? ORDER BY id DESC LIMIT 1');
    $stmt->execute([$data['invoiceId']]);
    $output = $stmt->fetch();
    $keyCount = $output["amount"];
    for($i = 0; $i < $keyCount; $i++) {
        $token = bin2hex(openssl_random_pseudo_bytes(10));
        $stmt = $pdo->query("INSERT INTO init_codes VALUES ('$token', '1month', '0')");
        $allKeys = $allKeys + "\n" + $token;
    }
    $user = $_SESSION['username'];
    $date = date("Y-m-d H:i:s");
    $dblogger = $pdo->query("INSERT INTO log_dashboard (username, type, date, hwid) VALUES ('$user', 'Generate-Code-Reseller', '$date', '0')");
    mail("captainjack.kr@gmail.com", "Key Purchase", $allKeys);
    $insertStmt = $pdo->prepare("UPDATE payments_reseller SET status = ?, hasReceivedKeys = ? WHERE name = ? ORDER BY id DESC LIMIT 1");
    $insertStmt->execute([$data['type'], true, $name]); 
}
?>