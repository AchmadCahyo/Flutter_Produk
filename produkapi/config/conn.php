<?php
header('Access-Control-Allow-Origin: *');

$db_name = "produk";
$server = "localhost";
$user = "root";
$pass = "";

$db = new PDO("mysql:host={$server}; dbname={$db_name}; charset=utf8", $user, $pass);
$db->setAttribute(PDO::ATTR_EMULATE_PREPARES, false);
$db->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);