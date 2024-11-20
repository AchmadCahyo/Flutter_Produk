<?php
header("Content-Type: application/json");
include "config/conn.php";

$stmt = $db->prepare("SELECT id, nama, code, stok FROM barang");
$stmt->execute();
$result = $stmt->fetchAll(PDO::FETCH_ASSOC);

echo json_encode($result);