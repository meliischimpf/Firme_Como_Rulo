<?php
// Enable error reporting for debugging
error_reporting(E_ALL);
ini_set('display_errors', 1);
ini_set('log_errors', 1);
ini_set('error_log', __DIR__ . '/php_errors.log');

// Set headers first to ensure JSON response
header('Content-Type: application/json; charset=utf-8');
header('X-Content-Type-Options: nosniff');
header('Access-Control-Allow-Origin: *');
header('Access-Control-Allow-Methods: POST');
header('Access-Control-Allow-Headers: Content-Type');

// Function to send JSON response
function sendJsonResponse($success, $message = '', $data = null) {
    http_response_code($success ? 200 : 400);
    $response = ['success' => $success, 'message' => $message];
    if ($data !== null) $response['data'] = $data;
    echo json_encode($response, JSON_UNESCAPED_UNICODE | JSON_UNESCAPED_SLASHES);
    exit;
}

// Log function for debugging
function logMessage($message) {
    $logFile = __DIR__ . '/debug.log';
    file_put_contents($logFile, date('Y-m-d H:i:s') . ' - ' . $message . PHP_EOL, FILE_APPEND);
}

// Start output buffering to catch any unwanted output
ob_start();

try {
    // Log the raw input
    $input = file_get_contents('php://input');
    logMessage("Raw input: " . $input);
    
    // Try to decode JSON
    $data = json_decode($input, true);
    
    // If JSON decode fails, try to get from $_POST
    if (json_last_error() !== JSON_ERROR_NONE) {
        logMessage("JSON decode error: " . json_last_error_msg());
        $data = $_POST;
    }
    
    // Log the processed data
    logMessage("Processed data: " . print_r($data, true));
    
    // Validate required fields
    if (empty($data['id_materia'])) {
        throw new Exception('ID de materia es requerido');
    }
    
    if (empty($data['notas']) || !is_array($data['notas'])) {
        throw new Exception('Datos de notas inválidos o faltantes');
    }
    
    $id_materia = (int)$data['id_materia'];
    $notas = $data['notas'];
    
    // Validate materia ID
    if ($id_materia <= 0) {
        throw new Exception('ID de materia inválido');
    }
    
    // Log the data we're about to process
    logMessage("Processing materia ID: $id_materia");
    logMessage("Notas: " . print_r($notas, true));
    
    // Include database connection
    // Go up two levels to reach the index directory
    $rootPath = dirname(__DIR__, 2);
    $conexionPath = $rootPath . '/conexion.php';
    
    // Debug: Log the path being used
    logMessage("Intentando incluir: " . $conexionPath);
    
    if (!file_exists($conexionPath)) {
        throw new Exception("No se pudo encontrar el archivo de conexión en: " . $conexionPath);
    }
    
    require_once $conexionPath;

    // Create a new instance of the Database class and connect
    $database = new Database();
    $conexion = $database->connect();
    $conexion->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
    $conexion->beginTransaction();

    $resultados = [];
    foreach ($notas as $id_alumno => $calificaciones) {
        $id_alumno = (int)$id_alumno;
        if ($id_alumno <= 0) {
            $resultados[] = "ID de alumno inválido: $id_alumno";
            continue;
        }

        // Validate and format grades
        $datos = [
            'parcial1' => isset($calificaciones['parcial1']) && is_numeric($calificaciones['parcial1']) ? 
                         max(0, min(10, (float)$calificaciones['parcial1'])) : null,
            'parcial2' => isset($calificaciones['parcial2']) && is_numeric($calificaciones['parcial2']) ? 
                         max(0, min(10, (float)$calificaciones['parcial2'])) : null,
            'final' => isset($calificaciones['final']) && is_numeric($calificaciones['final']) ? 
                      max(0, min(10, (float)$calificaciones['final'])) : null
        ];

        try {
            // Check if record exists
            $stmt = $conexion->prepare(
                "SELECT COUNT(*) FROM calificaciones 
                 WHERE id_alumno = ? AND id_materia = ?"
            );
            $stmt->execute([$id_alumno, $id_materia]);
            $existe = $stmt->fetchColumn() > 0;

            if ($existe) {
                $sql = "UPDATE calificaciones 
                        SET parcial1 = :parcial1, 
                            parcial2 = :parcial2, 
                            final = :final
                        WHERE id_alumno = :id_alumno 
                        AND id_materia = :id_materia";
            } else {
                $sql = "INSERT INTO calificaciones 
                        (id_alumno, id_materia, parcial1, parcial2, final) 
                        VALUES (:id_alumno, :id_materia, :parcial1, :parcial2, :final)";
            }

            $stmt = $conexion->prepare($sql);
            $params = array_merge(
                $datos,
                ['id_alumno' => $id_alumno, 'id_materia' => $id_materia]
            );
            
            $stmt->execute($params);
            $resultados[] = ($existe ? 'Actualizado' : 'Creado') . " alumno $id_alumno";

        } catch (PDOException $e) {
            $resultados[] = "Error con alumno $id_alumno: " . $e->getMessage();
            logMessage("Error al guardar calificación: " . $e->getMessage());
        }
    }

    // Commit the transaction
    $conexion->commit();
    
    // Clear any output that might have been generated
    ob_end_clean();
    
    // Send success response
    sendJsonResponse(true, 'Calificaciones guardadas correctamente', $resultados);

} catch (Exception $e) {
    // Clean the output buffer before sending error
    ob_end_clean();
    
    // Rollback transaction if active
    if (isset($conexion) && $conexion->inTransaction()) {
        try {
            $conexion->rollBack();
        } catch (Exception $rollbackEx) {
            // Log rollback error but don't override original error
            logMessage("Rollback error: " . $rollbackEx->getMessage());
        }
    }
    
    // Log and return the error
    $errorMsg = $e->getMessage();
    logMessage("Error: " . $errorMsg);
    sendJsonResponse(false, 'Error: ' . $errorMsg);
}
