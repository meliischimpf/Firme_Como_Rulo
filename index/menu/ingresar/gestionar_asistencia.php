<?php
header('Content-Type: application/json');
require_once __DIR__ . '../../../conexion.php';
require_once __DIR__ . '../../../clases/Alumno.php';

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $id_alumno = $_POST['id_alumno'];
    $id_materia = $_POST['id_materia'];
    $presente = $_POST['presente'] === 'true';
    $fecha_asistencia = $_POST['fecha_asistencia'];

    try {
        Alumno::gestionarAsistencia($id_alumno, $id_materia, $presente);
        echo json_encode(['estado' => 'exito']);
    } catch (Exception $e) {
        echo json_encode(['estado' => 'error', 'mensaje' => $e->getMessage()]);
    }
} else {
    echo json_encode(['estado' => 'error', 'mensaje' => 'método inválido']);
}
?>
