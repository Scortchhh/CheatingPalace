<?php 
header("BTCPAY-SIG: 1DGkevb8zLwo4Fwyf7qroKKG1Pn");
include 'Inc/db.inc.php';
ini_set('display_errors', 1);
ini_set('display_startup_errors', 1);
error_reporting(E_ALL);
ini_set("allow_url_fopen", true);
$data = file_get_contents("php://input");
// var_dump($data);
foreach ($_POST as $key => $value) {
    echo $key.'='.$value.'<br />';
}
$name = "";
$data = json_decode($data, true);
$insertStmt = $pdo->prepare("INSERT INTO test (data) VALUES(?)");
if ($data == NULL) {
    $insertStmt->execute([print_r($_POST)]);
} else {
    $insertStmt->execute([$data]);
}
if ($data['type'] == "InvoiceCreated" || $data['type'] == "Processing") {
    $stmt = $pdo->query("SELECT * FROM payments WHERE invoiceID = '' ORDER BY id DESC LIMIT 1");
    while($row = $stmt->fetch()) {
        $name = $row['name'];
    }
    $insertStmt = $pdo->prepare("UPDATE payments SET invoiceID = ?, status = ? WHERE name = ? ORDER BY id DESC LIMIT 1");
    $insertStmt->execute([$data['invoiceId'], $data['type'], $name]);
}

if ($data['type'] == "InvoiceExpired" || $data['type'] == "Expired") {
    $stmt = $pdo->prepare("DELETE FROM payments WHERE invoiceID = ?");
    $stmt->execute([$data['invoiceId']]);
}

if ($data['type'] == "InvoiceSettled" || $data['type'] == "Settled") {
    $stmt = $pdo->prepare("SELECT * FROM payments WHERE invoiceID = ? ORDER BY id DESC LIMIT 1");
    $stmt->execute([$data['invoiceId']]);
    while($row = $stmt->fetch()) {
        if ($row['hasReceivedSub'] == "false") {
            $stmt2 = $pdo->prepare("SELECT * FROM users_lol WHERE name = ?");
            $stmt2->execute([$row['name']]);
            while($row2 = $stmt2->fetch()) {
                $endSub = $row2['endSub'];
                $today = date("Y-m-d");
                $today_dt = new DateTime($today);
                $expire_dt = new DateTime($endSub);
                $newSubEndDate = "";

                if ($expire_dt < $today_dt) { 
                    if ($row['subtype'] == 60) {
                        $newSubEndDate = $today_dt->add(new DateInterval('P30D'));
                    }
                    if ($row['subtype'] == 30) {
                        $newSubEndDate = $today_dt->add(new DateInterval('P14D'));
                    }
                    if ($row['subtype'] == 15) {
                        $newSubEndDate = $today_dt->add(new DateInterval('P7D'));
                    }
                }

                if ($expire_dt >= $today_dt) { 
                    if ($row['subtype'] == 60) {
                        $newSubEndDate = $expire_dt->add(new DateInterval('P30D'));
                    }
                    if ($row['subtype'] == 30) {
                        $newSubEndDate = $expire_dt->add(new DateInterval('P14D'));
                    }
                    if ($row['subtype'] == 15) {
                        $newSubEndDate = $expire_dt->add(new DateInterval('P7D'));
                    }
                }


                $newSubEndDate = date_format($newSubEndDate, "Y-m-d h:i:s");
                $updateSub = $pdo->prepare("UPDATE users_lol SET endSub = ? WHERE name = ?");
                $updateSub->execute([$newSubEndDate, $row['name']]);
                $receivedSubUpdate = $pdo->prepare("UPDATE payments SET hasReceivedSub = ?, status = ? WHERE invoiceID = ?");
                $receivedSubUpdate->execute(["true", $data['type'], $row['invoiceID']]);
            }
        }
    }
}
// $updateStmt = $pdo->query("UPDATE users_lol SET endSub = '$endDate' WHERE hwid = '$hwid'");
?>