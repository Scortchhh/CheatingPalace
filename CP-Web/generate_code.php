<?php 
include 'Elements/header.php';
include 'Inc/db.inc.php';
if($_SESSION['level'] != "Admin"){
    header('Location: dashboard.php');
}
echo '<h1>Generate codes for the sellix webstore</h1>';
echo '<form  method="post">
<select name="subDuration" class="form-control mb-2">
    <option value="1month">1 Month</option>
    <option value="2week">2 Weeks</option>
    <option value="1week">1 Week</option>
</select>
<select name="paymentMethod" class="form-control mb-2">
    <option value="BTC">BTC</option>
    <option value="PAYPAL">Paypal</option>
</select>
<input name="amount" type="number" class="form-control" placeholder="Amount of keys to generate">
<div class="form-group form-check ml-2">
<input name="zoomhack" type="checkbox" class="form-check-input">
<label class="form-check-label" for="exampleCheck1">Zoomhack only keys</label>
</div>
<button class="btn btn-primary mt-2" type="submit" name="generateCode">Generate code</button>
<button class="btn btn-primary mt-2" type="submit" name="deleteCodes">Delete all codes</button>
</form>';

if(isset($_POST['generateCode'])){
    try{
        $subDuration = $_POST['subDuration'];
        $paymentMethod = $_POST['paymentMethod'];
        $amount = $_POST['amount'];
        $user = $_SESSION['user'];
        $date = date("Y-m-d H:i:s");
        if (isset($_POST['zoomhack'])) {
            for ($i = 0; $i < $amount; $i++) {
                $token = bin2hex(openssl_random_pseudo_bytes(20));
                if ($paymentMethod == "PAYPAL") {
                    $token = "P_" . $token;
                }
                $token = $token . "_Z";
                $stmt = $pdo->query("INSERT INTO init_codes VALUES (null,'$token', '$subDuration')");
            }
            $dblogger = $pdo->query("INSERT INTO log_dashboard (username, type, date, hwid) VALUES ('$user', 'Generated: $amount Codes', '$date', '0')");
        } else {
            for ($i = 0; $i < $amount; $i++) {
                $token = bin2hex(openssl_random_pseudo_bytes(20));
                if ($paymentMethod == "PAYPAL") {
                    $token = "P_" . $token;
                }
                $stmt = $pdo->query("INSERT INTO init_codes VALUES (null,'$token', '$subDuration')");
            }
            $dblogger = $pdo->query("INSERT INTO log_dashboard (username, type, date, hwid) VALUES ('$user', 'Generated: $amount Codes', '$date', '0')");
        }
    }catch(PDOException $e){
        echo $e;
    }
}

if(isset($_POST['deleteCodes'])){
    $stmtdel = $pdo->query("DELETE FROM `init_codes`");
    $stmtdel->execute();
    $user = $_SESSION['user'];
    $date = date("Y-m-d H:i:s");
    $dblogger = $pdo->query("INSERT INTO log_dashboard (username, type, date, hwid) VALUES ('$user', 'Delete-Code', '$date', '0')");
}

$stmt = $pdo->query("SELECT * FROM `init_codes`");
$stmt1 = $pdo->query("SELECT * FROM `init_codes`");
$stmt2 = $pdo->query("SELECT * FROM `init_codes`");
$stmt3 = $pdo->query("SELECT * FROM `init_codes`");
$stmt4 = $pdo->query("SELECT * FROM `init_codes`");
$stmt5 = $pdo->query("SELECT * FROM `init_codes`");
$stmt6 = $pdo->query("SELECT * FROM `init_codes`");
$stmt7 = $pdo->query("SELECT * FROM `init_codes`");
$stmt8 = $pdo->query("SELECT * FROM `init_codes`");
$stmt9 = $pdo->query("SELECT * FROM `init_codes`");
$stmt10 = $pdo->query("SELECT * FROM `init_codes`");
$stmt11 = $pdo->query("SELECT * FROM `init_codes`");

