<?php
            require_once __DIR__ . '../../../conexion.php';
            require_once __DIR__ . '../../../clases/Alumno.php';
    
            $db = new Database();
            $conn = $db->connect();

            if (!$conn) {
                error_log("Error al conectar a la base de datos.");
                return false;
            }

            // dar de baja
            if (isset($_POST['action']) && $_POST['action'] === 'dar_baja' && isset($_POST['id_alumno'])) {
                $id_alumno = $_POST['id_alumno'];
                error_log("Intentando dar de baja al alumno con ID: " . $id_alumno);
                $resultado = Alumno::darBaja($id_alumno);
                if ($resultado) {
                    echo 'Éxito';
                } else {
                    echo 'Error al dar de baja al alumno.';
                }
                exit();
            }
            
?>