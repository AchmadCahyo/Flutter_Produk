<?php
header("COntent-Type: application/json");
include "config/conn.php";

$nama = $_POST['nama'];
$code = $_POST['code'];
$stok = $_POST['stok'];

$stmt = $db->prepare("INSERT INTO barang (nama, code, stok) VALUES (?, ?, ?)");
$result = $stmt->execute([$nama, $code, $stok]);

echo json_encode([
    'success' => $result
]);