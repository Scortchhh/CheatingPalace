<?php
$headers =  getallheaders();
$validHeader = false;
foreach($headers as $key=>$val){
    $val = base64_decode($val);
    if ($val == "set-script-rating") {
        $validHeader = true;
    }
} 
if ($validHeader) {
    include '../Inc/db.inc.php';
    $scriptName = htmlspecialchars($_GET['scriptName']);
    $scriptName = base64_decode($scriptName);
    $rating = htmlspecialchars($_GET['rating']);
    $rating = base64_decode($rating);
    $stmt = $pdo->prepare('INSERT INTO script_rating (script, rating) VALUES(?, ?)');
    $stmt->execute([$scriptName, $rating]);
}
?>