echo '<div class="ml-5 mr-5">
<h1>Paypal keys below</h1>
<div class="row">
  <div class="col-sm">
  <h3>1 Month subscriptions:</h3>
    ';while($row = $stmt->fetch()){
        if ($row["subDuration"] == "1month") {
            if(!str_contains($row["code"], "_Z")) {
                if(str_contains($row["code"], "P_")) {
                    echo $row["code"] . "<br>";
                }
            }
        }
    }
    echo '
  </div>
  <div class="col-sm">
  <h3>2 Weeks subscriptions:</h3>
    ';while($row = $stmt1->fetch()){
        if ($row["subDuration"] == "2week") {
            if(!str_contains($row["code"], "_Z")) {
                if(str_contains($row["code"], "P_")) {
                    echo $row["code"] . "<br>";
                }
            }
        }
    }
    echo'
  </div>
  <div class="col-sm">
  <h3>1 Week subscriptions:</h3>
  ';while($row = $stmt2->fetch()){
    if ($row["subDuration"] == "1week") {
        if(!str_contains($row["code"], "_Z")) {
            if(str_contains($row["code"], "P_")) {
                echo $row["code"] . "<br>";
            }
        }
    }
}
echo'
  </div>
</div>
</div>';

echo '<div class="ml-5 mr-5">
<h1>BTC keys below</h1>
<div class="row">
  <div class="col-sm">
  <h3>1 Month subscriptions:</h3>
    ';while($row = $stmt3->fetch()){
        if ($row["subDuration"] == "1month") {
            if(!str_contains($row["code"], "_Z")) {
                if(!str_contains($row["code"], "P_")) {
                    echo $row["code"] . "<br>";
                }
            }
        }
    }
    echo '
  </div>
  <div class="col-sm">
  <h3>2 Weeks subscriptions:</h3>
    ';while($row = $stmt4->fetch()){
        if ($row["subDuration"] == "2week") {
            if(!str_contains($row["code"], "_Z")) {
                if(!str_contains($row["code"], "P_")) {
                    echo $row["code"] . "<br>";
                }
            }
        }
    }
    echo'
  </div>
  <div class="col-sm">
  <h3>1 Week subscriptions:</h3>
  ';while($row = $stmt5->fetch()){
    if ($row["subDuration"] == "1week") {
        if(!str_contains($row["code"], "_Z")) {
            if(!str_contains($row["code"], "P_")) {
                echo $row["code"] . "<br>";
            }
        }
    }
}
echo'
  </div>
</div>
</div>';

echo '<div class="ml-5 mr-5">
<h1>Zoomhack Paypal keys below</h1>
<div class="row">
  <div class="col-sm">
  <h3>1 Month subscriptions:</h3>
    ';while($row = $stmt6->fetch()){
        if ($row["subDuration"] == "1month") {
            if(str_contains($row["code"], "_Z")) {
                if(str_contains($row["code"], "P_")) {
                    echo $row["code"] . "<br>";
                }
            }
        }
    }
    echo '
  </div>
  <div class="col-sm">
  <h3>2 Weeks subscriptions:</h3>
    ';while($row = $stmt7->fetch()){
        if ($row["subDuration"] == "2week") {
            if(str_contains($row["code"], "_Z")) {
                if(str_contains($row["code"], "P_")) {
                    echo $row["code"] . "<br>";
                }
            }
        }
    }
    echo'
  </div>
  <div class="col-sm">
  <h3>1 Week subscriptions:</h3>
  ';while($row = $stmt8->fetch()){
    if ($row["subDuration"] == "1week") {
        if(str_contains($row["code"], "_Z")) {
            if(str_contains($row["code"], "P_")) {
                echo $row["code"] . "<br>";
            }
        }
    }
}
echo'
  </div>
</div>
</div>';

echo '<div class="ml-5 mr-5">
<h1>Zoomhack BTC keys below</h1>
<div class="row">
  <div class="col-sm">
  <h3>1 Month subscriptions:</h3>
    ';while($row = $stmt9->fetch()){
        if ($row["subDuration"] == "1month") {
            if(str_contains($row["code"], "_Z")) {
                if(!str_contains($row["code"], "P_")) {
                    echo $row["code"] . "<br>";
                }
            }
        }
    }
    echo '
  </div>
  <div class="col-sm">
  <h3>2 Weeks subscriptions:</h3>
    ';while($row = $stmt10->fetch()){
        if ($row["subDuration"] == "2week") {
            if(str_contains($row["code"], "_Z")) {
                if(!str_contains($row["code"], "P_")) {
                    echo $row["code"] . "<br>";
                }
            }
        }
    }
    echo'
  </div>
  <div class="col-sm">
  <h3>1 Week subscriptions:</h3>
  ';while($row = $stmt11->fetch()){
    if ($row["subDuration"] == "1week") {
        if(str_contains($row["code"], "_Z")) {
            if(!str_contains($row["code"], "P_")) {
                echo $row["code"] . "<br>";
            }
        }
    }
}
echo'
  </div>
</div>
</div>';
?>


<?php 
include 'Elements/footer.php';
?>