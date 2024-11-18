<?php
header('Content-Type: application/json');
include "config/conn.php";

$id = $_POST['id'];
$nama = $_POST['nama'];
$code = $_POST['code'];
$stok = $_POST['stok'];

$stmt = $db->prepare("UPDATE barang SET nama = ?, code = ?, stok = ? WHERE id = ?");
$result = $stmt->execute([$nama, $code, $stok, $id]);

echo json_encode([
    'success' => $result
]);