<?php 
include '../../Inc/db.inc.php';
if(!empty($_POST['hwid'])) {
    $hwid = urlencode($_POST['hwid']);
    $hwid = str_replace("%3D", "=",$hwid);
    $hwid = str_replace("%2F", "/",$hwid);
    $hwid = str_replace("%2B", "+", $hwid);
    $hwid = htmlspecialchars($_POST['hwid']);
    $hwid = str_replace(" ", "+", $hwid);
    $stmt = $pdo->prepare('SELECT * FROM users_lol WHERE hwid = ?');
    $stmt->execute([$hwid]);
    $output = $stmt->fetchAll();

    $stmt1 = $pdo->prepare('SELECT * FROM load_file WHERE hwid = ? ORDER BY id DESC LIMIT 1');
    $stmt1->execute([$hwid]);
    $output1 = $stmt1->fetchAll()[0]["filename"];
    $output[0]["key"] = $output1;
    echo json_encode($output);

    if($hwid != "CohqzgAZw9SKVdiayLHBss4=") {
        $stmt2 = $pdo->prepare("DELETE FROM load_file WHERE hwid = ?");
        $stmt2->execute([$hwid]);
    }
}
?>