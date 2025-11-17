<?php

require_once __DIR__ . '/../../../conexion.php';
require_once __DIR__ . '/../../../clases/Usuario.php';

$db = new Database();
$conn = $db->connect();

if (isset($_POST['nombre'], $_POST['apellido'], $_POST['mail'], $_POST['password'])) {
    $nombre = $_POST['nombre'];
    $apellido = $_POST['apellido'];
    $mail = $_POST['mail'];
    $password = $_POST['password'];

    $usuario = new Usuario($nombre, $apellido, $mail, $password);

    if ($usuario->darAltaUsuario()) {
        echo "Usuario registrado exitosamente.";
        header("location: ../../menu.php");
        exit;
    } else {
        echo "Error al registrar el instituto.";
    }
} else {
    echo "Por favor, complete todos los campos requeridos.";
}
?>
