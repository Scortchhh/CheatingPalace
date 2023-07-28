<?php 
$headers =  getallheaders();
$validHeader = false;
foreach($headers as $key=>$val){
    $val = base64_decode($val);
    if ($val == "version-for-scripts") {
        $validHeader = true;
    }
} 

if($validHeader) {
    include '../Inc/db.inc.php';
    $type = htmlspecialchars($_GET['type']);
    $type = base64_decode($type);
    $script = htmlspecialchars($_GET['script']);
    $script = base64_decode($script);
    if ($type == "Official") {
        $stmt = $pdo->prepare('SELECT version FROM scripts WHERE script = ?');
        $stmt->execute([$script]);
        $output = $stmt->fetch();
        echo $output["version"];
    }
    if ($type == "Community") {
        // $stmt = $pdo->prepare('SELECT version FROM scripts_community WHERE script = ?');
        // $stmt->execute([$script]);
        // $output = $stmt->fetch();
        // echo $output["version"];
        echo 1;
    }
    if ($type == "VIP") {
        $stmt = $pdo->prepare('SELECT version FROM scripts_vip_key WHERE scriptname = ?');
        $stmt->execute([$script]);
        $output = $stmt->fetch();
        echo $output["version"];
    }
}
?>