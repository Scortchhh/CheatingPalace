<?php


use RocketrPayments\Order;
use RocketrPayments\RocketrPayments;
use RocketrPayments\RocketrPaymentsApiException;

include_once '../rocketr/init.php';

RocketrPayments::setApiKey('cpfcf7c3869fe636207fcea1ef0778d7', '957a66371feea8e3ee4658a76c1ef743237de6de2d4c9289dff86898808971c8');

$email = $_GET['email'];

$o = new \RocketrPayments\Order();

header("Content-type:application/json");

try {
    echo json_encode(Order::getOrders("search=" . $email));
}  catch (RocketrPaymentsApiException $e) {
    echo "API Exception\n";
    echo $e->getMessage() . "\n";
} catch (\RocketrPayments\RocketrPaymentsException $e) {
    echo "RocketrPayments Exception\n";
    echo $e->getMessage() . "\n";
} catch (Exception $e) {
    echo $e->getMessage() . "\n";
}
