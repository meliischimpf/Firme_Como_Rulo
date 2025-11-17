<?php

require_once __DIR__ . '/../conexion.php';

class Materia {

    public function __construct(
        public $nombre
    ) {}

    public static function crearMateriaDesdeID($id) {
        $db = new Database();
        $conn = $db->connect();

        // query para datos de la materia
        $stmt = $conn->prepare("SELECT nombre_materia FROM materias WHERE id_materia = :id");
        $stmt->bindParam(':id', $id);
        $stmt->execute();

        // resultado
        $data = $stmt->fetch(PDO::FETCH_ASSOC);

        // verifica
        if ($data) {
            // crea instancia de materia
            return new self($data['nombre_materia']);
        }

        return null; 
    }

    public static function obtenerMaterias() {

        $db = new Database();
        $conn = $db->connect();

        $stmt = $conn->prepare("SELECT id_materia, nombre_materia FROM materias");
        $stmt->execute();
        return $stmt->fetchAll(PDO::FETCH_ASSOC);
    }

    public static function obtenerMateriasPorInstituto($id_instituto) {

        $db = new Database();
        $conn = $db->connect();

        $stmt = $conn->prepare("SELECT id_materia, nombre_materia FROM materias WHERE id_instituto = :id_instituto");
        $stmt->bindParam(':id_instituto', $id_instituto, PDO::PARAM_INT);
        $stmt->execute();
        return $stmt->fetchAll(PDO::FETCH_ASSOC);
    }

    public function obtenerAlumnosPorMateria($id_materia) {

        $db = new Database();
        $conn = $db->connect();

        $stmt = $conn->prepare("SELECT id_alumno, apellido_alumno, nombre_alumno, mail_alumno, fecha_nacimiento_alumno, dni_alumno FROM alumno WHERE id_materia = :id_materia");
        $stmt->bindParam(':id_materia', $id_materia, PDO::PARAM_INT);
        $stmt->execute();
        return $stmt->fetchAll(PDO::FETCH_ASSOC);
    }

    public function darAltaMateria($id_instituto) {
        
            $db = new Database();
            $conn = $db->connect();
            
            $sql_materia = 
            "INSERT INTO materias (nombre_materia, id_instituto)
                        VALUES (:nombre_materia, :id_instituto)";
            
            $stmt = $conn->prepare($sql_materia);
            $stmt->bindParam(':nombre_materia', $this->nombre);
            $stmt->bindParam(':id_instituto', $id_instituto);
            
            return $stmt->execute();
        }
}

$materia = new Materia('');

?>
