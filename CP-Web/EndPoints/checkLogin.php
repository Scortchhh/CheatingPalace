<?php
// ini_set('display_errors', 1);
// ini_set('display_startup_errors', 1);
// error_reporting(E_ALL); 
$headers =  getallheaders();
$validHeader = false;
foreach($headers as $key=>$val){
    $val = base64_decode($val);
    if ($val == "check-login-credentials") {
        $validHeader = true;
    }
} 
if($validHeader) {
    include '../Inc/db.inc.php';
    $username = base64_decode($_GET['username']);
    $username = htmlspecialchars($username);
    $pw = base64_decode($_GET['password']);
    $pw = htmlspecialchars($pw);
    $gpw = base64_decode($_GET['gpassword']);
    $gpw = htmlspecialchars($gpw);

    $correctGlobalPassword = false;

    $stmt2 = $pdo->prepare('SELECT * FROM patch_lol WHERE globalPassword = ?');
    $stmt2->execute([$gpw]);
    $output = $stmt2->fetchAll();
    if(!empty($output[0]["globalPassword"])) {
        if($gpw == $output[0]["globalPassword"]) {
            $correctGlobalPassword = true;
        }
    }

    $stmt = $pdo->prepare('SELECT * FROM users_lol WHERE `name` = :name');
    $stmt->execute(['name' => $username]);
    $user = $stmt->fetch();
    if($user < 1){
        echo "0";
    } else {
        if($user) {
            if(password_verify($pw, $user['password'])){
                if($correctGlobalPassword == true) {
                    $stmt3 = $pdo->prepare('SELECT * FROM log_hwid WHERE name = ? AND date >= NOW() - INTERVAL 30 DAY');
                    $stmt3->execute([$username]);
                    $canReset = $stmt3->rowCount();
                    if ($canReset == 0) {
                        echo "1";
                    } else {
                        echo "3";
                    }
                } else {
                    echo "2";
                }
            } else {
                echo "0";
            }
        }
    }
}
?>