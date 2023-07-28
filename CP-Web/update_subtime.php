<?php 
include 'Elements/header.php';
include 'Inc/db.inc.php';
if($_SESSION['level'] != "Admin"){
    header('Location: control_panel.php');
}
?>

<div class="container">
    <div class="row justify-content-center d-flex text-center">
        <form class="mt-2" method="post">
        <?php 
            $hwid = urlencode($_GET['hwid']);
            $hwid = str_replace("%3D", "=",$hwid);
            $hwid = str_replace("%2F", "/",$hwid);
            $hwid = str_replace("%2B", "+", $hwid);
            $stmt = $pdo->query("SELECT * FROM users_lol WHERE hwid = '$hwid'");
            $user = $stmt->fetch();
            echo '<input class="form-control" type="text" disabled value="'. $user['name'] .'">';
            echo '<input class="form-control mt-2" type="text" disabled value="'. $user['hwid'] .'">';
            echo '<input class="form-control mt-2" type="date" disabled value="'. date("Y-m-d", strtotime($user['endSub'])) .'">';
            echo '<input class="form-control mt-2" name="newEndDate" type="date" value="'. date("Y-m-d", strtotime($user['endSub'])) .'">';
        ?>
            <button class="btn btn-primary mt-2" type="submit" name="submit">Change Sub Time</button>
        </form>
    </div>
</div>
<?php

if (isset($_POST['submit'])) {
    try{
        $endDate = $_POST['newEndDate'];
        $updateStmt = $pdo->query("UPDATE users_lol SET endSub = '$endDate' WHERE hwid = '$hwid'");
        $user = $_SESSION['user'];
        $date = date("Y-m-d H:i:s");
        $dblogger = $pdo->query("INSERT INTO log_dashboard (username, type, date, hwid) VALUES ('$user', 'Changed-Subscription', '$date', '$hwid')");
        header("location: overview.php");
    }catch(Exception $e){
        echo $e;
    }
}

include 'Elements/footer.php';
?>