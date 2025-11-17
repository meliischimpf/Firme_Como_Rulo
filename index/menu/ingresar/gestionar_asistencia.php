<?php
header('Content-Type: application/json');
require_once __DIR__ . '/../../conexion.php';
require_once __DIR__ . '/../../clases/Alumno.php';

try {
    // Validar el método de la petición
    if ($_SERVER['REQUEST_METHOD'] !== 'POST') {
        throw new Exception('Método no permitido', 405);
    }

    // Validar y obtener los parámetros
    $id_alumno = filter_input(INPUT_POST, 'id_alumno', FILTER_VALIDATE_INT);
    $id_materia = filter_input(INPUT_POST, 'id_materia', FILTER_VALIDATE_INT);
    $presente = isset($_POST['presente']) && $_POST['presente'] === 'true';
    $fecha_asistencia = $_POST['fecha_asistencia'] ?? date('Y-m-d');

    // Validar los datos de entrada
    if (!$id_alumno || !$id_materia) {
        throw new Exception('Datos de entrada inválidos', 400);
    }

    // Validar el formato de la fecha
    if (!preg_match('/^\d{4}-\d{2}-\d{2}$/', $fecha_asistencia)) {
        throw new Exception('Formato de fecha inválido', 400);
    }

    // Registrar la asistencia
    Alumno::gestionarAsistencia($id_alumno, $id_materia, $presente, $fecha_asistencia);
    
    // Obtener el nuevo estado de asistencia para la fecha actual
    $db = new Database();
    $conn = $db->connect();
    $stmt = $conn->prepare("
        SELECT COUNT(*) 
        FROM asistencias 
        WHERE id_alumno = ? AND id_materia = ? AND fecha_asistencia = ?
    ");
    $stmt->execute([$id_alumno, $id_materia, $fecha_asistencia]);
    $asistio = $stmt->fetchColumn() > 0;

    echo json_encode([
        'estado' => 'exito',
        'asistio' => $asistio,
        'mensaje' => 'Asistencia actualizada correctamente'
    ]);

} catch (Exception $e) {
    http_response_code($e->getCode() ?: 500);
    echo json_encode([
        'estado' => 'error',
        'mensaje' => $e->getMessage()
    ]);
}
?>
