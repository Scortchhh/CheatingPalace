<?php
include 'Elements/header.php';
include 'Inc/db.inc.php';
ini_set('display_errors', 1);
ini_set('display_startup_errors', 1);
error_reporting(E_ALL);
try{
    $stmt = $pdo->query("SELECT * FROM users_lol");
}catch(Exception $e){
    echo $e;
}
try{
    $log = $pdo->query("SELECT * FROM injected_scripts");
}catch(Exception $e){
    echo $e;
}

$scripts = $pdo->query("SELECT * FROM scripts WHERE `type` = 'Champion' OR `type` = 'Core' ORDER BY script ASC");
$allChampionScripts = [];
$allCoreScripts = [];
$allInjectedChampionScripts = [];
$allInjectedCoreScripts = [];
$scripts = $scripts->fetchAll();
$injectedScripts = $log->fetchAll();

$allInjectedScriptsString = "";
foreach($injectedScripts as $injectedScript) {
    $allInjectedScriptsString .= $injectedScript['scripts'];
}

foreach($scripts as $script) {
    if($script['type'] == "Champion") {
        array_push($allChampionScripts, $script['script']);
        array_push($allInjectedChampionScripts, substr_count($allInjectedScriptsString, $script['script']));
    } else {
        array_push($allCoreScripts, $script['script']);
        array_push($allInjectedCoreScripts, substr_count($allInjectedScriptsString, $script['script']));
    }
}

$allChampionScripts = json_encode($allChampionScripts);
$allCoreScripts = json_encode($allCoreScripts);
$allInjectedChampionScripts = json_encode($allInjectedChampionScripts);
$allInjectedCoreScripts = json_encode($allInjectedCoreScripts);
?>
<script src="https://cdn.jsdelivr.net/npm/chart.js@2.9.3/dist/Chart.min.js"></script>
<?php 
    $currentDate = new DateTime('now');
    $currentDate = $currentDate->format("Y-m-d h:i:s");
    echo '<h4 class="text-center mt-3">Current Date: '. $currentDate .'</h4>
    <div class="row">
    <div class="mx-auto">
        <h5 class="text-center mt-2">Champion Scripts Statistics</h5>
        <canvas id="myChart"></canvas>
        <br>
        <a href="overview.php">Back</a>    
    </div>
    </div>
    <div class="row">
    <div class="mx-auto">
    <h5 class="text-center mt-2">Core Scripts Statistics</h5>
        <canvas id="coreChart"></canvas>
        <br>
        <a href="overview.php">Back</a>    
    </div>
    </div>
';  
?>
<style>
canvas{
    width:1400px !important;
    height:600px !important;
}

.row {
    margin-right: 0px;
    margin-left: 0px;
}

</style>
<script>
var ctx = document.getElementById('myChart').getContext('2d');
var myChart = new Chart(ctx, {
    type: 'bar',
    data: {
        labels: <?= $allChampionScripts;?>,
        datasets: [{
            label: 'Total scripts used',
            data: <?= $allInjectedChampionScripts ?>,
            backgroundColor: 'rgba(54, 162, 235, 0.2)',
            borderColor: 'rgba(54, 162, 235, 1)',
            borderWidth: 1
        }]
    },
    options: {
        responsive: true,
        scales: {
            yAxes: [{
                ticks: {
                    beginAtZero: true
                }
            }],
            xAxes: [{
                ticks: {
                    autoSkip: false,
                    // maxTicksLimit: 20
                }
            }]
        }
    }
});

var ctx2 = document.getElementById('coreChart').getContext('2d');
var myChart2 = new Chart(ctx2, {
    type: 'bar',
    data: {
        labels: <?= $allCoreScripts;?>,
        datasets: [{
            label: 'Total scripts used',
            data: <?= $allInjectedCoreScripts ?>,
            backgroundColor: 'rgba(54, 162, 235, 0.2)',
            borderColor: 'rgba(54, 162, 235, 1)',
            borderWidth: 1
        }]
    },
    options: {
        responsive: true,
        scales: {
            yAxes: [{
                ticks: {
                    beginAtZero: true
                }
            }],
            xAxes: [{
                ticks: {
                    autoSkip: false,
                    // maxTicksLimit: 20
                }
            }]
        }
    }
});
</script>



<?php
include 'Elements/footer.php';
?>