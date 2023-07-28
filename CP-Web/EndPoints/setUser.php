<?php 
// ini_set('display_errors', 1);
// ini_set('display_startup_errors', 1);
// error_reporting(E_ALL);
$headers =  getallheaders();
$validHeader = false;
foreach($headers as $key=>$val){
    $val = base64_decode($val);
    if ($val == "creation-of-user-to-db") {
        $validHeader = true;
    }
}

if($validHeader) {
    include '../Inc/db.inc.php';
    $name = htmlspecialchars($_GET['name']);
    $password = htmlspecialchars($_GET['password']);
    $hwid = htmlspecialchars($_GET['hwid']);
    $ip = htmlspecialchars($_GET['ip']);
    $code = htmlspecialchars($_GET['code']);

    $name = base64_decode($name);
    $password = base64_decode($password);
    $hwid = base64_decode($hwid);
    $ip = base64_decode($ip);
    $code = base64_decode($code);
    $isValidName = $pdo->prepare("SELECT * FROM users_lol WHERE name = ?");
    $isValidName->execute([$name]);
    $isValidNameOutput = $isValidName->rowCount();
    $DoesHwidExist = $pdo->prepare("SELECT * FROM users_lol WHERE hwid = ?");
    $DoesHwidExist->execute([$hwid]);
    $DoesHwidExistOutput = $DoesHwidExist->rowCount();
    $userAlreadyExists = $pdo->prepare("SELECT * FROM users_lol WHERE code = ?");
    $userAlreadyExists->execute([$code]);
    $userAlreadyExistsOutput = $userAlreadyExists->fetchAll();
    if ($userAlreadyExistsOutput[0]["hwid"] == "") {
        if ($isValidNameOutput > 0 || $DoesHwidExistOutput > 0) {
            $today = new DateTime('now');
            $today = $today->format("Y-m-d h:i:s");
            $stmt = $pdo->prepare("INSERT INTO log_declined (status, message, date, hwid, adress) VALUES(?, ?, ?, ?, ?)");
            $stmt->execute(["Name/HWID already locked", $name, $today, $hwid, $ip]);
            echo false;
        } else {
            $stmt1 = $pdo->prepare("UPDATE users_lol SET name = ?, password = ?, hwid = ?, regIP = ?, lastIP = ? WHERE code = ?");
            $stmt1->execute([$name, $password, $hwid, $ip, $ip, $code]);
            $count = $stmt1->rowCount();
            if ($count == "0") {
                echo false;
            }
            else {
                echo true;
            }
        }
    }
    echo false;
}
?>