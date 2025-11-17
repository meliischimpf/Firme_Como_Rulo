<?php
require_once __DIR__ . '/../../conexion.php';
require_once __DIR__ . '/../../clases/Alumno.php';
require_once __DIR__ . '/../../clases/Materia.php';

$db = new Database();
$conn = $db->connect();

$materias = [];
$id_instituto = null; 

$materias = $materia->obtenerMaterias();
    
?>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Registro Alumno</title>
    <link href="https://fonts.googleapis.com/css?family=Karla:400" rel="stylesheet" type="text/css">
    <link rel="stylesheet" href="../../resources/menu/registrar/forms.css">
    <link rel="icon" href="../../resources/img/favicon.ico" type="image/x-icon">
</head>
<body>
    <form action="procesar_registros/procesar_registro_alumno.php" method="post" id="registro-alumno">
        <h2>Registro de Alumno</h2>

        <div class="form-group">
            <div class="half-width">
                <label for="apellido"><b>Apellido</b></label>
                <input type="text" id="apellido" name="apellido" required>
            </div>
            <div class="half-width">
                <label for="nombre"><b>Nombre</b></label>
                <input type="text" id="nombre" name="nombre" required>
            </div>
        </div>

        <div class="form-group">
            <div class="half-width">
                <label for="dni"><b>DNI</b></label>
                <input type="number" id="dni" name="dni" maxlength="8" required>
            </div>
            <div class="half-width">
                <label for="mail"><b>Correo Electrónico</b></label>
                <input type="email" id="mail" name="mail" required>
            </div>
        </div>

        <div class="form-group">
            <div class="half-width">
                <label for="fecha_nacimiento"><b>Fecha Nacimiento</b></label>
                <input type="date" id="fecha_nacimiento" name="fecha_nacimiento" required>
            </div>
            <div class="half-width">
                <label for="materia"><b>Materia</b></label>
                <select name="materia" id="materia" required>
                    <option value="">Seleccione una materia</option>
                    <?php
                        if (!empty($materias)) {
                            foreach ($materias as $materia) {
                                echo "<option value='" . $materia['id_materia'] . "'>" . $materia['nombre_materia'] . "</option>";
                            }
                        }
                    ?>
                </select>

            </div>
        </div>

        <button type="submit"><b>Registrar</b></button>
    </form>
</body>
</html>