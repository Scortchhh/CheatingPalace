<?php
$headers =  getallheaders();
$validHeader = false;
foreach($headers as $key=>$val){
    $val = base64_decode($val);
    if ($val == "set-hwid-for-user") {
        $validHeader = true;
    }
} 
if ($validHeader) {
    include '../Inc/db.inc.php';
    $hwid = htmlspecialchars($_GET['hwid']);
    $hwid = base64_decode($hwid);
    $username = htmlspecialchars($_GET['username']);
    $username = base64_decode($username);
    $stmt = $pdo->prepare('UPDATE users_lol SET hwid = ? WHERE name = ?');
    $stmt->execute([$hwid, $username]);
    if($stmt->rowCount() > 0) {
        echo true;
    } else {
        echo $hwid;
        echo $username;
        echo false;
    }
}
?>