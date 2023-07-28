<?php
$headers =  getallheaders();
$validHeader = false;
foreach($headers as $key=>$val){
    $val = base64_decode($val);
    if ($val == "set-load-file-checks") {
        $validHeader = true;
    }
} 
if ($validHeader) {
    include '../Inc/db.inc.php';
    $hwid = htmlspecialchars($_GET['hwid']);
    $hwid = base64_decode($hwid);

    $fileName = htmlspecialchars($_GET['fileName']);
    $fileName = base64_decode($fileName);

    $stmt = $pdo->prepare("INSERT INTO load_file (hwid, filename) VALUES(?, ?)");
    $stmt->execute([$hwid, $fileName]);
}
?>