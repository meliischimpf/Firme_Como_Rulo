<?php
session_start();

require_once __DIR__ . '../../../conexion.php';
require_once __DIR__ . '../../../clases/Materia.php';
require_once __DIR__ . '../../../clases/Instituto.php';

$db = new Database();
$conn = $db->connect();

$materias = Materia::obtenerMaterias();  
$institutos = [];

$institutos = $instituto->obtenerInstitutos();

$materiaSeleccionada = null;  
$errorMensaje = '';  


if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    if (isset($_POST['id_materia']) && $_POST['id_materia'] !== '') {
        $_SESSION['id_materia'] = $_POST['id_materia'];  
        
       
        $materiaSeleccionada = Materia::crearMateriaDesdeID($_POST['id_materia']);

 
        if (!$materiaSeleccionada) {
            $errorMensaje = 'No se encontró la materia con el ID especificado.';
        }
    } else {
        $errorMensaje = 'Por favor, complete todos los campos requeridos.';
    }
} elseif (isset($_SESSION['id_materia'])) {
    $materiaSeleccionada = Materia::crearMateriaDesdeID($_SESSION['id_materia']);
    if (!$materiaSeleccionada) {
        $errorMensaje = 'No se encontró la materia con el ID especificado.';
    }
}
?>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Edición Materia</title>
    <link href="https://fonts.googleapis.com/css?family=Karla:400" rel="stylesheet" type="text/css">
    <link rel="stylesheet" href="../../resources/menu/registrar/forms.css">
    <link rel="icon" href="../../resources/img/favicon.ico" type="image/x-icon">
</head>
<body>

<form action="" method="post" id="form-seleccionar-materia">
    <h2>Seleccionar Materia</h2>
    <label for="id_materia">Seleccionar Materia:</label>
    <select name="id_materia" id="id_materia" required>
        <option value="">Seleccione una Materia</option>
        <?php
        foreach ($materias as $materia) {

            $selected = (isset($materiaSeleccionada) && $materia['id_materia'] == $materiaSeleccionada['id_materia']) ? 'selected' : '';
            echo "<option value='" . $materia['id_materia'] . "' $selected>" . htmlspecialchars($materia['nombre_materia']) . "</option>";
        }
        ?>
    </select>
    <button type="submit">Seleccionar Materia</button>
</form>

<?php if ($errorMensaje): ?>
    <div style="color: red;"><?= htmlspecialchars($errorMensaje) ?></div>
<?php endif; ?>



<?php if ($materiaSeleccionada): ?>

    <form action="procesar_ediciones/procesar_editar_materia.php" method="post" id="form-editar-materia">
    <h2>Edición de Materia</h2>

    <input type="hidden" name="id_materia" value="<?php echo htmlspecialchars($materiaSeleccionada['id_materia']); ?>">

    <div class="form-group">
        <div class="half-width">
            <label for="nombre"><b>Nombre</b></label>
            <input type="text" id="nombre" name="nombre" value="<?php echo htmlspecialchars($materiaSeleccionada['nombre_materia'] ?? '', ENT_QUOTES, 'UTF-8'); ?>" required>
        </div>

        <div class="half-width">
            <label for="instituto"><b>Instituto</b></label>
            <select name="instituto" id="instituto" required>
                <option value="">Seleccione un Instituto</option>
                <?php
                    foreach ($institutos as $instituto) {
                        $selected = ($materiaSeleccionada['id_instituto'] == $instituto['id_instituto']) ? 'selected' : '';
                        echo "<option value='" . $instituto['id_instituto'] . "' $selected>" . htmlspecialchars($instituto['nombre_instituto']) . "</option>";
                    }
                ?>
            </select>
        </div>
    </div>

    <button type="submit"><b>Actualizar Materia</b></button>
</form>

<?php endif; ?>

</body>
</html>
