<?php 
include 'Elements/header.php';
include 'Inc/db.inc.php';
ini_set('display_errors', 1);
ini_set('display_startup_errors', 1);
error_reporting(E_ALL);
if($_SESSION['level'] != "Admin" && $_SESSION['level'] != "Dev" && $_SESSION['level'] != "CDev"){
    header('Location: control_panel.php');
}
$logged_in_user = $_SESSION['user'];
?>

<div class="container">
    <div class="row justify-content-center d-flex text-center">
        <form class="mt-2" method="post" action="Inc/process_vip_script_subscription.php">
        <?php 
            $hwid = htmlspecialchars($_POST['hwid_user']);
            $stmt = $pdo->query("SELECT * FROM users_lol WHERE hwid = '$hwid'");
            $user = $stmt->fetch();
            $username = $user['name'];

            $stmt1 = $pdo->query("SELECT * FROM scripts_vip_key WHERE author = '$logged_in_user'");
            if ($stmt1->rowCount() < 0) {
                echo "You have no active scripts";
                // return;
            }
        ?>
            <select class="form-control" name="scriptname">
            <?php 
            foreach($stmt1->fetchAll() as $index => $scripts) {
                echo '<option value="' . $scripts['scriptname'] . '">' . $scripts['scriptname'] . '</option>';
            }
            ?>
            </select>
            <?php 
                $stmt2 = $pdo->query("SELECT endSub FROM scripts_vip WHERE buyer = '$username' AND creator = '$logged_in_user'");
                $endSubScript = $stmt2->fetch()["endSub"];
                echo $endSubScript;
                echo '<input class="form-control mt-2" type="date" disabled value="'. date("Y-m-d", strtotime($endSubScript)) .'">';
                echo '<input class="form-control mt-2" name="newEndDate" type="date" value="'. date("Y-m-d", strtotime($endSubScript)) .'">';
            ?>
            <input type="text" hidden name="username" value="<?= $username ?>">
            <input type="text" hidden name="logged_in_user" value="<?= $logged_in_user ?>">
            <button class="btn btn-primary mt-2" type="submit" name="submit">Confirm</button>
        </form>
    </div>
</div>
<?php

include 'Elements/footer.php';
?>