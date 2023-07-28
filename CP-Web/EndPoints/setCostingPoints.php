<?php
$headers =  getallheaders();
$validHeader = false;
foreach($headers as $key=>$val){
    $val = base64_decode($val);
    if ($val == "costing-points-check-for-validility") {
        $validHeader = true;
    }
} 
if ($validHeader) {
    include '../Inc/db.inc.php';
    $hwid = htmlspecialchars($_GET['hwid']);
    $hwid = base64_decode($hwid);
    $stmt = $pdo->prepare('UPDATE users_lol SET costingPoints = "0" WHERE hwid = ?');
    $stmt->execute([$hwid]);
}
?>