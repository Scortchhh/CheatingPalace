<?php

use RocketrPayments\Order;
use RocketrPayments\RocketrPayments;
use RocketrPayments\RocketrPaymentsApiException;

include_once '../rocketr/init.php';

RocketrPayments::setApiKey('cpfcf7c3869fe636207fcea1ef0778d7', '957a66371feea8e3ee4658a76c1ef743237de6de2d4c9289dff86898808971c8');

$email = $_GET['email'];

$o = new \RocketrPayments\Order();

$o->setPaymentMethod(\RocketrPayments\PaymentMethods::BitcoinPayment);
$o->setAmount(75);
$o->setCurrency("2");
$o->setNotes('This is an test note');
$o->setBuyerEmail($email);

try {
    $result = $o->createOrder();
} catch (\RocketrPayments\RocketrPaymentsException $e) {
    echo $e;
}

echo 'Please send ' . $result['paymentInstructions']['amount']  . $result['paymentInstructions']['currencyText'] . ' to ' . $result['paymentInstructions']['address'];
?>