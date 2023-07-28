<?php
include 'Elements/header.php';
include 'Inc/db.inc.php';
$janGames = 0;
$febGames = 0;
$marchGames = 0;
$aprilGames = 0;
$mayGames = 0;
$juneGames = 0;
$julyGames = 0;
$augGames = 0;
$sepGames = 0;
$octGames = 0;
$novGames = 0;
$decGames = 0;
$hwid = urlencode($_GET['hwid']);
$hwid = str_replace("%3D", "=",$hwid);
$hwid = str_replace("%2F", "/",$hwid);
$hwid = str_replace("%2B", "+", $hwid);
try{
    $stmt = $pdo->query("SELECT * FROM users_lol WHERE hwid = '$hwid'");
}catch(Exception $e){
    echo $e;
}
try{
    $log = $pdo->query("SELECT * FROM log_injected WHERE hwid = '$hwid'");
}catch(Exception $e){
    echo $e;
}
?>
<script src="https://cdn.jsdelivr.net/npm/chart.js@2.9.3/dist/Chart.min.js"></script>
<?php 
try{
    while($row = $stmt->fetch()){
        $currentDate = new DateTime('now');
        $currentDate = $currentDate->format("Y-m-d h:i:s");
        echo '<h3 class="text-center">User: '. $row['name'] .' </h3>
        <h4 class="text-center">Current Date: '. $currentDate .'</h4>
        <div class="row">
        <div class="col-md-6 mx-auto">
        <canvas id="myChart"></canvas>
        <br>
        <a href="overview.php">Back</a>    
    </div>
    </div>';  
    }
}catch(Exception $e){
    echo $e;
}
try{
    while($logRow = $log->fetch()) {
        $date = explode(" ", $logRow['date']);
        $date = str_replace("2021-","", $date);
        $date = substr($date[0],0,strpos($date[0], "-"));
        $date = $date;
        echo '<br>';

        switch($date){
            case 1:
                $janGames++;
            break;
            case 2:
                $febGames++;
            break;
            case 3:
                $marchGames++;
            break;
            case 4:
                $aprilGames++;
            break;
            case 5:
                $mayGames++;
            break;
            case 6:
                $juneGames++;
            break;
            case 7:
                $julyGames++;
            break;
            case 8:
                $augGames++;
            break;
            case 9:
                $sepGames++;
            break;
            case 10:
                $octGames++;
            break;
            case 11:
                $novGames++;
            break;
            case 12:
                $decGames++;
            break;
        }
    }
}catch(Exception $e){
    echo $e;
}
?>
<script>
var ctx = document.getElementById('myChart').getContext('2d');
var myChart = new Chart(ctx, {
    type: 'bar',
    data: {
        labels: ['June 2021', 'July 2021', 'August 2021', 'September 2021', 'October 2021', 'November 2021','December 2021'],
        datasets: [{
            label: 'Amount of games per month',
            data: [<?php echo $juneGames ?>,
            <?php echo $julyGames ?>, <?php echo $augGames ?>,
            <?php echo $sepGames ?>, <?php echo $octGames ?>,
            <?php echo $novGames ?>, <?php echo $decGames ?>,
            ],
            backgroundColor: 'rgba(54, 162, 235, 0.2)',
            borderColor: 'rgba(54, 162, 235, 1)',
            borderWidth: 1
        }]
    },
    options: {
        scales: {
            yAxes: [{
                ticks: {
                    beginAtZero: false
                }
            }]
        }
    }
});
</script>



<?php
include 'Elements/footer.php';
?>