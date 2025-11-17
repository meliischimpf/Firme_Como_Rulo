<?php

require_once __DIR__ . '/../conexion.php';

class Alumno {
    
    public function __construct(
        public $apellido, 
        public $nombre, 
        public $dni, 
        public $mail, 
        public $fecha_nacimiento, 
        public $id_alumno,
    ) {}            


    public static function crearAlumnoDesdeID($id) {
    
        $db = new Database();
        $conn = $db->connect();

        $stmt = $conn->prepare("SELECT apellido_alumno, nombre_alumno, dni_alumno, mail_alumno, fecha_nacimiento_alumno FROM alumno WHERE id_alumno = :id");
        $stmt->bindParam(':id', $id);
        $stmt->execute();
    
        $data = $stmt->fetch(PDO::FETCH_ASSOC);

        if ($data) {
            return new self($data['apellido_alumno'], $data['nombre_alumno'], $data['dni_alumno'],$data['mail_alumno'], $data['fecha_nacimiento_alumno'], $id);
        }

        return null; 
    }

    public static function contadorAlumnos () {
        
        $db = new Database();
        $conn = $db->connect();

        $query_alumnos = "SELECT COUNT(*) AS total_alumnos FROM alumno";
        $stmt_alumnos = $conn->query($query_alumnos);
        $alumnos = $stmt_alumnos->fetch();
        return $alumnos;
    }

    // Método para obtener todos los alumnos
    public static function obtenerAlumnos() {

        $db = new Database();
        $conn = $db->connect();
    
        $query = "SELECT id_alumno, apellido_alumno, nombre_alumno FROM alumno"; 
        
        $stmt = $conn->prepare($query);
        $stmt->execute();
        
        return $stmt->fetchAll(PDO::FETCH_ASSOC);
    }

    // Método para obtener un alumno por su ID
    public static function obtenerAlumnoPorId($id_alumno) {

        $db = new Database();
        $conn = $db->connect();
    
        $query = "SELECT * FROM alumno WHERE id_alumno = :id_alumno";
        
        $stmt = $conn->prepare($query);
        $stmt->bindParam(':id_alumno', $id_alumno, PDO::PARAM_INT);
        $stmt->execute();
        
        // Retornar un solo resultado (el alumno)
        return $stmt->fetch(PDO::FETCH_ASSOC);
    }

    // busca asistencia por fecha para marcar el check anterior
    public static function obtenerAsistenciaPorFecha($id_materia, $fecha_asistencia) {
        
        $db = new Database();
        $conn = $db->connect();
    
        $query = "SELECT id_alumno FROM asistencias WHERE id_materia = :id_materia AND fecha_asistencia = :fecha_asistencia";
        $stmt = $conn->prepare($query);
        $stmt->bindParam(':id_materia', $id_materia, PDO::PARAM_INT);
        $stmt->bindParam(':fecha_asistencia', $fecha_asistencia, PDO::PARAM_STR);
        $stmt->execute();
    
        return $stmt->fetchAll(PDO::FETCH_COLUMN);
    }


    // registra o elimina asistencia
    public static function gestionarAsistencia($id_alumno, $id_materia, $presente, $fecha_asistencia = null) {
        
        $db = new Database();
        $conn = $db->connect();
    
        // fecha actual si no se selecciona una
        $fecha_asistencia = $fecha_asistencia ?? date('Y-m-d');
    
        if ($presente) {
            // registra asistencia
            $query = "INSERT INTO asistencias (id_alumno, id_materia, fecha_asistencia) 
                      VALUES (:id_alumno, :id_materia, :fecha_asistencia)
                      ON DUPLICATE KEY UPDATE fecha_asistencia = :fecha_asistencia";
        } else {
            // elimina asistencia
            $query = "DELETE FROM asistencias 
                      WHERE id_alumno = :id_alumno AND id_materia = :id_materia AND fecha_asistencia = :fecha_asistencia";
        }
    
        $stmt = $conn->prepare($query);
        $stmt->bindParam(':id_alumno', $id_alumno, PDO::PARAM_INT);
        $stmt->bindParam(':id_materia', $id_materia, PDO::PARAM_INT);
        $stmt->bindParam(':fecha_asistencia', $fecha_asistencia, PDO::PARAM_STR);
        $stmt->execute();
    }
    
    // obtiene el cumpleaños del alumno

