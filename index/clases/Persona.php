<?php

$data = $_POST;

class Persona {
    
    public function __construct(
    public $nombre, public $apellido, public $mail, public $fecha_nacimiento, public $dni) {

    }


    public function infoPersona(){

        echo $this->nombre, $this->apellido;
    
    }


}

$persona1 = new Persona ($data ['nombre'], $data ['apellido'], $data ['mail'], $data ['fecha_nacimiento'], $data ['dni']);
 

?>