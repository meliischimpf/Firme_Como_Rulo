<?php

require_once __DIR__ . '/../../../conexion.php';
require_once __DIR__ . '/../../../clases/Alumno.php';
require_once __DIR__ . '/../../../clases/Materia.php';

$db = new Database();
$conn = $db->connect();


if (isset($_POST['apellido'], $_POST['nombre'], $_POST['dni'], $_POST['mail'], $_POST['fecha_nacimiento'], $_POST['materia'])) {
    $id_alumno = null;
    $apellido = $_POST['apellido'];
    $nombre = $_POST['nombre'];
    $dni = $_POST['dni'];
    $mail = $_POST['mail'];
    $fecha_nacimiento = $_POST['fecha_nacimiento'];
    $id_materia = $_POST['materia'];

    $alumno = new Alumno($apellido, $nombre, $dni, $mail, $fecha_nacimiento, $id_alumno);

    if ($alumno->darAlta($id_materia)) {
        echo "Alumno registrado exitosamente.";
        header("location: ../../menu.php");
    } else {
        echo "Error al registrar el alumno.";
    }
}
?>
