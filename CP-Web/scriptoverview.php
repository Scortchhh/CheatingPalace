<?php 
include 'Elements/header.php';
include 'Inc/db.inc.php';
ini_set('display_errors', 1);
ini_set('display_startup_errors', 1);
error_reporting(E_ALL);
if($_SESSION['level'] != "Admin"){
    header('Location: control_panel.php');
}
$dir    = './scripts_storage/';
$files1 = scandir($dir);
$index = 0;
?>
  <a href="https://cheatingpalace.com/download_all.php">
<button class="btn btn-primary" value="submit" name="submit">Download all</button>
</a>

<table class="table scriptsTable">
  <thead>
    <tr>
      <th scope="col">Scripts</th>
    </tr>
  </thead>
  <tbody>
  <?php 
    foreach($files1 as $script) {
        if ($script != "Community") {
          if ($index >= 2) {
            echo '    <tr>
            <th scope="row"><a href="http://cheatingpalace.com/scripts_storage/'. $script .'" download>'. $script .'</a></th>
          </tr>';
            // echo "<br>";
        }
        $index++;
        }
    }
  ?>
  </tbody>
</table>