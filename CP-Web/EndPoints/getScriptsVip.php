<?php 
ini_set('display_errors', 1);
ini_set('display_startup_errors', 1);
error_reporting(E_ALL);
$headers =  getallheaders();
$validHeader = false;
foreach($headers as $key=>$val){
    $val = base64_decode($val);
    if ($val == "scripts-get-all-checks") {
        $validHeader = true;
    }
} 

// if($validHeader) {
//     include '../Inc/db.inc.php';
//     $pdo->query("SET GLOBAL sql_mode=(SELECT REPLACE(@@sql_mode,'ONLY_FULL_GROUP_BY',''))");
//     $username = htmlspecialchars($_GET['username']);
//     $username = base64_decode($username);
//     $isLifetime = $pdo->query("SELECT * FROM users_lol WHERE `name` = '$username'")->fetch()["endSub"];
//     if(strpos($isLifetime, "2099") !== false) {
//         $stmt = $pdo->query('SELECT * from scripts_vip GROUP BY scriptName');
//         $output = $stmt->fetchAll();
//         echo json_encode($output);
//     } else{
//         $date = date("Y-m-d H:i:s");
//         $stmt = $pdo->prepare('SELECT * FROM scripts_vip WHERE `buyer` = ? AND endSub >= ?');
//         $stmt->execute([$username, $date]);
//         $output = $stmt->fetchAll();
//         echo json_encode($output);
//     }
// }

$headers =  getallheaders();
$validHeader = false;
foreach($headers as $key=>$val){
    $val = base64_decode($val);
    if ($val == "scripts-get-all-checks") {
        $validHeader = true;
    }
} 

if($validHeader) {
    include '../Inc/db.inc.php';
    $username = htmlspecialchars($_GET['username']);
    $username = base64_decode($username);
    $pdo->query("SET GLOBAL sql_mode=(SELECT REPLACE(@@sql_mode,'ONLY_FULL_GROUP_BY',''))");
    $stmt = $pdo->query('SELECT * from scripts_vip GROUP BY scriptName');
    $output = $stmt->fetchAll();
    echo json_encode($output);
}

?>
