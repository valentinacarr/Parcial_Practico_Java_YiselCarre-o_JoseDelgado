-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 16-09-2026 a las 18:13:33
-- Versión del servidor: 10.4.32-MariaDB
-- Versión de PHP: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `db_inmobiliaria`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `auditoria`
--

CREATE TABLE `auditoria` (
  `id_auditoria` int(11) NOT NULL,
  `id_usuario` int(11) DEFAULT NULL,
  `accion` varchar(150) NOT NULL,
  `detalle` varchar(255) DEFAULT NULL,
  `fecha_hora` datetime NOT NULL DEFAULT current_timestamp(),
  `ip_origen` varchar(45) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `auditoria`
--

INSERT INTO `auditoria` (`id_auditoria`, `id_usuario`, `accion`, `detalle`, `fecha_hora`, `ip_origen`) VALUES
(1, 1, 'LOGIN', 'Inicio de sesion exitoso', '2026-09-14 19:35:54', '192.168.1.10'),
(2, 2, 'LOGIN', 'Inicio de sesion exitoso', '2026-09-14 19:35:54', '192.168.1.11'),
(3, 2, 'CREAR_PROPIEDAD', 'Publico MI-0001', '2026-09-14 19:35:54', '192.168.1.11'),
(4, 3, 'LOGIN', 'Inicio de sesion exitoso', '2026-09-14 19:35:54', '192.168.1.12'),
(5, 3, 'EDITAR_PROPIEDAD', 'Actualizo precio de MI-0003', '2026-09-14 19:35:54', '192.168.1.12'),
(6, 5, 'LOGIN', 'Inicio de sesion exitoso', '2026-09-14 19:35:54', '192.168.1.20'),
(7, 5, 'CREAR_SOLICITUD', 'Radico solicitud de compra', '2026-09-14 19:35:54', '192.168.1.20'),
(8, 1, 'ASIGNAR_ROL', 'Asigno rol INMOBILIARIA a usuario 4', '2026-09-14 19:35:54', '192.168.1.10'),
(9, 6, 'LOGIN_FALLIDO', 'Contrasena incorrecta', '2026-09-14 19:35:54', '192.168.1.21'),
(10, 1, 'INACTIVAR_CUENTA', 'Inactivo cuenta de usuario 10', '2026-09-14 19:35:54', '192.168.1.10');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `caracteristica`
--

CREATE TABLE `caracteristica` (
  `id_caracteristica` int(11) NOT NULL,
  `nombre_caracteristica` varchar(60) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `caracteristica`
--

INSERT INTO `caracteristica` (`id_caracteristica`, `nombre_caracteristica`) VALUES
(8, 'Amoblado'),
(3, 'Ascensor'),
(5, 'Balcon'),
(4, 'Gimnasio'),
(6, 'Jardin'),
(2, 'Parqueadero'),
(1, 'Piscina'),
(7, 'Seguridad 24h');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `cita`
--

CREATE TABLE `cita` (
  `id_cita` int(11) NOT NULL,
  `id_propiedad` int(11) NOT NULL,
  `id_cliente` int(11) NOT NULL,
  `fecha_hora` datetime NOT NULL,
  `estado` enum('PENDIENTE','CONFIRMADA','RECHAZADA','REALIZADA','CANCELADA') NOT NULL DEFAULT 'PENDIENTE',
  `observaciones` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `cita`
--

INSERT INTO `cita` (`id_cita`, `id_propiedad`, `id_cliente`, `fecha_hora`, `estado`, `observaciones`) VALUES
(1, 1, 5, '2026-09-02 09:00:00', 'CONFIRMADA', 'Cliente interesado en compra'),
(2, 2, 6, '2026-09-02 10:30:00', 'PENDIENTE', NULL),
(3, 3, 7, '2026-09-03 14:00:00', 'PENDIENTE', NULL),
(4, 4, 8, '2026-09-03 15:00:00', 'REALIZADA', 'Visita completada'),
(5, 5, 9, '2026-09-04 09:00:00', 'REALIZADA', NULL),
(6, 6, 10, '2026-09-04 11:00:00', 'CANCELADA', 'Cliente cancelo'),
(7, 7, 11, '2026-09-05 08:30:00', 'PENDIENTE', NULL),
(8, 9, 12, '2026-09-05 16:00:00', 'PENDIENTE', NULL),
(9, 10, 5, '2026-09-06 09:00:00', 'CONFIRMADA', NULL),
(10, 11, 6, '2026-09-06 10:00:00', 'PENDIENTE', NULL),
(11, 12, 1, '2026-12-21 10:50:00', 'REALIZADA', 'comodidad');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `ciudad`
--

CREATE TABLE `ciudad` (
  `id_ciudad` int(11) NOT NULL,
  `nombre_ciudad` varchar(80) NOT NULL,
  `departamento` varchar(80) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `ciudad`
--

INSERT INTO `ciudad` (`id_ciudad`, `nombre_ciudad`, `departamento`) VALUES
(1, 'Bucaramanga', 'Santander'),
(2, 'Bogota', 'Cundinamarca'),
(3, 'Medellin', 'Antioquia'),
(4, 'Cali', 'Valle del Cauca'),
(5, 'Cartagena', 'Bolivar'),
(6, 'Barranquilla', 'Atlantico'),
(7, 'Pereira', 'Risaralda'),
(8, 'Santa Marta', 'Magdalena'),
(9, 'Ibague', 'Tolima'),
(10, 'Cucuta', 'Norte de Santander');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `documento_solicitud`
--

CREATE TABLE `documento_solicitud` (
  `id_documento` int(11) NOT NULL,
  `id_solicitud` int(11) NOT NULL,
  `nombre_documento` varchar(120) NOT NULL,
  `url_archivo` varchar(255) NOT NULL,
  `fecha_carga` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `documento_solicitud`
--

INSERT INTO `documento_solicitud` (`id_documento`, `id_solicitud`, `nombre_documento`, `url_archivo`, `fecha_carga`) VALUES
(1, 1, 'Cedula.pdf', '/docs/sol1_cedula.pdf', '2026-09-14 19:35:54'),
(2, 1, 'Certificado_laboral.pdf', '/docs/sol1_laboral.pdf', '2026-09-14 19:35:54'),
(3, 2, 'Cedula.pdf', '/docs/sol2_cedula.pdf', '2026-09-14 19:35:54'),
(4, 3, 'Cedula.pdf', '/docs/sol3_cedula.pdf', '2026-09-14 19:35:54'),
(5, 4, 'Cedula.pdf', '/docs/sol4_cedula.pdf', '2026-09-14 19:35:54'),
(6, 5, 'Cedula.pdf', '/docs/sol5_cedula.pdf', '2026-09-14 19:35:54'),
(7, 6, 'Cedula.pdf', '/docs/sol6_cedula.pdf', '2026-09-14 19:35:54'),
(8, 7, 'Cedula.pdf', '/docs/sol7_cedula.pdf', '2026-09-14 19:35:54'),
(9, 8, 'Cedula.pdf', '/docs/sol8_cedula.pdf', '2026-09-14 19:35:54'),
(10, 9, 'Cedula.pdf', '/docs/sol9_cedula.pdf', '2026-09-14 19:35:54');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `favorito`
--

CREATE TABLE `favorito` (
  `id_usuario` int(11) NOT NULL,
  `id_propiedad` int(11) NOT NULL,
  `fecha_marcado` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `favorito`
--

INSERT INTO `favorito` (`id_usuario`, `id_propiedad`, `fecha_marcado`) VALUES
(5, 1, '2026-09-14 19:35:54'),
(5, 3, '2026-09-14 19:35:54'),
(6, 2, '2026-09-14 19:35:54'),
(6, 4, '2026-09-14 19:35:54'),
(7, 1, '2026-09-14 19:35:54'),
(8, 5, '2026-09-14 19:35:54'),
(9, 6, '2026-09-14 19:35:54'),
(10, 7, '2026-09-14 19:35:54'),
(11, 8, '2026-09-14 19:35:54'),
(12, 9, '2026-09-14 19:35:54');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `imagen_propiedad`
--

CREATE TABLE `imagen_propiedad` (
  `id_imagen` int(11) NOT NULL,
  `id_propiedad` int(11) NOT NULL,
  `url_imagen` varchar(255) NOT NULL,
  `es_portada` tinyint(1) NOT NULL DEFAULT 0,
  `fecha_carga` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `imagen_propiedad`
--

INSERT INTO `imagen_propiedad` (`id_imagen`, `id_propiedad`, `url_imagen`, `es_portada`, `fecha_carga`) VALUES
(1, 1, 'https://tse2.mm.bing.net/th/id/OIP.nfa0MpvK9Pah9KhgIhAYXgHaEs?r=0&pid=Api&P=0&h=180', 1, '2026-09-14 19:35:53'),
(2, 1, 'https://tse1.mm.bing.net/th/id/OIP.LLKfm02e1qrvvhtUuy59igHaE8?r=0&pid=Api&P=0&h=180', 0, '2026-09-14 19:35:53'),
(3, 2, 'https://tse2.mm.bing.net/th/id/OIP.UNXyGbKYrSTZt9z5qKpDoQHaEm?r=0&pid=Api&P=0&h=180', 1, '2026-09-14 19:35:53'),
(4, 2, 'https://tse4.mm.bing.net/th/id/OIP.n3QuQSO2ToiGLePcmPHawgHaHa?r=0&pid=Api&P=0&h=180', 0, '2026-09-14 19:35:53'),
(5, 3, 'https://tse3.mm.bing.net/th/id/OIP.g6sUNa6-vFTMm9w7RpN8pAHaE7?r=0&pid=Api&P=0&h=180 ', 1, '2026-09-14 19:35:53'),
(6, 3, 'https://tse3.mm.bing.net/th/id/OIP.WXw0s6eL7C4K19kry241UgHaEp?r=0&pid=Api&P=0&h=180', 0, '2026-09-14 19:35:53'),
(7, 4, 'https://tse1.mm.bing.net/th/id/OIP.h6ElH-ELhz7CWqFd8MB75wHaEc?r=0&pid=Api&P=0&h=180', 1, '2026-09-14 19:35:53'),
(8, 4, 'https://tse2.mm.bing.net/th/id/OIP.SkJB21K3_f2i38ZUw0x-DQHaDt?r=0&pid=Api&P=0&h=180', 0, '2026-09-14 19:35:53'),
(9, 5, 'https://tse1.mm.bing.net/th/id/OIP.VNzF6AUviWPsb8Ag5DimDwHaEo?r=0&pid=Api&P=0&h=180', 1, '2026-09-14 19:35:53'),
(10, 5, 'https://tse2.mm.bing.net/th/id/OIP.OF_Y-II_-mhcJbtLnIzMIwHaEO?r=0&pid=Api&P=0&h=180', 0, '2026-09-14 19:35:53'),
(11, 6, 'https://tse3.mm.bing.net/th/id/OIP.KGcM9tFeGzuxVfDXTVCZBAHaEh?r=0&pid=Api&P=0&h=180', 1, '2026-09-14 19:35:53'),
(12, 6, 'https://tse3.mm.bing.net/th/id/OIP.fgGD_XPkfcHAY7pOq6XqqQHaEK?r=0&pid=Api&P=0&h=180', 0, '2026-09-14 19:35:53'),
(13, 7, 'https://tse3.mm.bing.net/th/id/OIP.9ltqiB4Bcg6VvH10sLWf1AHaEf?r=0&pid=Api&P=0&h=180', 1, '2026-09-14 19:35:53'),
(14, 7, 'https://tse3.mm.bing.net/th/id/OIP.EtbcRft1S6P1-g5m612wwwHaEK?r=0&pid=Api&P=0&h=180', 0, '2026-09-14 19:35:53'),
(15, 8, 'https://tse4.mm.bing.net/th/id/OIP._M65BvKnTh0AZkV7RUeVkgHaE8?r=0&pid=Api&P=0&h=180', 1, '2026-09-14 19:35:53'),
(16, 8, 'https://tse2.mm.bing.net/th/id/OIP.578Xh4w4Vy9rYoIjTaLNtwHaE_?r=0&pid=Api&P=0&h=180', 0, '2026-09-14 19:35:53'),
(17, 9, 'https://tse3.mm.bing.net/th/id/OIP.s3usb4y26UhHA_Yj8qtZGwHaEj?r=0&pid=Api&P=0&h=180', 1, '2026-09-14 19:35:53'),
(18, 9, 'https://tse3.mm.bing.net/th/id/OIP.XK6Q_yqNFHsOL82893VsngHaFj?r=0&pid=Api&P=0&h=180', 0, '2026-09-14 19:35:53'),
(19, 10, 'https://tse1.mm.bing.net/th/id/OIP.zFtYui7LrRtxxA57w7ncBwHaFj?r=0&pid=Api&P=0&h=180', 1, '2026-09-14 19:35:53'),
(20, 10, 'https://tse3.mm.bing.net/th/id/OIP.JV7X9D4PWZbAcLGKFoHSmgHaFj?r=0&pid=Api&P=0&h=180', 0, '2026-09-14 19:35:53'),
(21, 11, 'https://tse2.mm.bing.net/th/id/OIP.ku35LyI_DWs-w89B8gDDRQHaEQ?r=0&pid=Api&P=0&h=180', 1, '2026-09-14 19:35:53'),
(22, 11, ' https://tse4.mm.bing.net/th/id/OIP.D6TBEGwH598-DUB9qaZdOAHaEK?r=0&pid=Api&P=0&h=180', 0, '2026-09-14 19:35:53'),
(23, 12, 'https://tse1.mm.bing.net/th/id/OIP.9HtmcNj8jXJKcB8wr9MuCQHaLH?r=0&pid=Api&P=0&h=180', 1, '2026-09-14 19:35:53'),
(24, 12, 'https://tse1.mm.bing.net/th/id/OIP.vCMSsSTygJV45LZExwAMLwHaEK?r=0&pid=Api&P=0&h=180', 0, '2026-09-14 19:35:53');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `inmobiliaria`
--

CREATE TABLE `inmobiliaria` (
  `id_inmobiliaria` int(11) NOT NULL,
  `id_usuario` int(11) NOT NULL,
  `nombre_comercial` varchar(120) NOT NULL,
  `nit` varchar(30) NOT NULL,
  `telefono_contacto` varchar(20) DEFAULT NULL,
  `direccion` varchar(150) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `inmobiliaria`
--

INSERT INTO `inmobiliaria` (`id_inmobiliaria`, `id_usuario`, `nombre_comercial`, `nit`, `telefono_contacto`, `direccion`) VALUES
(1, 2, 'Vivienda Segura S.A.S', '900123456-1', '6076001234', 'Cra 20 #30-10, Bucaramanga'),
(2, 3, 'Raices Inmobiliaria', '900123457-2', '6076001235', 'Cra 21 #31-11, Bogota'),
(3, 4, 'Hogar360', '900123458-3', '6076001236', 'Cra 22 #32-12, Medellin');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `perfil`
--

CREATE TABLE `perfil` (
  `id_perfil` int(11) NOT NULL,
  `id_usuario` int(11) NOT NULL,
  `nombres` varchar(80) NOT NULL,
  `apellidos` varchar(80) NOT NULL,
  `documento` varchar(30) NOT NULL,
  `telefono` varchar(20) DEFAULT NULL,
  `direccion` varchar(150) DEFAULT NULL,
  `foto` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `perfil`
--

INSERT INTO `perfil` (`id_perfil`, `id_usuario`, `nombres`, `apellidos`, `documento`, `telefono`, `direccion`, `foto`) VALUES
(1, 1, 'Laura', 'Gomez Restrepo', '1091234561', '3001234561', 'Cra 10 #20-30, Bucaramanga', NULL),
(2, 2, 'Carlos', 'Perez Duarte', '1091234562', '3001234562', 'Cra 11 #21-31, Bucaramanga', NULL),
(3, 3, 'Marta', 'Rojas Villa', '1091234563', '3001234563', 'Cra 12 #22-32, Bogota', NULL),
(4, 4, 'Andres', 'Suarez Nino', '1091234564', '3001234564', 'Cra 13 #23-33, Medellin', NULL),
(5, 5, 'Diana', 'Castro Leon', '1091234565', '3001234565', 'Calle 5 #10-15, Bucaramanga', NULL),
(6, 6, 'Felipe', 'Ortiz Mora', '1091234566', '3001234566', 'Calle 6 #11-16, Bogota', NULL),
(7, 7, 'Valentina', 'Rios Cano', '1091234567', '3001234567', 'Calle 7 #12-17, Cali', NULL),
(8, 8, 'Julian', 'Vargas Diaz', '1091234568', '3001234568', 'Calle 8 #13-18, Medellin', NULL),
(9, 9, 'Camila', 'Herrera Paz', '1091234569', '3001234569', 'Calle 9 #14-19, Cartagena', NULL),
(10, 10, 'Santiago', 'Mejia Cruz', '1091234570', '3001234570', 'Calle 10 #15-20, Pereira', NULL),
(11, 11, 'Isabella', 'Torres Gil', '1091234571', '3001234571', 'Calle 11 #16-21, Bucaramanga', NULL),
(12, 12, 'Mateo', 'Salazar Reyes', '1091234572', '3001234572', 'Calle 12 #17-22, Cucuta', NULL);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `propiedad`
--

CREATE TABLE `propiedad` (
  `id_propiedad` int(11) NOT NULL,
  `matricula_inmobiliaria` varchar(50) NOT NULL,
  `id_inmobiliaria` int(11) NOT NULL,
  `id_ciudad` int(11) NOT NULL,
  `id_tipo` int(11) NOT NULL,
  `titulo` varchar(150) NOT NULL,
  `descripcion` text DEFAULT NULL,
  `precio` decimal(14,2) NOT NULL,
  `area_m2` decimal(8,2) DEFAULT NULL,
  `habitaciones` int(11) DEFAULT 0,
  `banos` int(11) DEFAULT 0,
  `estado` enum('DISPONIBLE','RESERVADA','VENDIDA','ARRENDADA','INACTIVA') NOT NULL DEFAULT 'DISPONIBLE',
  `fecha_publicacion` datetime NOT NULL DEFAULT current_timestamp(),
  `activo` tinyint(1) NOT NULL DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `propiedad`
--

INSERT INTO `propiedad` (`id_propiedad`, `matricula_inmobiliaria`, `id_inmobiliaria`, `id_ciudad`, `id_tipo`, `titulo`, `descripcion`, `precio`, `area_m2`, `habitaciones`, `banos`, `estado`, `fecha_publicacion`, `activo`) VALUES
(1, 'MI-0001', 1, 1, 2, 'Apartamento Cabecera', 'Apartamento moderno cerca al parque', 320000000.00, 85.00, 3, 2, 'DISPONIBLE', '2026-09-14 19:35:53', 1),
(2, 'MI-0002', 1, 1, 1, 'Casa Campestre Floridablanca', 'Casa con jardin amplio', 560000000.00, 220.00, 4, 3, 'DISPONIBLE', '2026-09-14 19:35:53', 1),
(3, 'MI-0003', 2, 2, 2, 'Apartamento Chapinero', 'Vista panoramica a la ciudad', 480000000.00, 72.00, 2, 2, 'DISPONIBLE', '2026-09-14 19:35:53', 1),
(4, 'MI-0004', 2, 2, 3, 'Local Zona Rosa', 'Local comercial esquinero', 700000000.00, 60.00, 0, 1, 'DISPONIBLE', '2026-09-14 19:35:53', 1),
(5, 'MI-0005', 3, 3, 4, 'Oficina El Poblado', 'Oficina amoblada, edificio corporativo', 390000000.00, 45.00, 0, 1, 'DISPONIBLE', '2026-09-14 19:35:53', 1),
(6, 'MI-0006', 3, 3, 1, 'Casa Laureles', 'Casa de dos pisos remodelada', 610000000.00, 180.00, 3, 3, 'RESERVADA', '2026-09-14 19:35:53', 1),
(7, 'MI-0007', 1, 4, 2, 'Apartamento Ciudad Jardin', 'Cerca a centros comerciales', 350000000.00, 78.00, 3, 2, 'DISPONIBLE', '2026-09-14 19:35:53', 1),
(8, 'MI-0008', 1, 5, 5, 'Lote Turistico Cartagena', 'Terreno frente al mar', 900000000.00, 500.00, 0, 0, 'DISPONIBLE', '2026-09-14 19:35:53', 1),
(9, 'MI-0009', 2, 1, 2, 'Apartamento Cabecera Norte', 'Excelente ubicacion', 300000000.00, 68.00, 2, 2, 'ARRENDADA', '2026-09-14 19:35:53', 1),
(10, 'MI-0010', 2, 6, 1, 'Casa Barranquilla Norte', 'Amplia y ventilada', 540000000.00, 200.00, 4, 3, 'DISPONIBLE', '2026-09-14 19:35:53', 1),
(11, 'MI-0011', 3, 7, 3, 'Local Centro Pereira', 'Alto flujo peatonal', 250000000.00, 40.00, 0, 1, 'DISPONIBLE', '2026-09-14 19:35:53', 1),
(12, 'MI-0012', 3, 1, 2, 'Apartaestudio Cabecera', 'Ideal para estudiantes', 180000000.00, 35.00, 1, 1, 'INACTIVA', '2026-09-14 19:35:53', 1),
(13, 'MIT-0014', 1, 4, 3, 'Hermoso apartamento con vista al parque de los sueÃ±os', 'conjunto cerrado', 250000000.00, 75.50, 3, 2, 'DISPONIBLE', '2026-09-15 20:03:40', 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `propiedad_caracteristica`
--

CREATE TABLE `propiedad_caracteristica` (
  `id_propiedad` int(11) NOT NULL,
  `id_caracteristica` int(11) NOT NULL,
  `cantidad` int(11) NOT NULL DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `propiedad_caracteristica`
--

INSERT INTO `propiedad_caracteristica` (`id_propiedad`, `id_caracteristica`, `cantidad`) VALUES
(1, 2, 1),
(1, 3, 1),
(1, 7, 1),
(2, 2, 2),
(2, 6, 1),
(2, 7, 1),
(3, 3, 1),
(3, 5, 1),
(4, 2, 1),
(4, 7, 1),
(5, 3, 1),
(5, 8, 1),
(6, 2, 1),
(6, 6, 1),
(7, 2, 1),
(7, 4, 1),
(7, 7, 1),
(8, 6, 1),
(9, 3, 1),
(9, 5, 1),
(13, 2, 1),
(13, 5, 1),
(13, 8, 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `rol`
--

CREATE TABLE `rol` (
  `id_rol` int(11) NOT NULL,
  `nombre_rol` varchar(30) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `rol`
--

INSERT INTO `rol` (`id_rol`, `nombre_rol`) VALUES
(1, 'ADMINISTRADOR'),
(3, 'CLIENTE'),
(2, 'INMOBILIARIA');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `solicitud`
--

CREATE TABLE `solicitud` (
  `id_solicitud` int(11) NOT NULL,
  `id_propiedad` int(11) NOT NULL,
  `id_cliente` int(11) NOT NULL,
  `tipo_solicitud` enum('COMPRA','ARRIENDO') NOT NULL,
  `estado` enum('PENDIENTE','APROBADA','RECHAZADA') NOT NULL DEFAULT 'PENDIENTE',
  `fecha_solicitud` datetime NOT NULL DEFAULT current_timestamp(),
  `observaciones` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `solicitud`
--

INSERT INTO `solicitud` (`id_solicitud`, `id_propiedad`, `id_cliente`, `tipo_solicitud`, `estado`, `fecha_solicitud`, `observaciones`) VALUES
(1, 1, 5, 'COMPRA', 'PENDIENTE', '2026-09-14 19:35:54', NULL),
(2, 2, 6, 'COMPRA', 'APROBADA', '2026-09-14 19:35:54', 'Documentacion completa'),
(3, 3, 7, 'ARRIENDO', 'PENDIENTE', '2026-09-14 19:35:54', NULL),
(4, 4, 8, 'ARRIENDO', 'RECHAZADA', '2026-09-14 19:35:54', 'Documentos incompletos'),
(5, 5, 9, 'ARRIENDO', 'APROBADA', '2026-09-14 19:35:54', NULL),
(6, 6, 10, 'COMPRA', 'PENDIENTE', '2026-09-14 19:35:54', NULL),
(7, 7, 11, 'ARRIENDO', 'PENDIENTE', '2026-09-14 19:35:54', NULL),
(8, 9, 12, 'ARRIENDO', 'APROBADA', '2026-09-14 19:35:54', NULL),
(9, 10, 5, 'COMPRA', 'PENDIENTE', '2026-09-14 19:35:54', NULL),
(10, 11, 6, 'ARRIENDO', 'APROBADA', '2026-09-14 19:35:54', NULL),
(11, 1, 11, 'COMPRA', 'APROBADA', '2026-09-14 20:09:41', 'que sea en una zona residencial');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tipo_propiedad`
--

CREATE TABLE `tipo_propiedad` (
  `id_tipo` int(11) NOT NULL,
  `nombre_tipo` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `tipo_propiedad`
--

INSERT INTO `tipo_propiedad` (`id_tipo`, `nombre_tipo`) VALUES
(2, 'Apartamento'),
(1, 'Casa'),
(3, 'Local'),
(4, 'Oficina'),
(5, 'Terreno');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `usuario`
--

CREATE TABLE `usuario` (
  `id_usuario` int(11) NOT NULL,
  `correo` varchar(120) NOT NULL,
  `contrasena_hash` varchar(255) NOT NULL,
  `salt` varchar(32) NOT NULL DEFAULT '',
  `estado` enum('ACTIVO','INACTIVO') NOT NULL DEFAULT 'ACTIVO',
  `intentos_fallidos` int(11) NOT NULL DEFAULT 0,
  `bloqueado_hasta` datetime DEFAULT NULL,
  `fecha_registro` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `usuario`
--

INSERT INTO `usuario` (`id_usuario`, `correo`, `contrasena_hash`, `salt`, `estado`, `intentos_fallidos`, `bloqueado_hasta`, `fecha_registro`) VALUES
(1, 'admin@inmoapp.com', '8d969eef6ecad3c29a3a629280e686cf0c3f5d5a86aff3ca12020c923adc6c92', '', 'ACTIVO', 0, NULL, '2026-09-14 19:35:51'),
(2, 'agenteuno@inmoapp.com', '8d969eef6ecad3c29a3a629280e686cf0c3f5d5a86aff3ca12020c923adc6c92', '', 'ACTIVO', 0, NULL, '2026-09-14 19:35:51'),
(3, 'agentedos@inmoapp.com', '8d969eef6ecad3c29a3a629280e686cf0c3f5d5a86aff3ca12020c923adc6c92', '', 'ACTIVO', 0, NULL, '2026-09-14 19:35:51'),
(4, 'agentetres@inmoapp.com', '8d969eef6ecad3c29a3a629280e686cf0c3f5d5a86aff3ca12020c923adc6c92', '', 'ACTIVO', 0, NULL, '2026-09-14 19:35:51'),
(5, 'cliente1@correo.com', '8d969eef6ecad3c29a3a629280e686cf0c3f5d5a86aff3ca12020c923adc6c92', '', 'ACTIVO', 0, NULL, '2026-09-14 19:35:51'),
(6, 'cliente2@correo.com', '8d969eef6ecad3c29a3a629280e686cf0c3f5d5a86aff3ca12020c923adc6c92', '', 'ACTIVO', 0, NULL, '2026-09-14 19:35:51'),
(7, 'cliente3@correo.com', '8d969eef6ecad3c29a3a629280e686cf0c3f5d5a86aff3ca12020c923adc6c92', '', 'ACTIVO', 0, NULL, '2026-09-14 19:35:51'),
(8, 'cliente4@correo.com', '8d969eef6ecad3c29a3a629280e686cf0c3f5d5a86aff3ca12020c923adc6c92', '', 'ACTIVO', 0, NULL, '2026-09-14 19:35:51'),
(9, 'cliente5@correo.com', '8d969eef6ecad3c29a3a629280e686cf0c3f5d5a86aff3ca12020c923adc6c92', '', 'ACTIVO', 0, NULL, '2026-09-14 19:35:51'),
(10, 'cliente6@correo.com', '8d969eef6ecad3c29a3a629280e686cf0c3f5d5a86aff3ca12020c923adc6c92', '', 'ACTIVO', 0, NULL, '2026-09-14 19:35:51'),
(11, 'cliente7@correo.com', '8d969eef6ecad3c29a3a629280e686cf0c3f5d5a86aff3ca12020c923adc6c92', '', 'ACTIVO', 0, NULL, '2026-09-14 19:35:51'),
(12, 'cliente8@correo.com', '8d969eef6ecad3c29a3a629280e686cf0c3f5d5a86aff3ca12020c923adc6c92', '', 'ACTIVO', 0, NULL, '2026-09-14 19:35:51');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `usuario_rol`
--

CREATE TABLE `usuario_rol` (
  `id_usuario` int(11) NOT NULL,
  `id_rol` int(11) NOT NULL,
  `fecha_asignacion` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `usuario_rol`
--

INSERT INTO `usuario_rol` (`id_usuario`, `id_rol`, `fecha_asignacion`) VALUES
(1, 1, '2026-09-14 19:35:51'),
(2, 2, '2026-09-14 19:35:51'),
(3, 2, '2026-09-14 19:35:51'),
(4, 2, '2026-09-14 19:35:51'),
(5, 3, '2026-09-14 19:35:51'),
(6, 3, '2026-09-14 19:35:51'),
(7, 3, '2026-09-14 19:35:51'),
(8, 3, '2026-09-14 19:35:51'),
(9, 3, '2026-09-14 19:35:51'),
(10, 3, '2026-09-14 19:35:51'),
(11, 3, '2026-09-16 04:59:27'),
(12, 3, '2026-09-15 20:24:51');

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `auditoria`
--
ALTER TABLE `auditoria`
  ADD PRIMARY KEY (`id_auditoria`),
  ADD KEY `fk_auditoria_usuario` (`id_usuario`);

--
-- Indices de la tabla `caracteristica`
--
ALTER TABLE `caracteristica`
  ADD PRIMARY KEY (`id_caracteristica`),
  ADD UNIQUE KEY `uk_caracteristica_nombre` (`nombre_caracteristica`);

--
-- Indices de la tabla `cita`
--
ALTER TABLE `cita`
  ADD PRIMARY KEY (`id_cita`),
  ADD UNIQUE KEY `uk_cita_propiedad_fecha` (`id_propiedad`,`fecha_hora`),
  ADD KEY `fk_cita_cliente` (`id_cliente`);

--
-- Indices de la tabla `ciudad`
--
ALTER TABLE `ciudad`
  ADD PRIMARY KEY (`id_ciudad`),
  ADD UNIQUE KEY `uk_ciudad_nombre` (`nombre_ciudad`);

--
-- Indices de la tabla `documento_solicitud`
--
ALTER TABLE `documento_solicitud`
  ADD PRIMARY KEY (`id_documento`),
  ADD KEY `fk_documento_solicitud` (`id_solicitud`);

--
-- Indices de la tabla `favorito`
--
ALTER TABLE `favorito`
  ADD PRIMARY KEY (`id_usuario`,`id_propiedad`),
  ADD KEY `fk_favorito_propiedad` (`id_propiedad`);

--
-- Indices de la tabla `imagen_propiedad`
--
ALTER TABLE `imagen_propiedad`
  ADD PRIMARY KEY (`id_imagen`),
  ADD KEY `fk_imagen_propiedad` (`id_propiedad`);

--
-- Indices de la tabla `inmobiliaria`
--
ALTER TABLE `inmobiliaria`
  ADD PRIMARY KEY (`id_inmobiliaria`),
  ADD UNIQUE KEY `uk_inmobiliaria_usuario` (`id_usuario`),
  ADD UNIQUE KEY `uk_inmobiliaria_nit` (`nit`);

--
-- Indices de la tabla `perfil`
--
ALTER TABLE `perfil`
  ADD PRIMARY KEY (`id_perfil`),
  ADD UNIQUE KEY `uk_perfil_usuario` (`id_usuario`),
  ADD UNIQUE KEY `uk_perfil_documento` (`documento`);

--
-- Indices de la tabla `propiedad`
--
ALTER TABLE `propiedad`
  ADD PRIMARY KEY (`id_propiedad`),
  ADD UNIQUE KEY `uk_propiedad_matricula` (`matricula_inmobiliaria`),
  ADD KEY `fk_propiedad_inmobiliaria` (`id_inmobiliaria`),
  ADD KEY `fk_propiedad_ciudad` (`id_ciudad`),
  ADD KEY `fk_propiedad_tipo` (`id_tipo`);

--
-- Indices de la tabla `propiedad_caracteristica`
--
ALTER TABLE `propiedad_caracteristica`
  ADD PRIMARY KEY (`id_propiedad`,`id_caracteristica`),
  ADD KEY `fk_propcarac_caracteristica` (`id_caracteristica`);

--
-- Indices de la tabla `rol`
--
ALTER TABLE `rol`
  ADD PRIMARY KEY (`id_rol`),
  ADD UNIQUE KEY `uk_rol_nombre` (`nombre_rol`);

--
-- Indices de la tabla `solicitud`
--
ALTER TABLE `solicitud`
  ADD PRIMARY KEY (`id_solicitud`),
  ADD KEY `fk_solicitud_propiedad` (`id_propiedad`),
  ADD KEY `fk_solicitud_cliente` (`id_cliente`);

--
-- Indices de la tabla `tipo_propiedad`
--
ALTER TABLE `tipo_propiedad`
  ADD PRIMARY KEY (`id_tipo`),
  ADD UNIQUE KEY `uk_tipo_nombre` (`nombre_tipo`);

--
-- Indices de la tabla `usuario`
--
ALTER TABLE `usuario`
  ADD PRIMARY KEY (`id_usuario`),
  ADD UNIQUE KEY `uk_usuario_correo` (`correo`);

--
-- Indices de la tabla `usuario_rol`
--
ALTER TABLE `usuario_rol`
  ADD PRIMARY KEY (`id_usuario`,`id_rol`),
  ADD KEY `fk_usuariorol_rol` (`id_rol`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `auditoria`
--
ALTER TABLE `auditoria`
  MODIFY `id_auditoria` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT de la tabla `caracteristica`
--
ALTER TABLE `caracteristica`
  MODIFY `id_caracteristica` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT de la tabla `cita`
--
ALTER TABLE `cita`
  MODIFY `id_cita` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT de la tabla `ciudad`
--
ALTER TABLE `ciudad`
  MODIFY `id_ciudad` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT de la tabla `documento_solicitud`
--
ALTER TABLE `documento_solicitud`
  MODIFY `id_documento` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT de la tabla `imagen_propiedad`
--
ALTER TABLE `imagen_propiedad`
  MODIFY `id_imagen` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=25;

--
-- AUTO_INCREMENT de la tabla `inmobiliaria`
--
ALTER TABLE `inmobiliaria`
  MODIFY `id_inmobiliaria` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de la tabla `perfil`
--
ALTER TABLE `perfil`
  MODIFY `id_perfil` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT de la tabla `propiedad`
--
ALTER TABLE `propiedad`
  MODIFY `id_propiedad` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

--
-- AUTO_INCREMENT de la tabla `rol`
--
ALTER TABLE `rol`
  MODIFY `id_rol` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de la tabla `solicitud`
--
ALTER TABLE `solicitud`
  MODIFY `id_solicitud` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT de la tabla `tipo_propiedad`
--
ALTER TABLE `tipo_propiedad`
  MODIFY `id_tipo` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT de la tabla `usuario`
--
ALTER TABLE `usuario`
  MODIFY `id_usuario` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `auditoria`
--
ALTER TABLE `auditoria`
  ADD CONSTRAINT `fk_auditoria_usuario` FOREIGN KEY (`id_usuario`) REFERENCES `usuario` (`id_usuario`) ON DELETE SET NULL ON UPDATE CASCADE;

--
-- Filtros para la tabla `cita`
--
ALTER TABLE `cita`
  ADD CONSTRAINT `fk_cita_cliente` FOREIGN KEY (`id_cliente`) REFERENCES `usuario` (`id_usuario`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_cita_propiedad` FOREIGN KEY (`id_propiedad`) REFERENCES `propiedad` (`id_propiedad`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Filtros para la tabla `documento_solicitud`
--
ALTER TABLE `documento_solicitud`
  ADD CONSTRAINT `fk_documento_solicitud` FOREIGN KEY (`id_solicitud`) REFERENCES `solicitud` (`id_solicitud`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Filtros para la tabla `favorito`
--
ALTER TABLE `favorito`
  ADD CONSTRAINT `fk_favorito_propiedad` FOREIGN KEY (`id_propiedad`) REFERENCES `propiedad` (`id_propiedad`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_favorito_usuario` FOREIGN KEY (`id_usuario`) REFERENCES `usuario` (`id_usuario`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Filtros para la tabla `imagen_propiedad`
--
ALTER TABLE `imagen_propiedad`
  ADD CONSTRAINT `fk_imagen_propiedad` FOREIGN KEY (`id_propiedad`) REFERENCES `propiedad` (`id_propiedad`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Filtros para la tabla `inmobiliaria`
--
ALTER TABLE `inmobiliaria`
  ADD CONSTRAINT `fk_inmobiliaria_usuario` FOREIGN KEY (`id_usuario`) REFERENCES `usuario` (`id_usuario`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Filtros para la tabla `perfil`
--
ALTER TABLE `perfil`
  ADD CONSTRAINT `fk_perfil_usuario` FOREIGN KEY (`id_usuario`) REFERENCES `usuario` (`id_usuario`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Filtros para la tabla `propiedad`
--
ALTER TABLE `propiedad`
  ADD CONSTRAINT `fk_propiedad_ciudad` FOREIGN KEY (`id_ciudad`) REFERENCES `ciudad` (`id_ciudad`) ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_propiedad_inmobiliaria` FOREIGN KEY (`id_inmobiliaria`) REFERENCES `inmobiliaria` (`id_inmobiliaria`) ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_propiedad_tipo` FOREIGN KEY (`id_tipo`) REFERENCES `tipo_propiedad` (`id_tipo`) ON UPDATE CASCADE;

--
-- Filtros para la tabla `propiedad_caracteristica`
--
ALTER TABLE `propiedad_caracteristica`
  ADD CONSTRAINT `fk_propcarac_caracteristica` FOREIGN KEY (`id_caracteristica`) REFERENCES `caracteristica` (`id_caracteristica`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_propcarac_propiedad` FOREIGN KEY (`id_propiedad`) REFERENCES `propiedad` (`id_propiedad`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Filtros para la tabla `solicitud`
--
ALTER TABLE `solicitud`
  ADD CONSTRAINT `fk_solicitud_cliente` FOREIGN KEY (`id_cliente`) REFERENCES `usuario` (`id_usuario`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_solicitud_propiedad` FOREIGN KEY (`id_propiedad`) REFERENCES `propiedad` (`id_propiedad`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Filtros para la tabla `usuario_rol`
--
ALTER TABLE `usuario_rol`
  ADD CONSTRAINT `fk_usuariorol_rol` FOREIGN KEY (`id_rol`) REFERENCES `rol` (`id_rol`) ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_usuariorol_usuario` FOREIGN KEY (`id_usuario`) REFERENCES `usuario` (`id_usuario`) ON DELETE CASCADE ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
