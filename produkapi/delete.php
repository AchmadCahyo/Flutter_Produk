<?php
header('Content-Type: application/json');
include "config/conn.php";

$id = (int) $_POST['id'];
$stmt = $db->prepare("DELETE FROM barang WHERE id = ?");
$result = $stmt->execute([$id]);

echo json_encode([
    'id' => $id,
    'success' => $result
]);