<?php 
$headers =  getallheaders();
$validHeader = false;
foreach($headers as $key=>$val){
    if ($val == "mainloader.exe") {
        $validHeader = true;
    }
}
if($validHeader) {
    $file = 'http://cheatingpalace.com/importantFiles/mainLoader.exe';
    chmod("mainLoader.exe", 0644);
    header('Content-Description: File Transfer');
    header('Content-Type: application/octet-stream');
    header('Content-Disposition: attachment; filename=' . basename($file));
    header('Content-Transfer-Encoding: binary');
    header('Expires: 0');
    header('Cache-Control: must-revalidate, post-check=0, pre-check=0');
    header('Pragma: public');
    // header('Content-Length: ' . filesize($file));
    ob_clean();
    flush();
    readfile($file);
    chmod("mainLoader.exe", 0600);
    exit;
}
exit;
?>