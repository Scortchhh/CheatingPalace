<?php 
$headers =  getallheaders();
$validHeader = false;
foreach($headers as $key=>$val){
    $val = base64_decode($val);
    if ($val == "user-get-check") {
        $validHeader = true;
    }
} 

if($validHeader) {
    include '../Inc/db.inc.php';
    $hwid = htmlspecialchars($_GET['hwid']);
    $hwid = base64_decode($hwid);
    
    $stmt = $pdo->prepare('SELECT * FROM users_lol WHERE hwid = ?');
    $stmt->execute([$hwid]);
    $output = $stmt->fetchAll();
    echo json_encode($output);
}
?>