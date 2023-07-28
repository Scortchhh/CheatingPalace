<?php 
session_start();
if(!$_SESSION['user']){
    header('Location: control_panel.html');
}else{
  if(!$_SESSION['level']){
    header('Location: control_panel.html');
  } 
}
?>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <meta http-equiv = "Content-Type" content = "text/html; charset=utf-8" />
    <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
    <link rel="stylesheet" href="css/style.css">
    <title>Cheating Palace Dashboard</title>
</head>
<body>
<nav class="navbar navbar-expand-lg navbar-dark bg-warning">
  <a class="navbar-brand text-dark" href="dashboard.php">Cheating Palace</a>
  <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarNavAltMarkup" aria-controls="navbarNavAltMarkup" aria-expanded="false" aria-label="Toggle navigation">
    <span class="navbar-toggler-icon"></span>
  </button>
  <div class="collapse navbar-collapse" id="navbarNavAltMarkup">
    <div class="navbar-nav">
      <?php 
      if($_SESSION['level'] == "Support"){
        echo '
        <a class="nav-item nav-link text-dark" href="overview.php">Overview</a>';
      }
      if($_SESSION['level'] == "Dev" || $_SESSION['level'] == "CDev"){
        echo '<a class="nav-item nav-link text-dark" href="scriptscommunity.php">Script Upload</a>';
      }
      if($_SESSION['level'] == "Admin"){
        echo '
        <a class="nav-item nav-link text-dark" href="overview.php">Overview</a>
        <a class="nav-item nav-link text-dark" href="generate_code.php">Codes</a>
        <a class="nav-item nav-link text-dark" href="upload_core.php">Upload Core</a>
        <a class="nav-item nav-link text-dark" href="scriptmanager.php">Script Rotation</a>
        <a class="nav-item nav-link text-dark" href="script_performance.php">Script Performance</a>
        <a class="nav-item nav-link text-dark" href="scriptoverview.php">Script Overview</a>';
      }
      ?>
    </div>
  </div>
</nav>