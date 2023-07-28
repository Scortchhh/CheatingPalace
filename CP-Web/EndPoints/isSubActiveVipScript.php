<?php 
$headers =  getallheaders();
$validHeader = true;
foreach($headers as $key=>$val){
    $val = base64_decode($val);
    if ($val == "getting-user-data-check") {
        $validHeader = true;
    }
} 

if($validHeader) {
    include '../Inc/db.inc.php';
    $name = htmlspecialchars($_GET['name']);
    $name = base64_decode($name);
    $scriptName = htmlspecialchars($_GET['scriptName']);
    $scriptName = base64_decode($scriptName);
    $isLifetime = $pdo->query("SELECT * FROM users_lol WHERE `name` = '$name'")->fetch()["endSub"];
    // if(strpos($isLifetime, "2099") !== false){
    //     echo true;
    // } else {
    //     $stmt = $pdo->prepare('SELECT * FROM scripts_vip WHERE buyer = ? AND scriptName = ?');
    //     $stmt->execute([$name, $scriptName]);
    //     $output = $stmt->fetchAll();
    //     if(empty($output)) {
    //         $stmt3 = $pdo->prepare('SELECT * FROM scripts_vip WHERE scriptName = ? LIMIT 1');
    //         $stmt3->execute([$scriptName]);
    //         $output2 = $stmt3->fetchAll();
    //         $creator = $output2[0]["creator"];
            
    //         $today = date("Y-m-d");
    //         $today_dt = new DateTime($today);
    //         $endSub = $today_dt->add(new DateInterval('P1D'));
    //         $endSub = date_format($endSub, "Y-m-d h:i:s");

    //         $stmt2 = $pdo->prepare("INSERT INTO scripts_vip (scriptName, creator, buyer, endSub) VALUES(?, ?, ?, ?)");
    //         $stmt2->execute([$scriptName, $creator, $name, $endSub]);
    //         echo true;
    //     } else {
    //         $today = date("Y-m-d H:i:s");
    //         $date = $output[0]["endSub"];
    //         if($date >= $today) {
    //             echo true;
    //         } else {
    //             echo false;
    //         }
    //     }
    // }
    echo true;
}
?>