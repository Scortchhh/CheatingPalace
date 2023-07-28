<?php 
include 'Elements/header.php';
include 'Inc/db.inc.php';
if(!$_SESSION['user']){
    header('Location: control_panel.html');
}
if($_SESSION['level'] != "Dev" && $_SESSION['level'] != "CDev" && $_SESSION['level'] != "Admin"){
  header("Location: control_panel.html");
}
$user = $_SESSION['user'];

$stmt = $pdo->query("SELECT * FROM users_lol ORDER BY name ASC");
$countStmt = $pdo->query("SELECT COUNT(hwid) FROM users_lol");
$countMembers = $countStmt->fetchColumn();
?>
<div class="container">
    <div class="row">
    <div class="col-md mt-2">
        <form method="post" action="manage_user_vip_scripts.php">
            <div class="text-center">
            <h3 class="mb-3">Manage Vip scripts subscriptions</h3>
            <br>
                <select class="form-control" name="hwid_user">
                <?php 
                    while($row = $stmt->fetch()){
                        echo '<option value="' . $row['hwid'] . '">' . $row['name'] . '</option>';
                    }
                ?>
                </select>
                <button type="submit" name="changeSubTime" class="btn btn-primary mt-2">Change Subscription Time</button>
            </div>
        </form>
    </div>
        <div class="col-md mt-2">
            <form method="post" enctype='multipart/form-data'>
                <div class="text-center">
                <h3>Type champion name with capital starting letter</h3>
                    <input class="form-control mb-2" type="text" name="scriptName" placeholder="Katarina">
                    <select id="selection" class="form-control mb-2" name="category">
                        <option value="Core">Core</option>
                        <option value="Champion">Champion</option>
                        <option value="Lib">Lib</option>
                        <option value="Vip">Vip</option>
                    </select>
                    <input id="key" class="form-control mb-2" type="text" name="key" placeholder="encryption key field: eg. abcdefgh12345">
                    <input class="form-control mb-2" type="text" name="version" placeholder="1">
                    <input style="border: 0.2px solid black" type='file' name='file[]' multiple />
                    <input class="btn btn-warning" type='submit' value='Add Script' name='addNewScript' />
                </div>
            </form>
        </div>
    </div>
</div>
<?php 

if (isset($_POST['addNewScript'])) {
    $countfiles = count($_FILES['file']['name']);
    $succes;
    for($i = 0; $i < $countfiles; $i++) {
        $file = rand(1000,100000)."-".$_FILES['file']['name'][$i];
        $file_loc = $_FILES['file']['tmp_name'][$i];
        $file_size = $_FILES['file']['size'][$i];
        $file_type = $_FILES['file']['type'][$i];
        $folder = "scripts_storage/";
        if ($_POST['category'] == "Lib") {
            $folder = "scripts_storage/Libs/";
        }
        if ($_POST['category'] == "Vip") {
            $folder = "scripts_storage/Vip/";
            $file_content = file_get_contents($_FILES["file"]["tmp_name"][0]);
        }
        $new_file_name = strstr($file, '-');
        $new_file_name = substr($new_file_name, 1);
        if(move_uploaded_file($file_loc,$folder.$new_file_name))
        {
            $succes++;
        }
    }
    if ($succes == $countfiles) {
        $script = $_POST['scriptName'];
        $category = $_POST['category'];
        $version = $_POST['version'];
        $username = $_SESSION['user'];
        $encryptionKey = $_POST['key'];
        if ($category != "Vip") {
            $count = $pdo->query("SELECT * FROM scripts WHERE script = '$script' AND type = '$category'")->rowCount();
            if ($count <= 0) {
                    $statement = $pdo->query("INSERT INTO scripts(script, type, version, creator) VALUES('$script', '$category', '1', '$username')");
                    $statement2 = $pdo->query("INSERT INTO scripts_rating(script_name, rating) VALUES('$script', '3')");
                    echo "Succesfully added script: " . $script;
            } else {
                echo "Succesfully updated script: " . $script;
                $versionstmt = $pdo->query("SELECT * FROM scripts WHERE script = '$script'");
                $versionDB = $versionstmt->fetch()['version'];
                $versionDB = $versionDB + 0.01;
                $statement = $pdo->query("UPDATE scripts SET version = '$versionDB' WHERE script = '$script' AND type = '$category'");
            }
        } else {
            $countVIP = $pdo->query("SELECT * FROM scripts_vip_key WHERE scriptname = '$script'")->rowCount();
            if ($countVIP <= 0) {
                $date = DateTime::createFromFormat('j-M-Y', '2-Jan-2099')->format("Y-m-d h:i:s");
                $statement = $pdo->query("INSERT INTO scripts_vip(scriptName, creator, buyer, endSub) VALUES('$script', '$username', '$username', '$date')");
                $statement2 = $pdo->query("INSERT INTO scripts_vip_key(scriptname, encryption_key, version, author) VALUES('$script', '$encryptionKey', '$version', '$username')");
                echo "Succesfully added VIP script: " . $script;
            } else {
                echo "Succesfully updated VIP script: " . $script;
                $versionstmt = $pdo->query("SELECT * FROM scripts_vip_key WHERE scriptname = '$script'");
                $versionDB = $versionstmt->fetch()['version'];
                $versionDB = $versionDB + 0.01;
                $statement = $pdo->query("UPDATE scripts_vip_key SET version = '$versionDB' WHERE scriptname = '$script'");
            }
        }
        $date = date("Y-m-d H:i:s");
        $dblogger = $pdo->query("INSERT INTO log_dashboard (username, type, date, hwid) VALUES ('$username', 'Upload-Script "." $category', '$date', '$script')");
    } else {
      echo "one or more files failed to upload";
    }
}

// if (isset($_POST['changeSubTime'])) {
//     try{
//         $user = $_POST['user'];
//         echo '<script>location.replace("manage_user_vip_scripts.php?hwid='.$user.'");</script>';
//     }catch(Exception $e){
//         echo $e;
//     }
// }
include 'Elements/footer.php';
?>

<script>
var selection = document.getElementById("selection");
var keyField = document.getElementById("key");
keyField.disabled = true;

selection.addEventListener("change", function(){
  //Update this to your logic...
  if(selection.value == "Vip"){
    keyField.disabled = false;
  } else {
      keyField.disabled = true;
  }
});
</script>