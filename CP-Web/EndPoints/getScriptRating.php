<?php
// ini_set('display_errors', 1);
// ini_set('display_startup_errors', 1);
// error_reporting(E_ALL); 
$headers =  getallheaders();
$validHeader = false;
foreach($headers as $key=>$val){
    $val = base64_decode($val);
    if ($val == "script-get-rating") {
        $validHeader = true;
    }
} 
if($validHeader) {
    include '../Inc/db.inc.php';
    $finalTable = array();
    $allCoreScripts = $pdo->prepare("SELECT * FROM `scripts` WHERE type = 'Core' ORDER BY `scripts`.`script` ASC");
    $allCoreScripts->execute();
    while($script = $allCoreScripts->fetch(PDO::FETCH_ASSOC)){
        $stmt = $pdo->prepare('SELECT AVG(rating) AS rating FROM script_rating WHERE `script` = ?');
        $stmt->execute([$script['script']]);
        $output = $stmt->fetchAll();
        if (empty($output[0]["rating"])) {
            array_push($finalTable, 3);
        }else {
            $result = round($output[0]["rating"], 1, PHP_ROUND_HALF_UP);
            array_push($finalTable, $result);
        }
    }

    $allChampionScripts = $pdo->prepare("SELECT * FROM `scripts` WHERE type = 'Champion' ORDER BY `scripts`.`script` ASC");
    $allChampionScripts->execute();
    while($script = $allChampionScripts->fetch(PDO::FETCH_ASSOC)){
        $stmt = $pdo->prepare('SELECT AVG(rating) AS rating FROM script_rating WHERE `script` = ?');
        $stmt->execute([$script['script']]);
        $output = $stmt->fetchAll();
        if (empty($output[0]["rating"])) {
            array_push($finalTable, 3);
        }else {
            $result = round($output[0]["rating"], 1, PHP_ROUND_HALF_UP);
            array_push($finalTable, $result);
        }
    }
    echo json_encode($finalTable);
}
?>