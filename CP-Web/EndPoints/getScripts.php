<?php 
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
    $type = htmlspecialchars($_GET['scriptType']);
    $type = base64_decode($type);
    $stmt = $pdo->prepare('SELECT * FROM scripts WHERE `type` = ? ORDER BY script');
    $stmt->execute([$type]);
    $output = $stmt->fetchAll();
    // echo json_encode($stmt->rowCount());
    echo json_encode($output);
}
?>