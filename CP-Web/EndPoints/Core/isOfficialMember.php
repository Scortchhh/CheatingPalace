<?php 
include '../../Inc/db.inc.php';
if(!empty($_POST['hwid'])) {
    // $hwid = urlencode($_POST['hwid']);
    // $hwid = str_replace("%3D", "=",$hwid);
    // $hwid = str_replace("%2F", "/",$hwid);
    // $hwid = str_replace("%2B", "+", $hwid);
    // $hwid = htmlspecialchars($_POST['hwid']);
    // $hwid = str_replace(" ", "+", $hwid);
    // $stmt = $pdo->prepare('SELECT * FROM users_lol WHERE hwid = ?');
    // $stmt->execute([$hwid]);
    // $output = $stmt->fetchAll()[0]["isOfficialMember"];
    echo json_encode(true);
}
?>