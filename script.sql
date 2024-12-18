-- --------------------------------------------------------
-- Host:                         127.0.0.1
-- Versión del servidor:         8.0.30 - MySQL Community Server - GPL
-- SO del servidor:              Win64
-- HeidiSQL Versión:             12.1.0.6537
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;


-- Volcando estructura de base de datos para firme_como_rulo
CREATE DATABASE IF NOT EXISTS `firme_como_rulo` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `firme_como_rulo`;

-- Volcando estructura para tabla firme_como_rulo.alumno
CREATE TABLE IF NOT EXISTS `alumno` (
  `id_alumno` int NOT NULL AUTO_INCREMENT,
  `apellido_alumno` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `nombre_alumno` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `dni_alumno` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `mail_alumno` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `fecha_nacimiento_alumno` date NOT NULL,
  `id_materia` int DEFAULT NULL,
  PRIMARY KEY (`id_alumno`),
  UNIQUE KEY `DNI` (`dni_alumno`) USING BTREE,
  UNIQUE KEY `mail` (`mail_alumno`) USING BTREE,
  KEY `alumno_ibfk_1` (`id_materia`),
  CONSTRAINT `alumno_ibfk_1` FOREIGN KEY (`id_materia`) REFERENCES `materias` (`id_materia`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=86 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Volcando datos para la tabla firme_como_rulo.alumno: ~23 rows (aproximadamente)
INSERT INTO `alumno` (`id_alumno`, `apellido_alumno`, `nombre_alumno`, `dni_alumno`, `mail_alumno`, `fecha_nacimiento_alumno`, `id_materia`) VALUES
	(1, 'Andrade', 'Valentino', '35123456', 'valentino.andrade@ejemplo.com', '1999-03-12', 1),
	(2, 'Cedres', 'Lucas', '34876543', 'lucas.cedres@ejemplo.com', '1998-09-07', 1),
	(3, 'Figun', 'Facundo', '40123789', 'facundo.figun@ejemplo.com', '2000-11-25', 1),
	(4, 'Giordano', 'Luca', '32456789', 'luca.giordano@ejemplo.com', '1997-06-02', 1),
	(5, 'Godoy', 'Bruno', '36789123', 'bruno.godoy@ejemplo.com', '1999-01-18', 1),
	(6, 'Gomez', 'Agustin', '33567890', 'agustin.gomez@ejemplo.com', '1996-04-30', 1),
	(7, 'Gonzalez', 'Brian', '35678901', 'brian.gonzalez@ejemplo.com', '1997-12-05', 1),
	(8, 'Guigou Scottini', 'Federico', '37890123', 'federico.guigou@ejemplo.com', '1998-08-15', 1),
	(9, 'Marrano', 'Luna', '38901234', 'luna.marrano@ejemplo.com', '1999-03-10', 1),
	(10, 'Mercado Aviles', 'Giuliana', '33345678', 'giuliana.mercado@ejemplo.com', '1995-10-22', 1),
	(11, 'Mercado Ruiz', 'Lucila', '32567890', 'lucila.mercado@ejemplo.com', '1996-12-08', 1),
	(12, 'Murillo', 'Angel', '34890123', 'angel.murillo@ejemplo.com', '1998-02-27', 1),
	(13, 'Nissero', 'Juan', '36123456', 'juan.nissero@ejemplo.com', '1999-07-17', 1),
	(14, 'Parada', 'Fausto', '35234567', 'fausto.parada@ejemplo.com', '1997-11-06', 1),
	(15, 'Piter', 'Ignacio', '32789012', 'ignacio.piter@ejemplo.com', '1996-05-19', 1),
	(16, 'Planchon', 'Tomas', '40456789', 'tomas.planchon@ejemplo.com', '2000-09-03', 1),
	(17, 'Ronconi', 'Elisa', '31678123', 'elisa.ronconi@ejemplo.com', '1995-01-24', 1),
	(18, 'Sanchez', 'Exequiel', '33234567', 'exequiel.sanchez@ejemplo.com', '1998-04-11', 1),
	(19, 'Schimpf Baldo', 'Melina', '33789456', 'melina.schimpf@ejemplo.com', '2003-06-02', 1),
	(20, 'Segovia', 'Diego', '34567890', 'diego.segovia@ejemplo.com', '1997-02-13', 1),
	(21, 'Sittner', 'Camila', '36456789', 'camila.sittner@ejemplo.com', '1999-08-20', 1),
	(22, 'Villa', 'Yamil', '35345678', 'yamil.villa@ejemplo.com', '1998-06-28', 1),
	(23, 'Zabala', 'Daniel', '32313231', 'zabala.danlel@ejemplo.com', '2001-01-13', 1);

-- Volcando estructura para tabla firme_como_rulo.asistencias
CREATE TABLE IF NOT EXISTS `asistencias` (
  `id_asistencia` int NOT NULL AUTO_INCREMENT,
  `id_alumno` int NOT NULL,
  `id_materia` int NOT NULL,
  `fecha_asistencia` date DEFAULT NULL,
  PRIMARY KEY (`id_asistencia`),
  KEY `id_alumno` (`id_alumno`),
  KEY `id_materia` (`id_materia`),
  CONSTRAINT `asistencias_ibfk_1` FOREIGN KEY (`id_alumno`) REFERENCES `alumno` (`id_alumno`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=2182 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Volcando datos para la tabla firme_como_rulo.asistencias: ~808 rows (aproximadamente)
INSERT INTO `asistencias` (`id_asistencia`, `id_alumno`, `id_materia`, `fecha_asistencia`) VALUES
	(1370, 1, 1, '2024-11-01'),
	(1371, 1, 1, '2024-10-31'),
	(1372, 1, 1, '2024-10-30'),
	(1373, 1, 1, '2024-10-29'),
	(1374, 1, 1, '2024-10-28'),
	(1375, 1, 1, '2024-10-27'),
	(1376, 1, 1, '2024-10-26'),
	(1377, 1, 1, '2024-10-25'),
	(1378, 1, 1, '2024-10-24'),
	(1379, 1, 1, '2024-10-23'),
	(1380, 1, 1, '2024-10-22'),
	(1381, 1, 1, '2024-10-21'),
	(1382, 1, 1, '2024-10-20'),
	(1383, 1, 1, '2024-10-19'),
	(1384, 1, 1, '2024-10-18'),
	(1385, 1, 1, '2024-10-17'),
	(1386, 1, 1, '2024-10-16'),
	(1387, 1, 1, '2024-10-15'),
	(1388, 1, 1, '2024-10-14'),
	(1389, 1, 1, '2024-10-13'),
	(1390, 1, 1, '2024-10-12'),
	(1391, 1, 1, '2024-10-11'),
	(1392, 1, 1, '2024-10-10'),
	(1393, 1, 1, '2024-10-09'),
	(1394, 1, 1, '2024-10-08'),
	(1395, 1, 1, '2024-10-07'),
	(1396, 1, 1, '2024-10-06'),
	(1397, 1, 1, '2024-10-05'),
	(1398, 1, 1, '2024-10-04'),
	(1399, 1, 1, '2024-10-03'),
	(1400, 1, 1, '2024-10-02'),
	(1401, 1, 1, '2024-10-01'),
	(1402, 1, 1, '2024-09-30'),
	(1403, 1, 1, '2024-09-29'),
	(1404, 1, 1, '2024-09-28'),
	(1405, 1, 1, '2024-09-27'),
	(1406, 1, 1, '2024-09-26'),
	(1407, 1, 1, '2024-09-25'),
	(1408, 1, 1, '2024-09-24'),
	(1409, 1, 1, '2024-09-23'),
	(1410, 2, 1, '2024-11-01'),
	(1411, 2, 1, '2024-10-31'),
	(1412, 2, 1, '2024-10-30'),
	(1413, 2, 1, '2024-10-29'),
	(1414, 2, 1, '2024-10-28'),
	(1415, 2, 1, '2024-10-27'),
	(1416, 2, 1, '2024-10-26'),
	(1417, 2, 1, '2024-10-25'),
	(1418, 2, 1, '2024-10-24'),
	(1419, 2, 1, '2024-10-23'),
	(1420, 2, 1, '2024-10-22'),
	(1421, 2, 1, '2024-10-21'),
	(1422, 2, 1, '2024-10-20'),
	(1423, 2, 1, '2024-10-19'),
	(1424, 2, 1, '2024-10-18'),
	(1425, 2, 1, '2024-10-17'),
	(1426, 2, 1, '2024-10-16'),
	(1427, 2, 1, '2024-10-15'),
	(1428, 2, 1, '2024-10-14'),
	(1429, 2, 1, '2024-10-13'),
	(1430, 2, 1, '2024-10-12'),
	(1431, 2, 1, '2024-10-11'),
	(1432, 2, 1, '2024-10-10'),
	(1433, 2, 1, '2024-10-09'),
	(1434, 2, 1, '2024-10-08'),
	(1435, 2, 1, '2024-10-07'),
	(1436, 2, 1, '2024-10-06'),
	(1437, 2, 1, '2024-10-05'),
	(1438, 2, 1, '2024-10-04'),
	(1439, 2, 1, '2024-10-03'),
	(1440, 2, 1, '2024-10-02'),
	(1441, 2, 1, '2024-10-01'),
	(1442, 2, 1, '2024-09-30'),
	(1443, 2, 1, '2024-09-29'),
	(1444, 2, 1, '2024-09-28'),
	(1445, 2, 1, '2024-09-27'),
	(1446, 2, 1, '2024-09-26'),
	(1447, 2, 1, '2024-09-25'),
	(1448, 2, 1, '2024-09-24'),
	(1449, 2, 1, '2024-09-23'),
	(1450, 2, 1, '2024-09-22'),
	(1451, 3, 1, '2024-11-01'),
	(1452, 3, 1, '2024-10-31'),
	(1453, 3, 1, '2024-10-30'),
	(1454, 3, 1, '2024-10-29'),
	(1455, 3, 1, '2024-10-28'),
	(1456, 3, 1, '2024-10-27'),
	(1457, 3, 1, '2024-10-26'),
	(1458, 3, 1, '2024-10-25'),
	(1459, 3, 1, '2024-10-24'),
	(1460, 3, 1, '2024-10-23'),
	(1461, 4, 1, '2024-11-01'),
	(1462, 4, 1, '2024-10-31'),
	(1463, 4, 1, '2024-10-30'),
	(1464, 4, 1, '2024-10-29'),
	(1465, 4, 1, '2024-10-28'),
	(1466, 4, 1, '2024-10-27'),
	(1467, 4, 1, '2024-10-26'),
	(1468, 4, 1, '2024-10-25'),
	(1469, 4, 1, '2024-10-24'),
	(1470, 4, 1, '2024-10-23'),
	(1471, 4, 1, '2024-10-22'),
	(1472, 4, 1, '2024-10-21'),
	(1473, 4, 1, '2024-10-20'),
	(1474, 4, 1, '2024-10-19'),
	(1475, 4, 1, '2024-10-18'),
	(1476, 4, 1, '2024-10-17'),
	(1477, 4, 1, '2024-10-16'),
	(1478, 4, 1, '2024-10-15'),
	(1479, 4, 1, '2024-10-14'),
	(1480, 4, 1, '2024-10-13'),
	(1481, 4, 1, '2024-10-12'),
	(1482, 4, 1, '2024-10-11'),
	(1483, 4, 1, '2024-10-10'),
	(1484, 4, 1, '2024-10-09'),
	(1485, 4, 1, '2024-10-08'),
	(1486, 4, 1, '2024-10-07'),
	(1487, 4, 1, '2024-10-06'),
	(1488, 4, 1, '2024-10-05'),
	(1489, 4, 1, '2024-10-04'),
	(1490, 4, 1, '2024-10-03'),
	(1491, 4, 1, '2024-10-02'),
	(1492, 4, 1, '2024-10-01'),
	(1493, 4, 1, '2024-09-30'),
	(1494, 4, 1, '2024-09-29'),
	(1495, 4, 1, '2024-09-28'),
	(1496, 4, 1, '2024-09-27'),
	(1497, 4, 1, '2024-09-26'),
	(1498, 4, 1, '2024-09-25'),
	(1499, 4, 1, '2024-09-24'),
	(1500, 4, 1, '2024-09-23'),
	(1501, 5, 1, '2024-11-01'),
	(1502, 5, 1, '2024-10-31'),
	(1503, 5, 1, '2024-10-30'),
	(1504, 5, 1, '2024-10-29'),
	(1505, 5, 1, '2024-10-28'),
	(1506, 5, 1, '2024-10-27'),
	(1507, 5, 1, '2024-10-26'),
	(1508, 5, 1, '2024-10-25'),
	(1509, 5, 1, '2024-10-24'),
	(1510, 5, 1, '2024-10-23'),
	(1511, 5, 1, '2024-10-22'),
	(1512, 5, 1, '2024-10-21'),
	(1513, 5, 1, '2024-10-20'),
	(1514, 5, 1, '2024-10-19'),
	(1515, 5, 1, '2024-10-18'),
	(1516, 5, 1, '2024-10-17'),
	(1517, 5, 1, '2024-10-16'),
	(1518, 5, 1, '2024-10-15'),
	(1519, 5, 1, '2024-10-14'),
	(1520, 5, 1, '2024-10-13'),
	(1521, 5, 1, '2024-10-12'),
	(1522, 5, 1, '2024-10-11'),
	(1523, 5, 1, '2024-10-10'),
	(1524, 5, 1, '2024-10-09'),
	(1525, 5, 1, '2024-10-08'),
	(1526, 5, 1, '2024-10-07'),
	(1527, 5, 1, '2024-10-06'),
	(1528, 5, 1, '2024-10-05'),
	(1529, 5, 1, '2024-10-04'),
	(1530, 5, 1, '2024-10-03'),
	(1531, 5, 1, '2024-10-02'),
	(1532, 6, 1, '2024-11-01'),
	(1533, 6, 1, '2024-10-31'),
	(1534, 6, 1, '2024-10-30'),
	(1535, 6, 1, '2024-10-29'),
	(1536, 6, 1, '2024-10-28'),
	(1537, 6, 1, '2024-10-27'),
	(1538, 6, 1, '2024-10-26'),
	(1539, 6, 1, '2024-10-25'),
	(1540, 6, 1, '2024-10-24'),
	(1541, 6, 1, '2024-10-23'),
	(1542, 6, 1, '2024-10-22'),
	(1543, 6, 1, '2024-10-21'),
	(1544, 6, 1, '2024-10-20'),
	(1545, 6, 1, '2024-10-19'),
	(1546, 6, 1, '2024-10-18'),
	(1547, 6, 1, '2024-10-17'),
	(1548, 6, 1, '2024-10-16'),
	(1549, 6, 1, '2024-10-15'),
	(1550, 6, 1, '2024-10-14'),
	(1551, 6, 1, '2024-10-13'),
	(1552, 6, 1, '2024-10-12'),
	(1553, 6, 1, '2024-10-11'),
	(1554, 6, 1, '2024-10-10'),
	(1555, 6, 1, '2024-10-09'),
	(1556, 6, 1, '2024-10-08'),
	(1557, 6, 1, '2024-10-07'),
	(1558, 6, 1, '2024-10-06'),
	(1559, 6, 1, '2024-10-05'),
	(1560, 6, 1, '2024-10-04'),
	(1561, 6, 1, '2024-10-03'),
	(1562, 6, 1, '2024-10-02'),
	(1563, 6, 1, '2024-10-01'),
	(1564, 6, 1, '2024-09-30'),
	(1565, 6, 1, '2024-09-29'),
	(1566, 6, 1, '2024-09-28'),
	(1567, 6, 1, '2024-09-27'),
	(1568, 6, 1, '2024-09-26'),
	(1569, 6, 1, '2024-09-25'),
	(1570, 7, 1, '2024-11-01'),
	(1571, 7, 1, '2024-10-31'),
	(1572, 7, 1, '2024-10-30'),
	(1573, 7, 1, '2024-10-29'),
	(1574, 7, 1, '2024-10-28'),
	(1575, 7, 1, '2024-10-27'),
	(1576, 7, 1, '2024-10-26'),
	(1577, 7, 1, '2024-10-25'),
	(1578, 7, 1, '2024-10-24'),
	(1579, 7, 1, '2024-10-23'),
	(1580, 7, 1, '2024-10-22'),
	(1581, 7, 1, '2024-10-21'),
	(1582, 7, 1, '2024-10-20'),
	(1583, 7, 1, '2024-10-19'),
	(1584, 7, 1, '2024-10-18'),
	(1585, 7, 1, '2024-10-17'),
	(1586, 7, 1, '2024-10-16'),
	(1587, 7, 1, '2024-10-15'),
	(1588, 7, 1, '2024-10-14'),
	(1589, 7, 1, '2024-10-13'),
	(1590, 7, 1, '2024-10-12'),
	(1591, 7, 1, '2024-10-11'),
	(1592, 7, 1, '2024-10-10'),
	(1593, 7, 1, '2024-10-09'),
	(1594, 7, 1, '2024-10-08'),
	(1595, 7, 1, '2024-10-07'),
	(1596, 7, 1, '2024-10-06'),
	(1597, 7, 1, '2024-10-05'),
	(1598, 7, 1, '2024-10-04'),
	(1599, 7, 1, '2024-10-03'),
	(1600, 7, 1, '2024-10-02'),
	(1601, 7, 1, '2024-10-01'),
	(1602, 7, 1, '2024-09-30'),
	(1603, 7, 1, '2024-09-29'),
	(1604, 7, 1, '2024-09-28'),
	(1605, 7, 1, '2024-09-27'),
	(1606, 7, 1, '2024-09-26'),
	(1607, 7, 1, '2024-09-25'),
	(1608, 7, 1, '2024-09-24'),
	(1609, 7, 1, '2024-09-23'),
	(1610, 7, 1, '2024-09-22'),
	(1611, 8, 1, '2024-11-01'),
	(1612, 8, 1, '2024-10-31'),
	(1613, 8, 1, '2024-10-30'),
	(1614, 8, 1, '2024-10-29'),
	(1615, 8, 1, '2024-10-28'),
	(1616, 8, 1, '2024-10-27'),
	(1617, 8, 1, '2024-10-26'),
	(1618, 8, 1, '2024-10-25'),
	(1619, 8, 1, '2024-10-24'),
	(1620, 8, 1, '2024-10-23'),
	(1621, 8, 1, '2024-10-22'),
	(1622, 8, 1, '2024-10-21'),
	(1623, 8, 1, '2024-10-20'),
	(1624, 8, 1, '2024-10-19'),
	(1625, 8, 1, '2024-10-18'),
	(1626, 8, 1, '2024-10-17'),
	(1627, 8, 1, '2024-10-16'),
	(1628, 8, 1, '2024-10-15'),
	(1629, 8, 1, '2024-10-14'),
	(1630, 8, 1, '2024-10-13'),
	(1631, 8, 1, '2024-10-12'),
	(1632, 8, 1, '2024-10-11'),
	(1633, 8, 1, '2024-10-10'),
	(1634, 8, 1, '2024-10-09'),
	(1635, 8, 1, '2024-10-08'),
	(1636, 8, 1, '2024-10-07'),
	(1637, 8, 1, '2024-10-06'),
	(1638, 8, 1, '2024-10-05'),
	(1639, 8, 1, '2024-10-04'),
	(1640, 8, 1, '2024-10-03'),
	(1641, 8, 1, '2024-10-02'),
	(1642, 8, 1, '2024-10-01'),
	(1643, 8, 1, '2024-09-30'),
	(1644, 8, 1, '2024-09-29'),
	(1645, 8, 1, '2024-09-28'),
	(1646, 8, 1, '2024-09-27'),
	(1647, 8, 1, '2024-09-26'),
	(1648, 8, 1, '2024-09-25'),
	(1649, 8, 1, '2024-09-24'),
	(1650, 8, 1, '2024-09-23'),
	(1651, 8, 1, '2024-09-22'),
	(1652, 8, 1, '2024-09-21'),
	(1653, 9, 1, '2024-11-01'),
	(1654, 9, 1, '2024-10-31'),
	(1655, 9, 1, '2024-10-30'),
	(1656, 9, 1, '2024-10-29'),
	(1657, 9, 1, '2024-10-28'),
	(1658, 9, 1, '2024-10-27'),
	(1659, 9, 1, '2024-10-26'),
	(1660, 9, 1, '2024-10-25'),
	(1661, 9, 1, '2024-10-24'),
	(1662, 9, 1, '2024-10-23'),
	(1663, 9, 1, '2024-10-22'),
	(1664, 9, 1, '2024-10-21'),
	(1665, 9, 1, '2024-10-20'),
	(1666, 9, 1, '2024-10-19'),
	(1667, 9, 1, '2024-10-18'),
	(1668, 9, 1, '2024-10-17'),
	(1669, 9, 1, '2024-10-16'),
	(1670, 9, 1, '2024-10-15'),
	(1671, 9, 1, '2024-10-14'),
	(1672, 9, 1, '2024-10-13'),
	(1673, 9, 1, '2024-10-12'),
	(1674, 9, 1, '2024-10-11'),
	(1675, 9, 1, '2024-10-10'),
	(1676, 9, 1, '2024-10-09'),
	(1677, 9, 1, '2024-10-08'),
	(1678, 9, 1, '2024-10-07'),
	(1679, 9, 1, '2024-10-06'),
	(1680, 9, 1, '2024-10-05'),
	(1681, 9, 1, '2024-10-04'),
	(1682, 9, 1, '2024-10-03'),
	(1683, 9, 1, '2024-10-02'),
	(1684, 9, 1, '2024-10-01'),
	(1685, 9, 1, '2024-09-30'),
	(1686, 9, 1, '2024-09-29'),
	(1687, 9, 1, '2024-09-28'),
	(1688, 9, 1, '2024-09-27'),
	(1689, 9, 1, '2024-09-26'),
	(1690, 9, 1, '2024-09-25'),
	(1691, 9, 1, '2024-09-24'),
	(1692, 10, 1, '2024-11-01'),
	(1693, 10, 1, '2024-10-31'),
	(1694, 10, 1, '2024-10-30'),
	(1695, 10, 1, '2024-10-29'),
	(1696, 10, 1, '2024-10-28'),
	(1697, 10, 1, '2024-10-27'),
	(1698, 10, 1, '2024-10-26'),
	(1699, 10, 1, '2024-10-25'),
	(1700, 10, 1, '2024-10-24'),
	(1701, 10, 1, '2024-10-23'),
	(1702, 10, 1, '2024-10-22'),
	(1703, 10, 1, '2024-10-21'),
	(1704, 10, 1, '2024-10-20'),
	(1705, 10, 1, '2024-10-19'),
	(1706, 10, 1, '2024-10-18'),
	(1707, 10, 1, '2024-10-17'),
	(1708, 10, 1, '2024-10-16'),
	(1709, 10, 1, '2024-10-15'),
	(1710, 10, 1, '2024-10-14'),
	(1711, 10, 1, '2024-10-13'),
	(1712, 10, 1, '2024-10-12'),
	(1713, 10, 1, '2024-10-11'),
	(1714, 10, 1, '2024-10-10'),
	(1715, 10, 1, '2024-10-09'),
	(1716, 10, 1, '2024-10-08'),
	(1717, 10, 1, '2024-10-07'),
	(1718, 10, 1, '2024-10-06'),
	(1719, 10, 1, '2024-10-05'),
	(1720, 10, 1, '2024-10-04'),
	(1721, 10, 1, '2024-10-03'),
	(1722, 10, 1, '2024-10-02'),
	(1723, 10, 1, '2024-10-01'),
	(1724, 10, 1, '2024-09-30'),
	(1725, 10, 1, '2024-09-29'),
	(1726, 10, 1, '2024-09-28'),
	(1727, 10, 1, '2024-09-27'),
	(1728, 10, 1, '2024-09-26'),
	(1729, 10, 1, '2024-09-25'),
	(1730, 10, 1, '2024-09-24'),
	(1731, 10, 1, '2024-09-23'),
	(1732, 10, 1, '2024-09-22'),
	(1733, 10, 1, '2024-09-21'),
	(1734, 11, 1, '2024-11-01'),
	(1735, 11, 1, '2024-10-31'),
	(1736, 11, 1, '2024-10-30'),
	(1737, 11, 1, '2024-10-29'),
	(1738, 11, 1, '2024-10-28'),
	(1739, 11, 1, '2024-10-27'),
	(1740, 11, 1, '2024-10-26'),
	(1741, 11, 1, '2024-10-25'),
	(1742, 11, 1, '2024-10-24'),
	(1743, 11, 1, '2024-10-23'),
	(1744, 11, 1, '2024-10-22'),
	(1745, 11, 1, '2024-10-21'),
	(1746, 11, 1, '2024-10-20'),
	(1747, 11, 1, '2024-10-19'),
	(1748, 11, 1, '2024-10-18'),
	(1749, 11, 1, '2024-10-17'),
	(1750, 11, 1, '2024-10-16'),
	(1751, 11, 1, '2024-10-15'),
	(1752, 11, 1, '2024-10-14'),
	(1753, 11, 1, '2024-10-13'),
	(1754, 11, 1, '2024-10-12'),
	(1755, 11, 1, '2024-10-11'),
	(1756, 11, 1, '2024-10-10'),
	(1757, 11, 1, '2024-10-09'),
	(1758, 11, 1, '2024-10-08'),
	(1759, 11, 1, '2024-10-07'),
	(1760, 11, 1, '2024-10-06'),
	(1761, 11, 1, '2024-10-05'),
	(1762, 11, 1, '2024-10-04'),
	(1763, 11, 1, '2024-10-03'),
	(1764, 11, 1, '2024-10-02'),
	(1765, 11, 1, '2024-10-01'),
	(1766, 11, 1, '2024-09-30'),
	(1767, 11, 1, '2024-09-29'),
	(1768, 11, 1, '2024-09-28'),
	(1769, 11, 1, '2024-09-27'),
	(1770, 11, 1, '2024-09-26'),
	(1771, 12, 1, '2024-11-01'),
	(1772, 12, 1, '2024-10-31'),
	(1773, 12, 1, '2024-10-30'),
	(1774, 12, 1, '2024-10-29'),
	(1775, 12, 1, '2024-10-28'),
	(1776, 12, 1, '2024-10-27'),
	(1777, 12, 1, '2024-10-26'),
	(1778, 12, 1, '2024-10-25'),
	(1779, 12, 1, '2024-10-24'),
	(1780, 12, 1, '2024-10-23'),
	(1781, 12, 1, '2024-10-22'),
	(1782, 12, 1, '2024-10-21'),
	(1783, 12, 1, '2024-10-20'),
	(1784, 12, 1, '2024-10-19'),
	(1785, 12, 1, '2024-10-18'),
	(1786, 12, 1, '2024-10-17'),
	(1787, 12, 1, '2024-10-16'),
	(1788, 12, 1, '2024-10-15'),
	(1789, 12, 1, '2024-10-14'),
	(1790, 12, 1, '2024-10-13'),
	(1791, 12, 1, '2024-10-12'),
	(1792, 12, 1, '2024-10-11'),
	(1793, 12, 1, '2024-10-10'),
	(1794, 12, 1, '2024-10-09'),
	(1795, 12, 1, '2024-10-08'),
	(1796, 12, 1, '2024-10-07'),
	(1797, 13, 1, '2024-11-01'),
	(1798, 13, 1, '2024-10-31'),
	(1799, 13, 1, '2024-10-30'),
	(1800, 13, 1, '2024-10-29'),
	(1801, 13, 1, '2024-10-28'),
	(1802, 13, 1, '2024-10-27'),
	(1803, 13, 1, '2024-10-26'),
	(1804, 13, 1, '2024-10-25'),
	(1805, 13, 1, '2024-10-24'),
	(1806, 13, 1, '2024-10-23'),
	(1807, 13, 1, '2024-10-22'),
	(1808, 13, 1, '2024-10-21'),
	(1809, 13, 1, '2024-10-20'),
	(1810, 13, 1, '2024-10-19'),
	(1811, 13, 1, '2024-10-18'),
	(1812, 13, 1, '2024-10-17'),
	(1813, 13, 1, '2024-10-16'),
	(1814, 13, 1, '2024-10-15'),
	(1815, 13, 1, '2024-10-14'),
	(1816, 13, 1, '2024-10-13'),
	(1817, 13, 1, '2024-10-12'),
	(1818, 13, 1, '2024-10-11'),
	(1819, 13, 1, '2024-10-10'),
	(1820, 13, 1, '2024-10-09'),
	(1821, 13, 1, '2024-10-08'),
	(1822, 13, 1, '2024-10-07'),
	(1823, 13, 1, '2024-10-06'),
	(1824, 13, 1, '2024-10-05'),
	(1825, 13, 1, '2024-10-04'),
	(1826, 13, 1, '2024-10-03'),
	(1827, 14, 1, '2024-11-01'),
	(1828, 14, 1, '2024-10-31'),
	(1829, 14, 1, '2024-10-30'),
	(1830, 14, 1, '2024-10-29'),
	(1831, 14, 1, '2024-10-28'),
	(1832, 14, 1, '2024-10-27'),
	(1833, 14, 1, '2024-10-26'),
	(1834, 14, 1, '2024-10-25'),
	(1835, 14, 1, '2024-10-24'),
	(1836, 14, 1, '2024-10-23'),
	(1837, 14, 1, '2024-10-22'),
	(1838, 14, 1, '2024-10-21'),
	(1839, 14, 1, '2024-10-20'),
	(1840, 14, 1, '2024-10-19'),
	(1841, 14, 1, '2024-10-18'),
	(1842, 14, 1, '2024-10-17'),
	(1843, 14, 1, '2024-10-16'),
	(1844, 14, 1, '2024-10-15'),
	(1845, 14, 1, '2024-10-14'),
	(1846, 14, 1, '2024-10-13'),
	(1847, 14, 1, '2024-10-12'),
	(1848, 14, 1, '2024-10-11'),
	(1849, 14, 1, '2024-10-10'),
	(1850, 14, 1, '2024-10-09'),
	(1851, 14, 1, '2024-10-08'),
	(1852, 14, 1, '2024-10-07'),
	(1853, 14, 1, '2024-10-06'),
	(1854, 14, 1, '2024-10-05'),
	(1855, 14, 1, '2024-10-04'),
	(1856, 14, 1, '2024-10-03'),
	(1857, 14, 1, '2024-10-02'),
	(1858, 14, 1, '2024-10-01'),
	(1859, 14, 1, '2024-09-30'),
	(1860, 14, 1, '2024-09-29'),
	(1861, 14, 1, '2024-09-28'),
	(1862, 14, 1, '2024-09-27'),
	(1863, 15, 1, '2024-11-01'),
	(1864, 15, 1, '2024-10-31'),
	(1865, 15, 1, '2024-10-30'),
	(1866, 15, 1, '2024-10-29'),
	(1867, 15, 1, '2024-10-28'),
	(1868, 15, 1, '2024-10-27'),
	(1869, 15, 1, '2024-10-26'),
	(1870, 15, 1, '2024-10-25'),
	(1871, 15, 1, '2024-10-24'),
	(1872, 15, 1, '2024-10-23'),
	(1873, 15, 1, '2024-10-22'),
	(1874, 15, 1, '2024-10-21'),
	(1875, 15, 1, '2024-10-20'),
	(1876, 15, 1, '2024-10-19'),
	(1877, 15, 1, '2024-10-18'),
	(1878, 15, 1, '2024-10-17'),
	(1879, 15, 1, '2024-10-16'),
	(1880, 15, 1, '2024-10-15'),
	(1881, 15, 1, '2024-10-14'),
	(1882, 15, 1, '2024-10-13'),
	(1883, 15, 1, '2024-10-12'),
	(1884, 15, 1, '2024-10-11'),
	(1885, 15, 1, '2024-10-10'),
	(1886, 15, 1, '2024-10-09'),
	(1887, 15, 1, '2024-10-08'),
	(1888, 15, 1, '2024-10-07'),
	(1889, 15, 1, '2024-10-06'),
	(1890, 15, 1, '2024-10-05'),
	(1895, 16, 1, '2024-11-01'),
	(1896, 16, 1, '2024-10-31'),
	(1897, 16, 1, '2024-10-30'),
	(1898, 16, 1, '2024-10-29'),
	(1899, 16, 1, '2024-10-28'),
	(1900, 16, 1, '2024-10-27'),
	(1901, 16, 1, '2024-10-26'),
	(1902, 16, 1, '2024-10-25'),
	(1903, 16, 1, '2024-10-24'),
	(1904, 16, 1, '2024-10-23'),
	(1905, 16, 1, '2024-10-22'),
	(1906, 16, 1, '2024-10-21'),
	(1907, 16, 1, '2024-10-20'),
	(1908, 16, 1, '2024-10-19'),
	(1909, 16, 1, '2024-10-18'),
	(1910, 16, 1, '2024-10-17'),
	(1911, 16, 1, '2024-10-16'),
	(1912, 16, 1, '2024-10-15'),
	(1913, 16, 1, '2024-10-14'),
	(1914, 16, 1, '2024-10-13'),
	(1915, 16, 1, '2024-10-12'),
	(1916, 16, 1, '2024-10-11'),
	(1917, 16, 1, '2024-10-10'),
	(1918, 16, 1, '2024-10-09'),
	(1919, 16, 1, '2024-10-08'),
	(1920, 16, 1, '2024-10-07'),
	(1921, 16, 1, '2024-10-06'),
	(1922, 16, 1, '2024-10-05'),
	(1923, 16, 1, '2024-10-04'),
	(1924, 16, 1, '2024-10-03'),
	(1925, 16, 1, '2024-10-02'),
	(1926, 16, 1, '2024-10-01'),
	(1927, 17, 1, '2024-11-01'),
	(1928, 17, 1, '2024-10-31'),
	(1929, 17, 1, '2024-10-30'),
	(1930, 17, 1, '2024-10-29'),
	(1931, 17, 1, '2024-10-28'),
	(1932, 17, 1, '2024-10-27'),
	(1933, 17, 1, '2024-10-26'),
	(1934, 17, 1, '2024-10-25'),
	(1935, 17, 1, '2024-10-24'),
	(1936, 17, 1, '2024-10-23'),
	(1937, 17, 1, '2024-10-22'),
	(1938, 17, 1, '2024-10-21'),
	(1939, 17, 1, '2024-10-20'),
	(1940, 17, 1, '2024-10-19'),
	(1941, 17, 1, '2024-10-18'),
	(1942, 17, 1, '2024-10-17'),
	(1943, 17, 1, '2024-10-16'),
	(1944, 17, 1, '2024-10-15'),
	(1945, 17, 1, '2024-10-14'),
	(1946, 17, 1, '2024-10-13'),
	(1947, 17, 1, '2024-10-12'),
	(1948, 17, 1, '2024-10-11'),
	(1949, 17, 1, '2024-10-10'),
	(1950, 17, 1, '2024-10-09'),
	(1951, 17, 1, '2024-10-08'),
	(1952, 17, 1, '2024-10-07'),
	(1953, 17, 1, '2024-10-06'),
	(1954, 17, 1, '2024-10-05'),
	(1955, 17, 1, '2024-10-04'),
	(1956, 17, 1, '2024-10-03'),
	(1957, 17, 1, '2024-10-02'),
	(1958, 17, 1, '2024-10-01'),
	(1959, 17, 1, '2024-09-30'),
	(1960, 17, 1, '2024-09-29'),
	(1961, 17, 1, '2024-09-28'),
	(1962, 17, 1, '2024-09-27'),
	(1963, 17, 1, '2024-09-26'),
	(1964, 17, 1, '2024-09-25'),
	(1965, 17, 1, '2024-09-24'),
	(1966, 18, 1, '2024-11-01'),
	(1967, 18, 1, '2024-10-31'),
	(1968, 18, 1, '2024-10-30'),
	(1969, 18, 1, '2024-10-29'),
	(1970, 18, 1, '2024-10-28'),
	(1971, 18, 1, '2024-10-27'),
	(1972, 18, 1, '2024-10-26'),
	(1973, 18, 1, '2024-10-25'),
	(1974, 18, 1, '2024-10-24'),
	(1975, 18, 1, '2024-10-23'),
	(1976, 18, 1, '2024-10-22'),
	(1977, 18, 1, '2024-10-21'),
	(1978, 18, 1, '2024-10-20'),
	(1979, 18, 1, '2024-10-19'),
	(1980, 18, 1, '2024-10-18'),
	(1981, 18, 1, '2024-10-17'),
	(1982, 18, 1, '2024-10-16'),
	(1983, 18, 1, '2024-10-15'),
	(1984, 18, 1, '2024-10-14'),
	(1985, 18, 1, '2024-10-13'),
	(1986, 18, 1, '2024-10-12'),
	(1987, 18, 1, '2024-10-11'),
	(1988, 18, 1, '2024-10-10'),
	(1989, 18, 1, '2024-10-09'),
	(1990, 18, 1, '2024-10-08'),
	(1991, 18, 1, '2024-10-07'),
	(1992, 18, 1, '2024-10-06'),
	(1993, 18, 1, '2024-10-05'),
	(1994, 18, 1, '2024-10-04'),
	(1995, 18, 1, '2024-10-03'),
	(1996, 18, 1, '2024-10-02'),
	(1997, 18, 1, '2024-10-01'),
	(1998, 18, 1, '2024-09-30'),
	(1999, 18, 1, '2024-09-29'),
	(2000, 18, 1, '2024-09-28'),
	(2001, 18, 1, '2024-09-27'),
	(2002, 18, 1, '2024-09-26'),
	(2003, 18, 1, '2024-09-25'),
	(2004, 19, 1, '2024-11-01'),
	(2005, 19, 1, '2024-10-31'),
	(2006, 19, 1, '2024-10-30'),
	(2007, 19, 1, '2024-10-29'),
	(2008, 19, 1, '2024-10-28'),
	(2009, 19, 1, '2024-10-27'),
	(2010, 19, 1, '2024-10-26'),
	(2011, 19, 1, '2024-10-25'),
	(2012, 19, 1, '2024-10-24'),
	(2013, 19, 1, '2024-10-23'),
	(2014, 19, 1, '2024-10-22'),
	(2015, 19, 1, '2024-10-21'),
	(2016, 19, 1, '2024-10-20'),
	(2017, 19, 1, '2024-10-19'),
	(2018, 19, 1, '2024-10-18'),
	(2019, 19, 1, '2024-10-17'),
	(2020, 19, 1, '2024-10-16'),
	(2021, 19, 1, '2024-10-15'),
	(2022, 19, 1, '2024-10-14'),
	(2023, 19, 1, '2024-10-13'),
	(2024, 19, 1, '2024-10-12'),
	(2025, 19, 1, '2024-10-11'),
	(2026, 19, 1, '2024-10-10'),
	(2027, 19, 1, '2024-10-09'),
	(2028, 19, 1, '2024-10-08'),
	(2029, 19, 1, '2024-10-07'),
	(2030, 19, 1, '2024-10-06'),
	(2031, 19, 1, '2024-10-05'),
	(2032, 19, 1, '2024-10-04'),
	(2033, 19, 1, '2024-10-03'),
	(2034, 19, 1, '2024-10-02'),
	(2035, 19, 1, '2024-10-01'),
	(2036, 19, 1, '2024-09-30'),
	(2037, 19, 1, '2024-09-29'),
	(2038, 19, 1, '2024-09-28'),
	(2039, 19, 1, '2024-09-27'),
	(2040, 19, 1, '2024-09-26'),
	(2041, 19, 1, '2024-09-25'),
	(2042, 19, 1, '2024-09-24'),
	(2043, 19, 1, '2024-09-23'),
	(2044, 20, 1, '2024-11-01'),
	(2045, 20, 1, '2024-10-31'),
	(2046, 20, 1, '2024-10-30'),
	(2047, 20, 1, '2024-10-29'),
	(2048, 20, 1, '2024-10-28'),
	(2049, 20, 1, '2024-10-27'),
	(2050, 20, 1, '2024-10-26'),
	(2051, 20, 1, '2024-10-25'),
	(2052, 20, 1, '2024-10-24'),
	(2053, 20, 1, '2024-10-23'),
	(2054, 20, 1, '2024-10-22'),
	(2055, 20, 1, '2024-10-21'),
	(2056, 20, 1, '2024-10-20'),
	(2057, 20, 1, '2024-10-19'),
	(2058, 20, 1, '2024-10-18'),
	(2059, 20, 1, '2024-10-17'),
	(2060, 20, 1, '2024-10-16'),
	(2061, 20, 1, '2024-10-15'),
	(2062, 20, 1, '2024-10-14'),
	(2063, 20, 1, '2024-10-13'),
	(2064, 20, 1, '2024-10-12'),
	(2065, 20, 1, '2024-10-11'),
	(2066, 20, 1, '2024-10-10'),
	(2067, 20, 1, '2024-10-09'),
	(2068, 20, 1, '2024-10-08'),
	(2069, 20, 1, '2024-10-07'),
	(2070, 20, 1, '2024-10-06'),
	(2071, 20, 1, '2024-10-05'),
	(2072, 20, 1, '2024-10-04'),
	(2073, 20, 1, '2024-10-03'),
	(2074, 20, 1, '2024-10-02'),
	(2075, 20, 1, '2024-10-01'),
	(2076, 20, 1, '2024-09-30'),
	(2077, 20, 1, '2024-09-29'),
	(2078, 20, 1, '2024-09-28'),
	(2079, 20, 1, '2024-09-27'),
	(2080, 20, 1, '2024-09-26'),
	(2081, 20, 1, '2024-09-25'),
	(2082, 20, 1, '2024-09-24'),
	(2083, 20, 1, '2024-09-23'),
	(2084, 20, 1, '2024-09-22'),
	(2085, 20, 1, '2024-09-21'),
	(2086, 21, 1, '2024-11-01'),
	(2087, 21, 1, '2024-10-31'),
	(2088, 21, 1, '2024-10-30'),
	(2089, 21, 1, '2024-10-29'),
	(2090, 21, 1, '2024-10-28'),
	(2091, 21, 1, '2024-10-27'),
	(2092, 21, 1, '2024-10-26'),
	(2093, 21, 1, '2024-10-25'),
	(2094, 21, 1, '2024-10-24'),
	(2095, 21, 1, '2024-10-23'),
	(2096, 21, 1, '2024-10-22'),
	(2097, 21, 1, '2024-10-21'),
	(2098, 21, 1, '2024-10-20'),
	(2099, 21, 1, '2024-10-19'),
	(2100, 21, 1, '2024-10-18'),
	(2101, 21, 1, '2024-10-17'),
	(2102, 21, 1, '2024-10-16'),
	(2103, 21, 1, '2024-10-15'),
	(2104, 21, 1, '2024-10-14'),
	(2105, 21, 1, '2024-10-13'),
	(2106, 21, 1, '2024-10-12'),
	(2107, 21, 1, '2024-10-11'),
	(2108, 21, 1, '2024-10-10'),
	(2109, 21, 1, '2024-10-09'),
	(2110, 21, 1, '2024-10-08'),
	(2111, 21, 1, '2024-10-07'),
	(2112, 21, 1, '2024-10-06'),
	(2113, 21, 1, '2024-10-05'),
	(2114, 21, 1, '2024-10-04'),
	(2115, 21, 1, '2024-10-03'),
	(2116, 21, 1, '2024-10-02'),
	(2117, 21, 1, '2024-10-01'),
	(2118, 21, 1, '2024-09-30'),
	(2119, 21, 1, '2024-09-29'),
	(2120, 21, 1, '2024-09-28'),
	(2121, 21, 1, '2024-09-27'),
	(2122, 21, 1, '2024-09-26'),
	(2123, 21, 1, '2024-09-25'),
	(2124, 21, 1, '2024-09-24'),
	(2125, 22, 1, '2024-11-01'),
	(2126, 22, 1, '2024-10-31'),
	(2127, 22, 1, '2024-10-30'),
	(2128, 22, 1, '2024-10-29'),
	(2129, 22, 1, '2024-10-28'),
	(2130, 22, 1, '2024-10-27'),
	(2131, 22, 1, '2024-10-26'),
	(2132, 22, 1, '2024-10-25'),
	(2133, 22, 1, '2024-10-24'),
	(2134, 22, 1, '2024-10-23'),
	(2135, 22, 1, '2024-10-22'),
	(2136, 22, 1, '2024-10-21'),
	(2137, 22, 1, '2024-10-20'),
	(2138, 22, 1, '2024-10-19'),
	(2139, 22, 1, '2024-10-18'),
	(2140, 22, 1, '2024-10-17'),
	(2141, 22, 1, '2024-10-16'),
	(2142, 22, 1, '2024-10-15'),
	(2143, 22, 1, '2024-10-14'),
	(2144, 22, 1, '2024-10-13'),
	(2145, 22, 1, '2024-10-12'),
	(2146, 22, 1, '2024-10-11'),
	(2147, 22, 1, '2024-10-10'),
	(2148, 22, 1, '2024-10-09'),
	(2149, 22, 1, '2024-10-08'),
	(2150, 22, 1, '2024-10-07'),
	(2151, 22, 1, '2024-10-06'),
	(2152, 22, 1, '2024-10-05'),
	(2153, 22, 1, '2024-10-04'),
	(2154, 22, 1, '2024-10-03'),
	(2155, 22, 1, '2024-10-02'),
	(2156, 22, 1, '2024-10-01'),
	(2157, 22, 1, '2024-09-30'),
	(2158, 22, 1, '2024-09-29'),
	(2159, 23, 1, '2024-11-01'),
	(2160, 23, 1, '2024-10-31'),
	(2161, 23, 1, '2024-10-30'),
	(2162, 23, 1, '2024-10-29'),
	(2163, 23, 1, '2024-10-28'),
	(2164, 23, 1, '2024-10-27'),
	(2165, 23, 1, '2024-10-26'),
	(2166, 23, 1, '2024-10-25'),
	(2167, 23, 1, '2024-10-24'),
	(2168, 23, 1, '2024-10-23'),
	(2169, 23, 1, '2024-10-22'),
	(2170, 23, 1, '2024-10-21'),
	(2171, 23, 1, '2024-10-20'),
	(2172, 23, 1, '2024-10-19'),
	(2173, 23, 1, '2024-10-18'),
	(2174, 23, 1, '2024-10-17'),
	(2175, 23, 1, '2024-10-16'),
	(2176, 23, 1, '2024-10-15'),
	(2177, 23, 1, '2024-10-14'),
	(2178, 23, 1, '2024-10-13'),
	(2179, 23, 1, '2024-10-12'),
	(2180, 23, 1, '2024-10-11'),
	(2181, 23, 1, '2024-10-10');

-- Volcando estructura para tabla firme_como_rulo.calificaciones
CREATE TABLE IF NOT EXISTS `calificaciones` (
  `id_alumno` int NOT NULL,
  `id_materia` int NOT NULL,
  `parcial1` decimal(5,2) DEFAULT NULL,
  `parcial2` decimal(5,2) DEFAULT NULL,
  `final` decimal(5,2) DEFAULT NULL,
  UNIQUE KEY `id_alumno_2` (`id_alumno`,`id_materia`),
  UNIQUE KEY `id_alumno_3` (`id_alumno`,`id_materia`),
  KEY `id_materia` (`id_materia`),
  KEY `id_alumno` (`id_alumno`),
  CONSTRAINT `calificaciones_ibfk_1` FOREIGN KEY (`id_alumno`) REFERENCES `alumno` (`id_alumno`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Volcando datos para la tabla firme_como_rulo.calificaciones: ~0 rows (aproximadamente)

-- Volcando estructura para tabla firme_como_rulo.instituto
CREATE TABLE IF NOT EXISTS `instituto` (
  `id_instituto` int NOT NULL AUTO_INCREMENT,
  `nombre_instituto` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `direccion_instituto` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `cue_instituto` int DEFAULT NULL,
  PRIMARY KEY (`id_instituto`),
  UNIQUE KEY `CUE` (`cue_instituto`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Volcando datos para la tabla firme_como_rulo.instituto: ~1 rows (aproximadamente)
INSERT INTO `instituto` (`id_instituto`, `nombre_instituto`, `direccion_instituto`, `cue_instituto`) VALUES
	(1, 'Sedes Sapientiae', 'Santa Fe 74', 256);

-- Volcando estructura para tabla firme_como_rulo.materias
CREATE TABLE IF NOT EXISTS `materias` (
  `id_materia` int NOT NULL AUTO_INCREMENT,
  `nombre_materia` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `id_instituto` int DEFAULT NULL,
  PRIMARY KEY (`id_materia`),
  KEY `id_instituto` (`id_instituto`),
  CONSTRAINT `FK_id_instituto` FOREIGN KEY (`id_instituto`) REFERENCES `instituto` (`id_instituto`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Volcando datos para la tabla firme_como_rulo.materias: ~1 rows (aproximadamente)
INSERT INTO `materias` (`id_materia`, `nombre_materia`, `id_instituto`) VALUES
	(1, 'Programacion II', 1);

-- Volcando estructura para tabla firme_como_rulo.parametros
CREATE TABLE IF NOT EXISTS `parametros` (
  `libre` int DEFAULT NULL,
  `regular` int DEFAULT NULL,
  `promocion` int DEFAULT NULL,
  `asistencias_libre` int DEFAULT NULL,
  `asistencias_regular` int DEFAULT NULL,
  `asistencias_promocion` int DEFAULT NULL,
  `id_instituto` int DEFAULT NULL,
  KEY `id_instituto` (`id_instituto`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Volcando datos para la tabla firme_como_rulo.parametros: ~1 rows (aproximadamente)
INSERT INTO `parametros` (`libre`, `regular`, `promocion`, `asistencias_libre`, `asistencias_regular`, `asistencias_promocion`, `id_instituto`) VALUES
	(5, 6, 7, 50, 60, 70, 1);

-- Volcando estructura para tabla firme_como_rulo.profesores
CREATE TABLE IF NOT EXISTS `profesores` (
  `id_profesor` int NOT NULL AUTO_INCREMENT,
  `nombre_profesor` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `apellido_profesor` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `dni_profesor` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `legajo_profesor` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `id_instituto` int DEFAULT NULL,
  `id_materia` int DEFAULT NULL,
  PRIMARY KEY (`id_profesor`),
  UNIQUE KEY `DNI` (`dni_profesor`) USING BTREE,
  UNIQUE KEY `legajo` (`legajo_profesor`) USING BTREE,
  KEY `profesores_ibfk_1` (`id_instituto`),
  KEY `profesores_ibfk_2` (`id_materia`),
  CONSTRAINT `profesores_ibfk_1` FOREIGN KEY (`id_instituto`) REFERENCES `instituto` (`id_instituto`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `profesores_ibfk_2` FOREIGN KEY (`id_materia`) REFERENCES `materias` (`id_materia`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Volcando datos para la tabla firme_como_rulo.profesores: ~1 rows (aproximadamente)
INSERT INTO `profesores` (`id_profesor`, `nombre_profesor`, `apellido_profesor`, `dni_profesor`, `legajo_profesor`, `id_instituto`, `id_materia`) VALUES
	(1, 'Melina', 'Schimpf', '45338356', '001', 1, 1);

-- Volcando estructura para tabla firme_como_rulo.usuarios
CREATE TABLE IF NOT EXISTS `usuarios` (
  `id_usuario` int NOT NULL AUTO_INCREMENT,
  `nombre_usuario` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `apellido_usuario` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `mail_usuario` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `password_usuario` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  PRIMARY KEY (`id_usuario`),
  UNIQUE KEY `mail` (`mail_usuario`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Volcando datos para la tabla firme_como_rulo.usuarios: ~0 rows (aproximadamente)

/*!40103 SET TIME_ZONE=IFNULL(@OLD_TIME_ZONE, 'system') */;
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
