<?php
require_once __DIR__ . '../../../conexion.php';
require_once __DIR__ . '../../../clases/Alumno.php';
require_once __DIR__ . '../../../clases/Materia.php';

$db = new Database();
$conn = $db->connect();

$alumnos = Alumno::obtenerAlumnos();
$materias = Materia::obtenerMaterias();

$alumnoSeleccionado = null;
$errorMensaje = '';  


if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    if (isset($_POST['id_alumno']) && $_POST['id_alumno'] !== '') {
     
        $_SESSION['id_alumno'] = $_POST['id_alumno'];

     
        $alumnoSeleccionado = Alumno::obtenerAlumnoPorId($_POST['id_alumno']);
    } else {
        $errorMensaje = 'Por favor, complete todos los campos requeridos.';
    }
}

if (isset($_SESSION['id_alumno'])) {
    $alumnoSeleccionado = Alumno::obtenerAlumnoPorId($_SESSION['id_alumno']);
}
?>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Edición Alumno</title>
    <link href="https://fonts.googleapis.com/css?family=Karla:400" rel="stylesheet" type="text/css">
    <link rel="stylesheet" href="../../resources/menu/registrar/forms.css">
    <link rel="icon" href="../../resources/img/favicon.ico" type="image/x-icon">
</head>
<body>

<form action="" method="post" id="form-seleccionar-alumno">
    <h2>Seleccionar Alumno</h2>
    <label for="alumno">Seleccionar Alumno:</label>
    <select name="id_alumno" id="alumno" required>
        <option value="">Seleccione un Alumno</option>
        <?php
            foreach ($alumnos as $alumno) {
                $selected = (isset($alumnoSeleccionado) && $alumno['id_alumno'] == $alumnoSeleccionado['id_alumno']) ? 'selected' : '';
                echo "<option value='" . $alumno['id_alumno'] . "' $selected>" . htmlspecialchars($alumno['apellido_alumno']) . " " . htmlspecialchars($alumno['nombre_alumno']) . "</option>";
            }
        ?>
    </select>
    <button type="submit">Seleccionar Alumno</button>
</form>

<?php if ($errorMensaje): ?>
    <div style="color: red;"><?= htmlspecialchars($errorMensaje) ?></div>
<?php endif; ?>


<?php if ($alumnoSeleccionado): ?>
    <form action="procesar_ediciones/procesar_editar_alumno.php" method="post" id="form-editar-alumno">
        <h2>Edición de Alumno</h2>

        <input type="hidden" name="id_alumno" value="<?php echo htmlspecialchars($alumnoSeleccionado['id_alumno']); ?>">

        <div class="form-group">
            <div class="half-width">
                <label for="apellido"><b>Apellido</b></label>
                <input type="text" id="apellido" name="apellido" value="<?php echo htmlspecialchars($alumnoSeleccionado['apellido'] ?? '', ENT_QUOTES, 'UTF-8'); ?>" required>
            </div>
            <div class="half-width">
                <label for="nombre"><b>Nombre</b></label>
                <input type="text" id="nombre" name="nombre" value="<?php echo htmlspecialchars($alumnoSeleccionado['nombre'] ?? '', ENT_QUOTES, 'UTF-8'); ?>" required>
            </div>
        </div>

        <div class="form-group">
            <div class="half-width">
                <label for="dni"><b>DNI</b></label>
                <input type="number" id="dni" name="dni" value="<?php echo htmlspecialchars($alumnoSeleccionado['dni'] ?? '', ENT_QUOTES, 'UTF-8'); ?>" maxlength="8" required>
            </div>
            <div class="half-width">
                <label for="mail"><b>Correo Electrónico</b></label>
                <input type="email" id="mail" name="mail" value="<?php echo htmlspecialchars($alumnoSeleccionado['mail'] ?? '', ENT_QUOTES, 'UTF-8'); ?>" required>
            </div>
        </div>

        <div class="form-group">
            <div class="half-width">
                <label for="fecha_nacimiento"><b>Fecha Nacimiento</b></label>
                <input type="date" id="fecha_nacimiento" name="fecha_nacimiento" value="<?php echo htmlspecialchars($alumnoSeleccionado['fecha_nacimiento'] ?? '', ENT_QUOTES, 'UTF-8'); ?>" required>
            </div>
            <div class="half-width">
                <label for="materia"><b>Materia</b></label>
                <select name="materia" id="materia" required>
                    <option value="">Seleccione una materia</option>
                    <?php
                        foreach ($materias as $materia) {
                            $selected = ($alumnoSeleccionado['id_materia'] == $materia['id_materia']) ? 'selected' : '';
                            echo "<option value='" . $materia['id_materia'] . "' $selected>" . htmlspecialchars($materia['nombre_materia']) . "</option>";
                        }
                    ?>
                </select>
            </div>
        </div>

        <button type="submit"><b>Actualizar Alumno</b></button>
    </form>
<?php endif; ?>


</body>
</html>
