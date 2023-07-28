<?php 
include '../../Inc/db.inc.php';
if(!empty($_POST['hwid']) && !empty($_POST['scriptname'])) {
    $hwid = urlencode($_POST['hwid']);
    $hwid = str_replace("%3D", "=",$hwid);
    $hwid = str_replace("%2F", "/",$hwid);
    $hwid = str_replace("%2B", "+", $hwid);
    $hwid = htmlspecialchars($_POST['hwid']);
    $hwid = str_replace(" ", "+", $hwid);

    $scriptname = urlencode($_POST['scriptname']);
    $scriptname = htmlspecialchars($_POST['scriptname']);

    $stmt = $pdo->prepare('SELECT * FROM users_lol WHERE hwid = ?');
    $stmt->execute([$hwid]);
    $username = $stmt->fetchAll()[0]["name"];
    $stmt1 = $pdo->prepare('SELECT * FROM scripts_vip WHERE buyer = ?');
    $stmt1->execute([$username]);
    $endSub = $stmt1->fetchAll()[0]["endSub"];
    $date = date("Y-m-d H:i:s");
    $isLifetime = $pdo->query("SELECT * FROM users_lol WHERE `name` = '$username'")->fetch()["endSub"];
    // if(strpos($isLifetime, "2099") !== false){
    //     $stmt2 = $pdo->prepare('SELECT * FROM scripts_vip_key WHERE scriptname = ?');
    //     $stmt2->execute([$scriptname]);
    //     $output = $stmt2->fetchAll();
    //     echo json_encode($output);
    // } else {
    //     if ($endSub >= $date) {
    //         $stmt2 = $pdo->prepare('SELECT * FROM scripts_vip_key WHERE scriptname = ?');
    //         $stmt2->execute([$scriptname]);
    //         $output = $stmt2->fetchAll();
    //         echo json_encode($output);
    //     }
    // }
    $stmt2 = $pdo->prepare('SELECT * FROM scripts_vip_key WHERE scriptname = ?');
    $stmt2->execute([$scriptname]);
    $output = $stmt2->fetchAll();
    echo json_encode($output);
}
?>