<?php 
include 'Elements/header.php';
include 'Inc/db.inc.php';
if($_SESSION['level'] != "Admin" && $_SESSION['level'] != "Support"){
  header('Location: dashboard.php');
}
$stmt = $pdo->query("SELECT * FROM users_lol ORDER BY endSub DESC");
$regLogInjected = $pdo->query("SELECT * FROM log_injected");
$regLogDeclined = $pdo->query("SELECT * FROM log_declined");

// if(isset($_POST['delete'])) {
//   $hwid = urlencode($_GET['hwid']);
//   $hwid = str_replace("%3D", "=",$hwid);
//   $hwid = str_replace("%2F", "/",$hwid);
//   $hwid = str_replace("%2B", "+", $hwid);
//   if ($_SESSION['level'] == "Support") {
//     $user = $_SESSION['user'];
//     $date = date("Y-m-d H:i:s");
//     $dblogger = $pdo->query("INSERT INTO log_dashboard (username, type, date, hwid) VALUES ('$user', 'HWID-Removal', '$date', '$hwid')");
//   }
//   $deletestmt = $pdo->prepare("DELETE FROM log_declined WHERE hwid = ?");
//   $deletestmt->execute([$hwid]);
//   header('Location: overview.php');
// }

if ($_SESSION['level'] == "Admin") {
  echo '<div onload="load()" class="wrapper">
  <!-- Sidebar -->
  <nav id="sidebar">
      <div class="sidebar-header">
      <h4 class="text-body ml-2">Please select one of the following</h4>
      </div>
  
      <ul class="list-unstyled components">
          <li>
              <a href="#" onclick="setLol()">LOL Users</a>
          </li>
          <li>
            <a href="#" onclick="setReglogDeclined()">Reglog Declined</a>
          </li>
      </ul>
  </nav>
  </div>';
}

// if ($_SESSION['level'] == "Support") {
//   echo '<div class="wrapper">
//   <!-- Sidebar -->
//   <nav id="sidebar">
//       <div class="sidebar-header">
//       <h4 class="text-body ml-2">Please select one of the following</h4>
//       </div>
  
//       <ul class="list-unstyled components">
//           <li>
//             <a href="#" onclick="setReglogDeclined()">Reglog Declined</a>
//           </li>
//       </ul>
//   </nav>
//   </div>';
// }

if($_SESSION['level'] == "Admin"){
  echo '<div class="container">';
  echo '<table class="table pt-2" id="lolUsers">
  <thead>
    <tr>
      <th scope="col">ID</th>
      <th scope="col">Name</th>
      <th scope="col">HWID</th>
      <th scope="col">Start sub</th>
      <th scope="col">End sub</th>
      <th scope="col">Last played</th>
    </tr>
  </thead>';
  while($row = $stmt->fetch()){
      echo '<tbody>
          <tr>
            <td>'. $row['id'] .'</td>
            <td><a href="customer.php?hwid='. urlencode($row['hwid']) .'">'. $row['name'] .'</a></td>
            <td>'. $row['hwid'] .'</td>
            <td>'. $row['startSub'] .'</td>
            <td>'. $row['endSub'] .'</td>
            <td>'. $row['lastPlayed'] .'</td>
          </tr>
        </tbody>';
  }
  echo '</table>
  </div>';
  
  echo '<div class="container">';
  echo '<table class="table pt-2" id="regDeclined">
  <thead>
    <tr>
    <th scope="col">ID</th>
    <th scope="col">Adress</th>
    <th scope="col">Status</th>
    <th scope="col">Date</th>
    <th scope="col">HWID</th>
    <th scope="col">Remove</th>
    </tr>
  </thead>';
  while($regDeclinedRow = $regLogDeclined->fetch()){
      echo '<tbody>
          <tr>
          <td>'. $regDeclinedRow['id'] .'</td>
          <td>'. $regDeclinedRow['adress'] .'</td>
          <td>'. $regDeclinedRow['status'] .'</td>
          <td>'. $regDeclinedRow['date'] .'</td>
          <td>'. $regDeclinedRow['hwid'] .'</td>
          <form action="overview.php?hwid='. $regDeclinedRow['hwid'] .'" method="post">
            <td><button class="btn btn-warning" type="submit" value="submit" name="delete">Remove</button></td>
          </form>
          </tr>
        </tbody>';
  }
  echo '</table>
  </div>';
}

// if ($_SESSION['level'] == "Support") {
//   echo '<div class="container">';
//   echo '<table class="table pt-2" id="regDeclined">
//   <thead>
//     <tr>
//     <th scope="col">ID</th>
//     <th scope="col">Adress</th>
//     <th scope="col">Status</th>
//     <th scope="col">Date</th>
//     <th scope="col">Remove</th>
//     </tr>
//   </thead>';
//   while($regDeclinedRow = $regLogDeclined->fetch()){
//       echo '<tbody>
//           <tr>
//           <td>'. $regDeclinedRow['id'] .'</td>
//           <td>'. $regDeclinedRow['adress'] .'</td>
//           <td>'. $regDeclinedRow['status'] .'</td>
//           <td>'. $regDeclinedRow['date'] .'</td>
//           <form action="overview.php?hwid='. $regDeclinedRow['hwid'] .'" method="post">
//             <td><button class="btn btn-warning" type="submit" value="submit" name="delete">Remove</button></td>
//           </form>
//           </tr>
//         </tbody>';
//   }
//   echo '</table>
//   </div>';
// }

?>
</div>
<script>
<?php 
  if ($_SESSION['level'] == "Support") {
    ?>
      setReglogDeclined()
    <?php
  }
?>
  function setLol(){
    document.getElementById("lolUsers").style.display = "inline";
    document.getElementById("regDeclined").style.display = "none";
  }

  function setReglogDeclined(){
    <?php 
      if ($_SESSION['level'] == "Admin") {
        ?>
        document.getElementById("lolUsers").style.display = "none";
      <?php 
      }
      ?>
    document.getElementById("regDeclined").style.display = "inline";
  }
</script>
<?php 
include 'Elements/footer.php';
?>