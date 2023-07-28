<?php
ini_set('display_errors', 1);
ini_set('display_startup_errors', 1);
error_reporting(E_ALL);
session_start();
include '../Inc/db.inc.php';
if (!empty($_SESSION['username'])) {
    $keys = $_SESSION['keyamount'];
    $name = $_SESSION['username'];
    $totalOrderAmount = $keys * 250;
    $today = date("Y-m-d");
    // change this sql string before testing this
    $insertStmt = $pdo->prepare("INSERT INTO payments_reseller (name, invoiceID, amount, price, date, status, hasReceivedKeys) VALUES(?, ?, ?, ?, ?, ?, ?)");
    $insertStmt->execute([$name, "", $keys, $totalOrderAmount, $today, "", "false"]);
    ?>
    <!DOCTYPE html>
    <html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>payment</title>
    </head>
    <body>
    <script>if(!window.btcpay){    var head = document.getElementsByTagName('head')[0];   var script = document.createElement('script');   script.src='https://btcpay.pixeaim.com/modal/btcpay.js';   script.type = 'text/javascript';   head.append(script);}function onBTCPayFormSubmit(event){    var xhttp = new XMLHttpRequest();    xhttp.onreadystatechange = function() {        if (this.readyState == 4 && this.status == 200) {            if(this.status == 200 && this.responseText){                var response = JSON.parse(this.responseText);                window.btcpay.showInvoice(response.invoiceId);            }        }    };    xhttp.open("POST", event.target.getAttribute('action'), true);    xhttp.send(new FormData( event.target ));}</script><style type="text/css"> .btcpay-form { display: inline-flex; align-items: center; justify-content: center; } .btcpay-form--inline { flex-direction: row; } .btcpay-form--block { flex-direction: column; } .btcpay-form--inline .submit { margin-left: 15px; } .btcpay-form--block select { margin-bottom: 10px; } .btcpay-form .btcpay-custom-container{ text-align: center; }.btcpay-custom { display: flex; align-items: center; justify-content: center; } .btcpay-form .plus-minus { cursor:pointer; font-size:25px; line-height: 25px; background: #DFE0E1; height: 30px; width: 45px; border:none; border-radius: 60px; margin: auto 5px; display: inline-flex; justify-content: center; } .btcpay-form select { -moz-appearance: none; -webkit-appearance: none; appearance: none; color: currentColor; background: transparent; border:1px solid transparent; display: block; padding: 1px; margin-left: auto; margin-right: auto; font-size: 11px; cursor: pointer; } .btcpay-form select:hover { border-color: #ccc; } #btcpay-input-price { -moz-appearance: none; -webkit-appearance: none; border: none; box-shadow: none; text-align: center; font-size: 25px; margin: auto; border-radius: 5px; line-height: 35px; background: #fff; } #btcpay-input-price::-webkit-outer-spin-button, #btcpay-input-price::-webkit-inner-spin-button { -webkit-appearance: none; margin: 0; } </style>
        <h1>Welcome <?= $name ?></h1>
        <h3>Keys you want to buy: <?= $keys ?>
        </h3>
        <form method="POST"  onsubmit="onBTCPayFormSubmit(event);return false"  action="https://btcpay.pixeaim.com/api/v1/invoices" class="btcpay-form btcpay-form--block">
            <input type="hidden" name="storeId" value="4oqkmkQG7aeCSp1CA9L7zRrRtww3engVBwezpCCJEVHC" />
            <input type="hidden" name="jsonResponse" value="true" />
            <input type="hidden" name="browserRedirect" value="http://cheatingpalace.com/Reseller/login.php" />
            <input type="hidden" name="price" value="<?= $totalOrderAmount?>" />
            <!-- <input type="hidden" name="loaderName" value="<?= $_POST['name'] ?>"> -->
            <input type="hidden" name="currency" value="EUR" />
            <input type="image" class="submit" name="submit" src="https://btcpay.pixeaim.com/img/paybutton/pay.svg" style="width:209px" alt="Pay with BtcPay, Self-Hosted Bitcoin Payment Processor">
        </form>  
    </body>
    </html>
<?php
} else {
    header("Location: payment.php");
}
?>