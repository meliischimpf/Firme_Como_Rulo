# Firme Como Rulo

**Instalación:**

Copiar y descomprimir el archivo en la carpeta de proyectos de su servidor web. Al final tendrás una carpeta llamada "Firme_Como_Rulo" (de ser el caso que al descomprimirla se llama "Firme_Como_Rulo-main", borre lo que no corresponda), a la cual accederás desde el navegador como http://localhost/Firme_Como_Rulo/.

----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

**Levantar servidor:**

Esta pagina fue creada utilizando laragon. Utilizando Apache 2.4.54 (en puerto 80) y MySQL 8.0.30.
Hay dos maneras de levantar el servidor. 

**1-** Utilizando Laragon: al introducir la carpeta del proyecto en "www", carpeta del directorio de laragon.

**2-** Por medio de cmd, levantandolo con el comando **"php -S localhost:80"** .

----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

**Iniciar la base de datos:**

Antes de registrarse, los usuarios **deben** hacer clic en un botón que inicializará la base de datos si aún no está configurada.

----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

**Uso del sistema:**

**Paso 1:** Dirígete a la página http://localhost/Firme_Como_Rulo/.

**Paso 2:** Verás un botón con el texto "Iniciar Base de Datos". Al hacer clic en este botón, se ejecutará un script que creará la base de datos y las tablas necesarias si aún no existen. El proceso verificará la existencia de la base de datos antes de intentar crearla, para evitar errores si ya está configurada.

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

**Configurar la conexión a la base de datos:**

Si es necesario, modifica el archivo http://localhost/Firme_Como_Rulo/conexion.php para actualizar los datos asociados al acceso a la base de datos, como el servidor, el usuario, la contraseña y el nombre de la base de datos.


**Registro de usuario:**

Después de que la base de datos esté configurada, los usuarios pueden registrarse en el sistema utilizando un formulario de registro en el cual podrán ingresar sus datos como nombre, correo electrónico, contraseña, etc.
