<?php 
$headers =  getallheaders();
$validHeader = false;
foreach($headers as $key=>$val){
    $val = base64_decode($val);
    if ($val == "ipcheckup-lol-signup") {
        $validHeader = true;
    }
} 
if ($validHeader) {
    include '../Inc/db.inc.php';
    $adress = htmlspecialchars($_GET['adress']);
    $adress = base64_decode($adress);
    $stmt = $pdo->prepare('SELECT * FROM checkip_lol WHERE adress = ?');
    $stmt->execute([$adress]);
    $output = $stmt->fetchAll();
    echo json_encode($output);
}
?>