<?php

if (isset($_GET['id_instituto'])) {

    require_once __DIR__ . '../../../clases/Instituto.php';
    $instituto = Instituto::crearInstitutoDesdeID($_GET['id_instituto']);
}
?>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Registro de Institución</title>
    <link href="https://fonts.googleapis.com/css?family=Karla:400" rel="stylesheet" type="text/css">
    <link rel="stylesheet" href="../../resources/menu/registrar/forms.css">
    <link rel="icon" href="../../resources/img/favicon.ico" type="image/x-icon">
</head>

<body>
    <form action="procesar_registros/procesar_registro_instituto.php" method="post">
        <h2><?php echo isset($instituto) ? 'Editar Instituto' : 'Registrar Instituto'; ?></h2>

        <div class="form-group">
            <div class="half-width">
                <label for="nombre"><b>Nombre</b></label>
                <input type="text" id="nombre" name="nombre" value="<?php echo isset($instituto) ? $instituto->nombre : ''; ?>" required>
            </div>
            <div class="half-width">
                <label for="direccion"><b>Dirección</b></label>
                <input type="text" id="direccion" name="direccion" value="<?php echo isset($instituto) ? $instituto->direccion : ''; ?>" required>
            </div>
        </div>

        <div class="form-group">
            <div class="full-width">
                <label for="cue"><b>C.U.E.</b></label>
                <input type="number" id="cue" name="cue" value="<?php echo isset($instituto) ? $instituto->cue : ''; ?>" required>
            </div>
        </div>

        <input type="hidden" name="id_instituto" value="<?php echo isset($instituto) ? $instituto->id_instituto : ''; ?>">

        <button type="submit"><b><?php echo isset($instituto) ? 'Actualizar' : 'Registrar'; ?></b></button>
    </form>
</body>
</html>
