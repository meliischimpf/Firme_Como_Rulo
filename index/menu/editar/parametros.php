<?php
session_start();
require_once __DIR__ . '../../../conexion.php';
require_once __DIR__ . '../../../clases/ParametrosEvaluacion.php';
require_once __DIR__ . '../../../clases/Instituto.php';

$institutos = Instituto::obtenerInstitutos();
$parametrosSeleccionados = null;
$errorMensaje = '';

if ($_SERVER['REQUEST_METHOD'] === 'POST' && isset($_POST['id_instituto'])) {
    $id_instituto = $_POST['id_instituto'];
    $parametrosSeleccionados = ParametrosEvaluacion::obtenerParametrosPorInstituto($id_instituto);
    $_SESSION['id_instituto'] = $id_instituto;
}


function getNumericValue($value) {
    return is_numeric($value) ? $value : '';
}

?>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Editar Parametros</title>
    <link href="https://fonts.googleapis.com/css?family=Karla:400" rel="stylesheet" type="text/css">
    <link rel="stylesheet" href="../../resources/menu/registrar/forms.css">
</head>
<body>
    <form action="" method="post">
        <h2>Seleccionar Instituto</h2>
        <select name="id_instituto" required>
            <option value="">Seleccione un Instituto</option>
            <?php foreach ($institutos as $instituto): ?>
                <option value="<?= htmlspecialchars($instituto['id_instituto']); ?>" <?= (isset($_SESSION['id_instituto']) && $_SESSION['id_instituto'] == $instituto['id_instituto']) ? 'selected' : ''; ?>>
                    <?= htmlspecialchars($instituto['nombre_instituto']); ?>
                </option>
            <?php endforeach; ?>
        </select>
        <button type="submit">Seleccionar Instituto</button>
    </form>

    <?php if ($parametrosSeleccionados): ?>
        
        <form action="procesar_ediciones/procesar_editar_parametros.php" method="post">
            <input type="hidden" name="id_instituto" value="<?= htmlspecialchars($id_instituto); ?>">

            <label>Promoción</label>
            <input type="number" name="promocion" value="<?= getNumericValue($parametrosSeleccionados['promocion']); ?>" required>

            <label>Asistencia Promoción</label>
            <input type="number" name="asistencia_promocion" value="<?= getNumericValue($parametrosSeleccionados['asistencias_promocion']); ?>" required>

            <label>Regular</label>
            <input type="number" name="regular" value="<?= getNumericValue($parametrosSeleccionados['regular']); ?>" required>

            <label>Asistencia Regular</label>
            <input type="number" name="asistencia_regular" value="<?= getNumericValue($parametrosSeleccionados['asistencias_regular']); ?>" required>

            <label>Libre</label>
            <input type="number" name="libre" value="<?= getNumericValue($parametrosSeleccionados['libre']); ?>" required>

            <label>Asistencia Libre</label>
            <input type="number" name="asistencia_libre" value="<?= getNumericValue($parametrosSeleccionados['asistencias_libre']); ?>" required>

            <button type="submit">Actualizar Parámetros</button>
        </form>
    <?php endif; ?>
</body>
</html>
