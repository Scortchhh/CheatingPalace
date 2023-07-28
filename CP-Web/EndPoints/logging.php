<?php 
// ini_set('display_errors', 1);
// ini_set('display_startup_errors', 1);
// error_reporting(E_ALL);
$headers =  getallheaders();
$validHeader = false;
foreach($headers as $key=>$val){
    $val = base64_decode($val);
    if ($val == "validation-sending-to-db") {
        $validHeader = true;
    }
}
if($validHeader) {
    include '../Inc/db.inc.php';
    $status = htmlspecialchars($_GET['status']);
    $message = htmlspecialchars($_GET['message']);
    // $date = htmlspecialchars($_GET['date']);
    $hwid = htmlspecialchars($_GET['hwid']);
    $ip = htmlspecialchars($_GET['ip']);
    $accountName = htmlspecialchars($_GET['accountName']);
    $code = htmlspecialchars($_GET['code']);

    $status = base64_decode($status);
    $message = base64_decode($message);
    // $date = base64_decode($date);
    $date = new DateTime('now');
    $date = $date->format("Y-m-d h:i:s");
    $hwid = base64_decode($hwid);
    $accountName = base64_decode($accountName);
    $code = base64_decode($code);
    $ip = base64_decode($ip);
    if ($status == "injected" || $status == "declined" || $status == "nameIssue" || $status == "reset") {
        $stmt = $pdo->prepare("INSERT INTO `log_$status` (`status`, `message`, `date`, `hwid`, `adress`) VALUES(?, ?, ?, ?, ?)");
        $status = ucfirst($status);
        $stmt->execute([$status, $message, $date, $hwid, $ip]);
    }
    if ($status == "injected_scripts") {
        $stmt = $pdo->prepare("INSERT INTO `$status` (`date`, `hwid`, `accountName`, `scripts`) VALUES(?, ?, ?, ?)");
        $stmt->execute([$date, $hwid, $accountName, $message]);
    }
    if ($status == "success") {
        $stmt = $pdo->prepare("INSERT INTO `log_$status` (`message`, `date`, `code`, `hwid`, `discordToken`, `adress`) VALUES(?, ?, ?, ?, ?, ?)");
        $stmt->execute([$message, $date, $code, $hwid, "", $ip]);
    }
    if ($status == "hwid") {
        $stmt = $pdo->prepare("INSERT INTO `log_$status` (`name`, `message`, `date`, `hwid`, `adress`) VALUES(?, ?, ?, ?, ?)");
        $stmt->execute([$accountName, $message, $date, $hwid, $ip]);
    }

}
?>