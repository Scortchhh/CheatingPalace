<?php
$headers =  getallheaders();
$validHeader = false;
foreach($headers as $key=>$val){
    $val = base64_decode($val);
    if ($val == "set-LolPoints-Checks-in-place") {
        $validHeader = true;
    }
} 
if ($validHeader) {
    include '../Inc/db.inc.php';
    $hwid = htmlspecialchars($_GET['hwid']);
    $hwid = base64_decode($hwid);
    $count = htmlspecialchars($_GET['session']);
    $count = base64_decode($count);
    $stmt = $pdo->prepare('UPDATE users_lol SET lol_sessions = ? WHERE hwid = ?');
    $stmt->execute([$count, $hwid]);
}
?>