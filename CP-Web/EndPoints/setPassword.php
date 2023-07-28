<?php
$headers =  getallheaders();
$validHeader = false;
foreach($headers as $key=>$val){
    $val = base64_decode($val);
    if ($val == "set-password-field") {
        $validHeader = true;
    }
} 
if ($validHeader) {
    include '../Inc/db.inc.php';
    $hwid = htmlspecialchars($_GET['hwid']);
    $hwid = base64_decode($hwid);
    $password = htmlspecialchars($_GET['password']);
    $password = base64_decode($password);
    $stmt = $pdo->prepare('UPDATE users_lol SET password = ? WHERE hwid = ?');
    $stmt->execute([$password, $hwid]);
}
?>