    public function verificarCumpleanios($fechaSeleccionada = null) {
        $db = new Database();
        $conn = $db->connect();

        $query = "SELECT id_alumno, nombre_alumno, apellido_alumno, fecha_nacimiento_alumno FROM alumno";
        $stmt = $conn->prepare($query);
        $stmt->execute();
        $alumnos = $stmt->fetchAll(PDO::FETCH_ASSOC);

        $cumpleaniosEnFecha = [];
        $fechaActual = $fechaSeleccionada ? date('m-d', strtotime($fechaSeleccionada)) : date('m-d');

        foreach ($alumnos as $alumno) {
            $fechaNacimiento = date('m-d', strtotime($alumno['fecha_nacimiento_alumno'])); 

            if ($fechaNacimiento === $fechaActual) {
                $cumpleaniosEnFecha[] = $alumno;
            }
        }

        return $cumpleaniosEnFecha; 
    }

    

    public static function gestionarNotas($id_alumno, $id_materia, $parcial1, $parcial2, $final) {
        $db = new Database();
        $conn = $db->connect();
    
        $querySelect = "SELECT parcial1, parcial2, final FROM calificaciones WHERE id_alumno = :id_alumno AND id_materia = :id_materia";
        $stmtSelect = $conn->prepare($querySelect);
        $stmtSelect->bindParam(':id_alumno', $id_alumno, PDO::PARAM_INT);
        $stmtSelect->bindParam(':id_materia', $id_materia, PDO::PARAM_INT);
        $stmtSelect->execute();
        $existingRow = $stmtSelect->fetch(PDO::FETCH_ASSOC);
    
        // si existe, solo se actualiza lo que se ingresa
        if ($existingRow) {
            $parcial1 = ($parcial1 !== "") ? $parcial1 : $existingRow['parcial1'];
            $parcial2 = ($parcial2 !== "") ? $parcial2 : $existingRow['parcial2'];
            $final = ($final !== "") ? $final : $existingRow['final'];
        }
    
        // inserta o actualiza las notas nuevas
        $query = "INSERT INTO calificaciones (id_alumno, id_materia, parcial1, parcial2, final) 
                  VALUES (:id_alumno, :id_materia, :parcial1, :parcial2, :final) 
                  ON DUPLICATE KEY UPDATE 
                  parcial1 = :new_parcial1, 
                  parcial2 = :new_parcial2, 
                  final = :new_final";
    
        $stmt = $conn->prepare($query);
        $stmt->bindParam(':id_alumno', $id_alumno, PDO::PARAM_INT);
        $stmt->bindParam(':id_materia', $id_materia, PDO::PARAM_INT);
        $stmt->bindParam(':parcial1', $parcial1, PDO::PARAM_STR);
        $stmt->bindParam(':parcial2', $parcial2, PDO::PARAM_STR);
        $stmt->bindParam(':final', $final, PDO::PARAM_STR);
        $stmt->bindParam(':new_parcial1', $parcial1, PDO::PARAM_STR);
        $stmt->bindParam(':new_parcial2', $parcial2, PDO::PARAM_STR);
        $stmt->bindParam(':new_final', $final, PDO::PARAM_STR);
    
        $stmt->execute();
    }
    
    
    
    public function darAlta($id_materia) {
        
        $db = new Database();
        $conn = $db->connect();
        
        $sql_alumno = 
        "INSERT INTO alumno (apellido_alumno, nombre_alumno, dni_alumno, mail_alumno, fecha_nacimiento_alumno, id_materia)
                    VALUES (:apellido_alumno, :nombre_alumno, :dni_alumno, :mail_alumno, :fecha_nacimiento_alumno, :id_materia)";
        
        $stmt = $conn->prepare($sql_alumno);
        $stmt->bindParam(':apellido_alumno', $this->apellido);
        $stmt->bindParam(':nombre_alumno', $this->nombre);
        $stmt->bindParam(':dni_alumno', $this->dni);
        $stmt->bindParam(':mail_alumno', $this->mail);
        $stmt->bindParam(':fecha_nacimiento_alumno', $this->fecha_nacimiento);
        $stmt->bindParam(':id_materia', $id_materia);
        
        return $stmt->execute();
    }
    

