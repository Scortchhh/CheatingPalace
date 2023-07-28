<?php
session_start();
include 'db.inc.php';
if(isset($_POST['submit'])){

    $uid = $_POST['uid'];
    $pwd = $_POST['pwd'];
    //error handling
    if(empty($uid) || empty($pwd)){
        header("Location: ../control_panel.html?login=empty");
        exit();
    } else {
        $stmt = $pdo->prepare('SELECT * FROM users_dashboard WHERE username = :username');
        $stmt->execute(['username' => $uid]);
        $user = $stmt->fetch();
        if($user < 1){
            header("Location: ../control_panel.html?login=failed");
            exit();
        } else {
            if($user && password_verify($pwd, $user['password'])){
                $_SESSION['user'] = $user['username'];
                $_SESSION['level'] = $user['level'];
                header("Location: ../dashboard.php");
                exit();
            } else {
                header("Location: ../control_panel.html?login=failed");
                exit();
            }
        }
    }
} else {
    header("Location: ../index.php?login=failed");
    exit();
}