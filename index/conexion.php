<?php

class Database {
    private $host = '127.0.0.1';
    private $db_name = 'firme_como_rulo';
    private $username = 'root';
    private $password = '1234';
    public $conn;

    public function connect() {
        try {
            $this->conn = new PDO("mysql:host=" . $this->host . ";dbname=" . $this->db_name, $this->username, $this->password);
            $this->conn->setAttribute(PDO::ATTR_ERRMODE,
 PDO::ERRMODE_EXCEPTION);
        } catch(PDOException $e) {
            echo "Error de conexión: " . $e->getMessage();

            exit; 
        }

        return $this->conn;
    }
}