    public static function editarAlumno($id_alumno, $apellido, $nombre, $dni, $mail, $fecha_nacimiento, $id_materia) {
    
        $db = new Database();
        $conn = $db->connect();
    
        // Reemplazar los nombres de columnas por los de la base de datos
        $sql = "UPDATE alumno
                SET apellido_alumno = :apellido_alumno, nombre_alumno = :nombre_alumno, dni_alumno = :dni_alumno, 
                    mail_alumno = :mail_alumno, fecha_nacimiento_alumno = :fecha_nacimiento_alumno, id_materia = :id_materia
                WHERE id_alumno = :id_alumno";
    
        $stmt = $conn->prepare($sql);
    
        $stmt->bindParam(':id_alumno', $id_alumno);
        $stmt->bindParam(':apellido_alumno', $apellido);
        $stmt->bindParam(':nombre_alumno', $nombre);
        $stmt->bindParam(':dni_alumno', $dni);
        $stmt->bindParam(':mail_alumno', $mail);
        $stmt->bindParam(':fecha_nacimiento_alumno', $fecha_nacimiento);
        $stmt->bindParam(':id_materia', $id_materia);
        
    
        if ($stmt->execute()) {
            return true;
        } else {
            return false;
        }
    }
    


    public static function darBaja($id_alumno) {
        
        $db = new Database();
        $conn = $db->connect();

        if (!$conn) {
            error_log("Error al conectar a la base de datos.");
            return false;
        }
    
        try {
            // verifica si el alumno existe
            $checkQuery = "SELECT COUNT(*) FROM alumno WHERE id_alumno = :id_alumno";
            $checkStmt = $conn->prepare($checkQuery);
            $checkStmt->bindParam(':id_alumno', $id_alumno, PDO::PARAM_INT);
            $checkStmt->execute();
            $exists = $checkStmt->fetchColumn();
            

    
            if ($exists == 0) {
                error_log("El alumno con ID $id_alumno no existe.");
                return false;
            }
    
            // elimina el registro
            $query = "DELETE FROM alumno WHERE id_alumno = :id_alumno";
            $stmt = $conn->prepare($query);
            $stmt->bindParam(':id_alumno', $id_alumno, PDO::PARAM_INT);
    
            if ($stmt->execute()) {
                error_log("El alumno con ID $id_alumno fue eliminado correctamente.");
                return true;
            } else {
                error_log("Error al ejecutar la consulta de eliminación.");
                return false;
            }

        } catch (PDOException $e) {
            error_log("Error al dar de baja al alumno: " . $e->getMessage());
            return false;
        }
    }


    // total de clases
    public static function contarTotalClases($id_materia) {
        
        $db = new Database();
        $conn = $db->connect();

        $stmt_total_clases = $conn->prepare("SELECT COUNT(DISTINCT fecha_asistencia) AS total_clases FROM asistencias WHERE id_materia = :id_materia");
        $stmt_total_clases->bindParam(':id_materia', $id_materia, PDO::PARAM_INT);
        $stmt_total_clases->execute();
        $total_clases = $stmt_total_clases->fetch(PDO::FETCH_ASSOC)['total_clases'];

        return $total_clases;
    }

    public static function contarTotalClasesAlumno($id_alumno, $id_materia) {
        try {
            $db = new Database();
            $conn = $db->connect();
    
            $query_asistencias = "SELECT COUNT(*) AS total_asistencias FROM asistencias WHERE id_alumno = :id_alumno AND id_materia = :id_materia";
            $stmt_asistencias = $conn->prepare($query_asistencias);
            
            $stmt_asistencias->bindParam(':id_alumno', $id_alumno, PDO::PARAM_INT);
            $stmt_asistencias->bindParam(':id_materia', $id_materia, PDO::PARAM_INT);
            
            $stmt_asistencias->execute();
            
            $asistencias = $stmt_asistencias->fetch(PDO::FETCH_ASSOC)['total_asistencias'];
            
            return ($asistencias !== false) ? (int)$asistencias : 0; 
            
        } catch (Exception $e) {
            error_log($e->getMessage()); // Loguea el error para depuración
            return 0; // O manejar el error según sea necesario
        }
    }

    public function calcularPorcentajeAsistencia($id_alumno, $id_materia) {
        $db = new Database();
        $conn = $db->connect();
    
        // contador asistencias alumno
        $asistencias = $this->contarTotalClasesAlumno($id_alumno, $id_materia);
    
        // contador asistencias total
        $total_clases = $this->contarTotalClases($id_materia);

        // calcular porcentaje de asistencia    
        return ($total_clases > 0) ? round(($asistencias / $total_clases) * 100) : 0;
    }
    


