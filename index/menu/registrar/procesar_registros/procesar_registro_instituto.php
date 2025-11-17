<?php

require_once __DIR__ . '/../../../conexion.php';
require_once __DIR__ . '/../../../clases/Instituto.php';

$db = new Database();
$conn = $db->connect();

if (isset($_POST['nombre'], $_POST['direccion'], $_POST['cue'])) {
    $nombre = $_POST['nombre'];
    $direccion = $_POST['direccion'];
    $cue = $_POST['cue'];
    $id_instituto = null;

    // si se pasó un id_instituto (es una edición)
    $id_instituto = isset($_POST['id_instituto']) ? $_POST['id_instituto'] : null;

    $instituto = new Instituto($nombre, $direccion, $cue, $id_instituto);

    if ($id_instituto) { // Si el instituto tiene un ID, es una actualización
        if ($instituto->actualizarInstituto()) {
            echo "Instituto actualizado exitosamente.";
            header("location: ../../menu.php");
            exit;
        } else {
            echo "Error al actualizar el instituto.";
        }
    } else { // Si no tiene ID, es una creación
        if ($instituto->darAltaInstituto()) {
            // Insertamos los parámetros después de la creación
            $id_instituto = $conn->lastInsertId();
            $sql_parametros = "INSERT INTO parametros (id_instituto, libre, regular, promocion, asistencias_libre, asistencias_regular, asistencias_promocion)
                               VALUES (:id_instituto, '5', '6', '7', '50', '60', '70')";
            $stmt_parametros = $conn->prepare($sql_parametros);
            $stmt_parametros->bindParam(':id_instituto', $id_instituto);
            $stmt_parametros->execute();
            
            echo "Instituto registrado exitosamente.";
            header("location: ../../menu.php");
            exit;
        } else {
            echo "Error al registrar el instituto.";
        }
    }
} else {
    echo "Por favor, complete todos los campos requeridos.";
}
?>
