<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Registro Alumno</title>
    <link href="https://fonts.googleapis.com/css?family=Karla:400" rel="stylesheet" type="text/css">
    <link rel="stylesheet" href="../../resources/menu/registrar/forms.css">
</head>

<body>
    <form action="main.php" method="post">
        <h2>Parámetros de Evaluación</h2>

        <div class="form-group">
            <div class="full-width">
                <label for="instituto"><b>Instituto a Cambiar</b></label>
                <select id="instituto" name="instituto" required></select>
            </div>
        </div>

        <div class="form-group">
            <div class="half-width">
                    <label for="promocion"><b>Promoción</b></label>
                    <input type="number" id="promocion" name="promocion" required>
            </div>
            <div class="half-width">
                <label for="asistencia_promocion"><b>Asistencia Promoción</b></label>
                <input type="number" id="asistencia_promocion" name="asistencia_promocion" required>
            </div>
        </div>

        <div class="form-group">
            <div class="half-width">
                <label for="regular"><b>Regular</b></label>
                <input type="number" id="regular" name="regular" required>
            </div>
            <div class="half-width">
                <label for="asistencia_regular"><b>Asistencia Regular</b></label>
                <input type="number" id="asistencia_regular" name="asistencia_regular" required>
            </div>
        </div>

        <div class="form-group">
            <div class="half-width">
                <label for="libre"><b>Libre</b></label>
                <input type="number" id="libre" name="libre" required>
            </div>
            <div class="half-width">
                <label for="asistencia_libre"><b>Asistencia Libre</b></label>
                <input type="number" id="asistencia_libre" name="asistencia_libre" required>
            </div>
        </div>

        <button type="submit"><b>Registrar</b></button>
    </form>
</body>
</html>