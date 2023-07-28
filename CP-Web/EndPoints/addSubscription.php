<?php 
ini_set('display_errors', 1);
ini_set('display_startup_errors', 1);
error_reporting(E_ALL);
$headers =  getallheaders();
$validHeader = false;
foreach($headers as $key=>$val){
    $val = base64_decode($val);
    if ($val == "add-subscription-by-key") {
        $validHeader = true;
    }
}

if($validHeader) {
    include '../Inc/db.inc.php';
    $hwid = htmlspecialchars($_GET['hwid']);
    $code = htmlspecialchars($_GET['code']);

    $hwid = base64_decode($hwid);
    $code = base64_decode($code);
    $getEndSubDate = $pdo->prepare("SELECT * FROM users_lol WHERE hwid = ?");
    $getEndSubDate->execute([$hwid]);

    $isValidCode = $pdo->prepare("SELECT * FROM init_codes WHERE code = ?");
    $isValidCode->execute([$code]);
    $isValidCodeOutput = $isValidCode->rowCount();
    if ($isValidCodeOutput > 0) {
        $subType = $isValidCode->fetchAll()[0]["subDuration"];
        $currentEndSubDate = $getEndSubDate->fetchAll()[0]["endSub"];
        $currentEndSubDate = date($currentEndSubDate);
        $endSubDate = "";
        if ($currentEndSubDate < date("Y-m-d h:i:s")) {
            if ($subType == "1month") {
                $date = new DateTime("+1 month");
                $endSubDate = $date;
            }
            if ($subType == "2weeks") {
                $date = new DateTime("+14 day");
                $endSubDate = $date;
            }
            if ($subType == "1week") {
                $date = new DateTime("+7 day");
                $endSubDate = $date;
            }
        } else {
            $newSubscriptionEndDate = new DateTime($currentEndSubDate);
            if ($subType == "1month") {
                $newSubscriptionEndDate->modify("+1 month");
                $endSubDate = $newSubscriptionEndDate;
            }
            if ($subType == "2weeks") {
                $newSubscriptionEndDate->modify("+14 day");
                $endSubDate = $newSubscriptionEndDate;
            }
            if ($subType == "1week") {
                $newSubscriptionEndDate->modify("+7 day");
                $endSubDate = $newSubscriptionEndDate;
            }
        }
        $stmt1 = $pdo->prepare("UPDATE users_lol SET endSub = ? WHERE hwid = ?");
        $stmt1->execute([$endSubDate->format("Y-m-d h:i:s"), $hwid]);
        $count = $stmt1->rowCount();
        if ($count == "0") {
            echo false;
        }
        else {
            $stmt1 = $pdo->prepare("DELETE FROM init_codes WHERE code = ?");
            $stmt1->execute([$code]);
            echo true;
        }
    }
    echo false;
}
?>