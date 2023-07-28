<?php 
ini_set('display_errors', 1);
ini_set('display_startup_errors', 1);
error_reporting(E_ALL);
include 'db.inc.php';
if (isset($_POST['submit'])) {
    try{
        $username = htmlspecialchars($_POST['username']);
        $logged_in_user = htmlspecialchars($_POST['logged_in_user']);
        $script = htmlspecialchars($_POST['scriptname']);
        $endDate = $_POST['newEndDate'];
        $checkHasSub = $pdo->query("SELECT * FROM scripts_vip WHERE buyer = '$username' AND creator = '$logged_in_user' and scriptName = '$script'")->rowCount();
        // echo "Has Sub: " . $checkHasSub;
        // echo "logged in as: " . $logged_in_user;
        // echo "user to be adjusted: " . $username;
        // echo "new date: " . $endDate;
        if($checkHasSub > 0) {
            $updateStmt = $pdo->query("UPDATE scripts_vip SET endSub = '$endDate' WHERE buyer = '$username' and scriptName = '$script'");
            $date = date("Y-m-d H:i:s");
            $dblogger = $pdo->query("INSERT INTO log_dashboard (username, type, date, hwid) VALUES ('$logged_in_user', 'Changed-Subscription-VIP', '$date', '$username')");
            header("location: ../scriptscommunity.php");
        } else {
            $date = date("Y-m-d H:i:s");
            $statement = $pdo->query("INSERT INTO scripts_vip(scriptName, creator, buyer, endSub) VALUES('$script', '$logged_in_user', '$username', '$endDate')");
            $dblogger = $pdo->query("INSERT INTO log_dashboard (username, type, date, hwid) VALUES ('$logged_in_user', 'Changed-Subscription-VIP', '$date', '$username')");
            header("location: ../scriptscommunity.php");
        }
    }catch(Exception $e){
        echo $e;
    }
}
?>