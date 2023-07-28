
<?php
session_start();
if(isset($_POST['submit']))
{    
$changelog = "@everyone \n";
$changelog .= $_POST['changelog'];
 $file = rand(1000,100000)."-".$_FILES['file']['name'];
 $file_loc = $_FILES['file']['tmp_name'];
 $file_size = $_FILES['file']['size'];
 $file_type = $_FILES['file']['type'];
 if(isset($_POST['devcheck'])){
   $folder="../LOL/test/";
 }else{
   $folder="../LOL/prod/";
 }

  $uploadedFileExtension = pathinfo($file, PATHINFO_EXTENSION);
  $allowed = array('dll', 'exe');
  if (in_array($uploadedFileExtension, $allowed)) {
  
  // new file size in KB
  $new_size = $file_size/1024;  
  // new file size in KB
  
  // make file name in lower case
  $new_file_name = strtolower($file);
  // make file name in lower case
  $new_file_name = strstr($new_file_name, '-');
  $new_file_name = substr($new_file_name, 1);
  
  $json_data = array ('content'=>"$changelog");
  $make_json = json_encode($json_data);
  $curl = curl_init("https://discord.com/api/webhooks/1087108377131360367/_L3XQwX4PTO4WCWUXlNQzemGqUYHrdk-bWArVcQaYS4O10sdiGSANWOAIAxxI65qmyxI");
  curl_setopt($curl, CURLOPT_HTTPHEADER, array('Content-type: application/json'));
  curl_setopt($curl, CURLOPT_POST, 1);
  curl_setopt($curl, CURLOPT_POSTFIELDS, $make_json);
  //  curl_setopt( $ch, CURLOPT_FOLLOWLOCATION, 1);
  // curl_setopt( $ch, CURLOPT_HEADER, 0);
  // curl_setopt( $ch, CURLOPT_RETURNTRANSFER, 1);
  if(move_uploaded_file($file_loc,$folder.$new_file_name))
  {
      echo "file transfer completed";
      $user = $_SESSION['user'];
      $date = date("Y-m-d H:i:s");
      $dblogger = $pdo->query("INSERT INTO log_dashboard (username, type, date, hwid) VALUES ('$user', 'Upload-Core', '$date', '0')");
      if($_POST['changelog'] != null){
          echo curl_exec($curl);
      }
  }
  else
  {
      echo "something went wrong chief";
  } 
  }
}
?>