<?php 
include 'Elements/header.php';
if(!$_SESSION['user']){
    header('Location: control_panel.html');
}
if($_SESSION['level'] != "Admin"){
  header("Location: control_panel.html");
}
?>
<div class="container">
<h1>Welcome to the new revamped upload panel, please use following name conventions: lol.dll & ext.exe </h1>
  <div class="pt-2 d-flex justify-content-center">
  <form method='post' action='Inc/upload.inc.php' enctype='multipart/form-data'>
      <textarea name='changelog' cols='100' rows='7'></textarea>
      <br><input style="border: 0.2px solid black" type='file' name='file' multiple />
      <input class="btn btn-warning" type='submit' value='Submit' name='submit' />
      <div class="form-check">
      <input class="form-check-input" type="checkbox" value="" name="devcheck" id="defaultCheck1">
      <label class="form-check-label" for="defaultCheck1">
        Tick if pushing to DEV build
      </label>
    </div>
    </form>
  </div>
</div>

<?php
include 'Elements/footer.php';
?>