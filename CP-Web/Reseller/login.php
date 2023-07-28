<?php 
ini_set('display_errors', 1);
ini_set('display_startup_errors', 1);
error_reporting(E_ALL);
?>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login Reseller</title>
</head>
<body>
    
<form action="" method="POST">
    <div class="navformfix">
    <div class="form-group">
        <div class="cols-sm-10">
            <div class="input-group">
                <span class="input-group-addon"><i class="fa fa-user fa" aria-hidden="true"></i></span>
                <input type="text" class="form-control loginbox" id="uid" name="uid" placeholder="Username/Email" autocomplete="on"/>
                <span class="input-group-addon"><i class="fa fa-lock fa-lg" aria-hidden="true"></i></span>
                <input type="password" class="form-control loginbox" name="pwd" id="pwd" placeholder="Password"/>
                <input type="number" class="form-control loginbox" name="keyamount" id="keyamount" placeholder="key amount"/>
                <button type="submit" name="submit" class="btn btn-primary">Login</button>
            </div>
        </div>
    </div>
</form>

</body>
</html>

<?php
session_start();
include '../Inc/db.inc.php';
if(isset($_POST['submit']) && isset($_POST['uid']) && isset($_POST['pwd'])){
    $uid = htmlspecialchars($_POST['uid']);
    $pwd = htmlspecialchars($_POST['pwd']);
    $keyamount = htmlspecialchars($_POST['keyamount']);
    //error handling
    if(empty($uid) || empty($pwd)){
        header("Location: login.php?login=failed");
        exit();
    } else {
        $stmt = $pdo->prepare('SELECT * FROM users_resellers WHERE username = :username');
        $stmt->execute(['username' => $uid]);
        $user = $stmt->fetch();
        if($user < 1){
            header("Location: login.php?login=failed");
            exit();
        } else {
            if($user && password_verify($pwd, $user['password'])){
                $_SESSION['username'] = $user['username'];
                $_SESSION['keyamount'] = $keyamount;
                header("Location: PaymentHandler.php");
                exit();
            } else {
                header("Location: login.php?login=failed");
                exit();
            }
        }
    }
}
?>