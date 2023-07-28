<?php 
$headers =  getallheaders();
$validHeader = false;
foreach($headers as $key=>$val){
    $val = base64_decode($val);
    if ($val == "lolPatch-checks-for-validity") {
        $validHeader = true;
    }
} 

if($validHeader) {
    include '../Inc/db.inc.php';
    $stmt = $pdo->prepare('SELECT * FROM patch_lol');
    $stmt->execute();
    $output = $stmt->fetchAll();
    echo json_encode($output);
}
?>