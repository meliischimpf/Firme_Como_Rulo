<?php

require_once __DIR__ . '/../conexion.php';

class Instituto {

    public function __construct(
        public $nombre,
        public $direccion,
        public $cue,
        public $id_instituto,
    ) {}

   
    

    // instancia desde base de datos
    public static function crearInstitutoDesdeID($id) {
        $db = new Database();
        $conn = $db->connect();

        // query para datos de la institucion
        $stmt = $conn->prepare("SELECT nombre_instituto, direccion_instituto, cue_instituto FROM instituto WHERE id_instituto = :id");
        $stmt->bindParam(':id', $id);
        $stmt->execute();

        // resultado
        $data = $stmt->fetch(PDO::FETCH_ASSOC);

        // verifica
        if ($data) {
            // crea instancia de instituto
            return new self($data['nombre_instituto'], $data['direccion_instituto'], $data['cue_instituto'], $id);
        }

        return null; 
    }


    public static function obtenerInstitutos() {

        $db = new Database();
        $conn = $db->connect();

        $stmt = $conn->prepare("SELECT id_instituto, nombre_instituto FROM instituto");
        $stmt->execute();
        return $stmt->fetchAll(PDO::FETCH_ASSOC);
    }

    public function darAltaInstituto() {
        $db = new Database();
        $conn = $db->connect();
        
        $conn->beginTransaction();
        
        try {
            $sql_instituto = "INSERT INTO instituto (nombre_instituto, direccion_instituto, cue_instituto)
                              VALUES (:nombre_instituto, :direccion_instituto, :cue_instituto)";
            $stmt = $conn->prepare($sql_instituto);
            $stmt->bindParam(':nombre_instituto', $this->nombre);
            $stmt->bindParam(':direccion_instituto', $this->direccion);
            $stmt->bindParam(':cue_instituto', $this->cue);
            $stmt->execute();

            $id_instituto = $conn->lastInsertId();
    
            $sql_parametros = "INSERT INTO parametros (id_instituto, libre, regular, promocion, asistencias_libre, asistencias_regular, asistencias_promocion)
                                    VALUES (:id_instituto, '5', '6', '7', '50', '60', '70')";
            $stmt_parametros = $conn->prepare($sql_parametros);
            $stmt_parametros->bindParam(':id_instituto', $id_instituto);
            $stmt_parametros->execute();
            
           
            $conn->commit();
    
            return true;
    
        } catch (Exception $e) {
            $conn->rollBack();
            echo "Error: " . $e->getMessage();
            return false;
        }
    }
    
    public function actualizarInstituto() {
        $db = new Database();
        $conn = $db->connect();
        
        try {
            // Si existe el ID, actualiza el instituto
            $sql_instituto = "UPDATE instituto
                              SET nombre_instituto = :nombre_instituto,
                                  direccion_instituto = :direccion_instituto,
                                  cue_instituto = :cue_instituto
                              WHERE id_instituto = :id_instituto";
            $stmt = $conn->prepare($sql_instituto);
            $stmt->bindParam(':nombre_instituto', $this->nombre);
            $stmt->bindParam(':direccion_instituto', $this->direccion);
            $stmt->bindParam(':cue_instituto', $this->cue);
            $stmt->bindParam(':id_instituto', $this->id_instituto);
            $stmt->execute();
            
            return true;
        } catch (Exception $e) {
            echo "Error: " . $e->getMessage();
            return false;
        }
    }

}

$instituto = new Instituto('', '', '', ''); 

?>
