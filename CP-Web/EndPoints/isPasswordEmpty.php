<?php
// ini_set('display_errors', 1);
// ini_set('display_startup_errors', 1);
// error_reporting(E_ALL); 
$headers =  getallheaders();
$validHeader = false;
foreach($headers as $key=>$val){
    $val = base64_decode($val);
    if ($val == "check-is-password-empty") {
        $validHeader = true;
    }
} 
if($validHeader) {
    include '../Inc/db.inc.php';
    $hwid = htmlspecialchars($_GET['hwid']);
    $hwid = base64_decode($hwid);
    $stmt = $pdo->prepare("SELECT * FROM users_lol WHERE hwid = ?");
    $stmt->execute([$hwid]);
    $output = $stmt->fetchAll();
    if(empty($output[0]["password"])) {
        echo true;
    }
    echo false;
}
?>