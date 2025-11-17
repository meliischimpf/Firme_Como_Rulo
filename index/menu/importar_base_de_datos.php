<?php
if ($_SERVER['REQUEST_METHOD'] == 'POST') {
    $sqlFile = '../../script.sql';  

    $servername = "localhost";
    $username = "root"; 
    $password = "1234"; 
    $dbname = "Firme_como_rulo";

    $conn = new mysqli($servername, $username, $password);


    if ($conn->connect_error) {
        die("Conexión fallida: " . $conn->connect_error);
    }

    $result = $conn->query("SHOW DATABASES LIKE '$dbname'");

    if ($result->num_rows == 0) {
        $createDb = "CREATE DATABASE $dbname";
        if ($conn->query($createDb) === TRUE) {
            echo "Base de datos '$dbname' creada con éxito. ";
        } else {
            echo "Error al crear la base de datos: " . $conn->error;
            exit;
        }
    } else {
        echo "La base de datos '$dbname' ya existe. ";
    }


    $conn->select_db($dbname);

    if (file_exists($sqlFile)) {
     
        $sqlContent = file_get_contents($sqlFile);

        if ($conn->multi_query($sqlContent)) {
            echo "La base de datos ha sido importada correctamente.";
            header("Location: ../../index.php");
            exit;
        } else {
            echo "Error al importar la base de datos: " . $conn->error;
        }
    } else {
        echo "El archivo SQL no se encuentra.";
    }

    $conn->close();
}
?>