    public function calificacion($id_alumno, $id_materia) {
        $db = new Database();
        $conn = $db->connect();
    
        $query_calificaciones = "SELECT parcial1, parcial2, final FROM calificaciones WHERE id_alumno = :id_alumno AND id_materia = :id_materia";
        $stmt_calificaciones = $conn->prepare($query_calificaciones);
        $stmt_calificaciones->bindParam(':id_alumno', $id_alumno, PDO::PARAM_INT);
        $stmt_calificaciones->bindParam(':id_materia', $id_materia, PDO::PARAM_INT);
        $stmt_calificaciones->execute();
        $calificacion = $stmt_calificaciones->fetch(PDO::FETCH_ASSOC);
    
        // Verifica si alguna calificación es NULL
        if ($calificacion) {
            if (is_null($calificacion['parcial1']) || is_null($calificacion['parcial2']) || is_null($calificacion['final'])) {
                return [
                    'parcial1' => "Nota no disponible",
                    'parcial2' => "Nota no disponible",
                    'final' => "Nota no disponible"
                ];
            }
            return [
                'parcial1' => $calificacion['parcial1'],
                'parcial2' => $calificacion['parcial2'],
                'final' => $calificacion['final']
            ];
        } else {
            return null; 
        }
    }
    

    public function calcularCondicionCalificacion($calificacion, $parametros) {
        // Verificamos si alguna de las calificaciones es NULL
        if (is_null($calificacion['parcial1']) || is_null($calificacion['parcial2']) || is_null($calificacion['final'])) {
            return "Nota no disponible para alguna calificación.";
        }
    
        // Si todas las notas están disponibles, realizamos las comparaciones
        if ($calificacion['parcial1'] >= $parametros['promocion'] && 
            $calificacion['parcial2'] >= $parametros['promocion'] && 
            $calificacion['final'] >= $parametros['promocion']) {
            return "Promoción";
        } elseif ($calificacion['parcial1'] >= $parametros['regular'] || 
                  $calificacion['parcial2'] >= $parametros['regular'] || 
                  $calificacion['final'] >= $parametros['regular']) {
            return "Regular";
        } else {
            return "Libre";
        }
    }
    

    public function evaluarCondicion($id_alumno, $id_materia, $id_instituto) {
        $db = new Database();
        $conn = $db->connect();
    
        // Obtenemos las calificaciones
        $calificacion = $this->calificacion($id_alumno, $id_materia);
    
        // Parámetros de evaluación
        $stmt_parametros = $conn->prepare("SELECT * FROM parametros WHERE id_instituto = :id_instituto");
        $stmt_parametros->bindParam(':id_instituto', $id_instituto, PDO::PARAM_INT);
        $stmt_parametros->execute();
        $parametros = $stmt_parametros->fetch(PDO::FETCH_ASSOC);
    
        // Verificación de parámetros
        if ($parametros === false) {
            return "Error al obtener los parámetros de evaluación.";
        }
    
        // Calcular porcentaje de asistencia
        $porcentaje_asistencia = $this->calcularPorcentajeAsistencia($id_alumno, $id_materia);
    
        // Evaluar condición de asistencia
        if ($porcentaje_asistencia >= $parametros['asistencias_promocion']) {
            $condicion_asistencia = "Promoción";
        } elseif ($porcentaje_asistencia >= $parametros['asistencias_regular']) {
            $condicion_asistencia = "Regular";
        } else {
            $condicion_asistencia = "Libre";
        }
    
        // Verificación de calificaciones no disponibles
        if ($calificacion) {
            // Si alguna calificación es "Nota no disponible"
            if ($calificacion['parcial1'] === "Nota no disponible" || 
                $calificacion['parcial2'] === "Nota no disponible" || 
                $calificacion['final'] === "Nota no disponible") {
                return "Nota no disponible para evaluar la condición.";
            }
    
            // Calcular la condición de calificación si todas las notas están disponibles
            $condicion_calificacion = $this->calcularCondicionCalificacion($calificacion, $parametros);
        } else {
            return "No hay calificaciones para evaluar la condición.";
        }
    
        // Condición final basada en calificación y asistencia
        if ($condicion_calificacion === "Promoción" && 
            ($condicion_asistencia === "Promoción" || 
             ($condicion_asistencia === "Regular" && 
              ($condicion_calificacion === "Regular")))) {
            return "Promoción";
        } elseif ($condicion_calificacion === "Regular" && 
                  ($condicion_asistencia === "Regular" || 
                   ($condicion_calificacion === "Regular"))) {
            return "Regular";
        } else {
            return "Libre";
        }
    }
    
}

$alumno = new Alumno('','','','','','');

?>
