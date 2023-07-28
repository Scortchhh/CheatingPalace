<?php 
$headers =  getallheaders();
$validHeader = false;
foreach($headers as $key=>$val){
    $val = base64_decode($val);
    if ($val == "blacklisted-hwid-checks") {
        $validHeader = true;
    }
} 
if ($validHeader) {
    include '../Inc/db.inc.php';
    $hwid = htmlspecialchars($_GET['hwid']);
    $hwid = base64_decode($hwid);
    $stmt = $pdo->prepare('SELECT * FROM log_declined WHERE hwid = ? AND status = "Declined"');
    $stmt->execute([$hwid]);
    $output = $stmt->rowCount();
    if ($output > 0) {
        echo true;
    }
}
?>