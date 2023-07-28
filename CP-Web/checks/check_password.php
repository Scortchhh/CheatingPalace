<?php 
include 'Elements/header.php';
include 'Inc/db.inc.php';
?>
<form method="post">
    <input type="text" name="pw">
    <button type="submit" name="submit">check</button>
</form>


<?php 
if(isset($_POST['submit'])){
    $pwd = $_POST['pw'];
    $hashedPwd = password_hash($pwd, PASSWORD_DEFAULT);
    echo $hashedPwd;
}
include 'Elements/footer.php';
?>