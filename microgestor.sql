-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 04-04-2024 a las 11:59:31
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
-- Base de datos: `microgestor`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `costo_por_empresa`
--

CREATE TABLE `costo_por_empresa` (
  `id` int(11) NOT NULL,
  `id_empresa` int(11) DEFAULT NULL,
  `concepto` varchar(255) DEFAULT NULL,
  `costo` decimal(10,2) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `empleado_por_empresa`
--

CREATE TABLE `empleado_por_empresa` (
  `id` int(11) NOT NULL,
  `id_usuario` int(11) DEFAULT NULL,
  `id_empresa` int(11) DEFAULT NULL,
  `id_rol` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `empresa`
--

CREATE TABLE `empresa` (
  `id` int(11) NOT NULL,
  `nombre` varchar(255) DEFAULT NULL,
  `direccion` varchar(255) DEFAULT NULL,
  `logo` varchar(255) DEFAULT NULL,
  `giro_comercial` varchar(255) DEFAULT NULL,
  `fecha_de_creacion` date DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `empresa`
--

INSERT INTO `empresa` (`id`, `nombre`, `direccion`, `logo`, `giro_comercial`, `fecha_de_creacion`) VALUES
(1, 'abarroteria leonel', 'calle 16 colonia lazaro cardenas campeche campeche ', NULL, 'alimentos', '2024-04-03');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `gasto_por_empresa`
--

CREATE TABLE `gasto_por_empresa` (
  `id` int(11) NOT NULL,
  `id_empresa` int(11) DEFAULT NULL,
  `concepto` varchar(255) DEFAULT NULL,
  `costo` decimal(10,2) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `giros_comerciales`
--

CREATE TABLE `giros_comerciales` (
  `id` int(11) NOT NULL,
  `nombre` varchar(255) NOT NULL,
  `id_sector` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `giros_comerciales`
--

INSERT INTO `giros_comerciales` (`id`, `nombre`, `id_sector`) VALUES
(1, 'peluqueria', 1),
(2, 'libreria', 2),
(3, 'abogado', 3),
(4, 'cafeteria', 4);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `inventario_por_empresa`
--

CREATE TABLE `inventario_por_empresa` (
  `id` int(11) NOT NULL,
  `id_empresa` int(11) DEFAULT NULL,
  `id_producto_por_empresa` int(11) DEFAULT NULL,
  `cantidad` int(11) DEFAULT NULL,
  `costo` decimal(10,2) DEFAULT NULL,
  `precio` decimal(10,2) DEFAULT NULL,
  `notas` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `producto`
--

CREATE TABLE `producto` (
  `id` int(11) NOT NULL,
  `id_sat` varchar(255) DEFAULT NULL,
  `nombre` varchar(255) DEFAULT NULL,
  `imagen` varchar(255) DEFAULT NULL,
  `unidad_de_medida` varchar(50) DEFAULT NULL,
  `iva` decimal(5,2) DEFAULT NULL,
  `otro_impuesto` decimal(5,2) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `producto_por_empresa`
--

CREATE TABLE `producto_por_empresa` (
  `id` int(11) NOT NULL,
  `id_producto` int(11) DEFAULT NULL,
  `id_empresa` int(11) DEFAULT NULL,
  `costo` decimal(10,2) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `producto_por_venta`
--

CREATE TABLE `producto_por_venta` (
  `id` int(11) NOT NULL,
  `id_venta_por_empresa` int(11) DEFAULT NULL,
  `id_producto_por_empresa` int(11) DEFAULT NULL,
  `cantidad` int(11) DEFAULT NULL,
  `total_del_producto` decimal(10,2) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `roles`
--

CREATE TABLE `roles` (
  `id` int(11) NOT NULL,
  `nombre` varchar(255) DEFAULT NULL,
  `registrar_venta` tinyint(1) DEFAULT NULL,
  `registrar_costos` tinyint(1) DEFAULT NULL,
  `ver_resumenes` tinyint(1) DEFAULT NULL,
  `editar_roles` tinyint(1) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `sectores`
--

CREATE TABLE `sectores` (
  `id` int(11) NOT NULL,
  `nombre` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `sectores`
--

INSERT INTO `sectores` (`id`, `nombre`) VALUES
(1, 'servicios'),
(2, 'profesiones'),
(3, 'tienda'),
(4, 'alimentos y bebidas'),
(5, 'otro');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `servicios`
--

CREATE TABLE `servicios` (
  `id` int(11) NOT NULL,
  `id_sat` varchar(255) DEFAULT NULL,
  `nombre` varchar(255) DEFAULT NULL,
  `logo` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `usuarios`
--

CREATE TABLE `usuarios` (
  `id` int(11) NOT NULL,
  `nombre` varchar(255) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `contrasena` varchar(255) DEFAULT NULL,
  `numero_de_telefono` varchar(20) DEFAULT NULL,
  `foto_del_perfil` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `usuarios`
--

INSERT INTO `usuarios` (`id`, `nombre`, `email`, `contrasena`, `numero_de_telefono`, `foto_del_perfil`) VALUES
(3, 'arturo perez', 'arturo@gmail.com', '12345', '9811398334', NULL);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `venta_por_empresa`
--

CREATE TABLE `venta_por_empresa` (
  `id` int(11) NOT NULL,
  `id_empresa` int(11) DEFAULT NULL,
  `id_empleado` int(11) DEFAULT NULL,
  `serial` varchar(255) DEFAULT NULL,
  `forma_de_pago` varchar(255) DEFAULT NULL,
  `notas` text DEFAULT NULL,
  `total` decimal(10,2) DEFAULT NULL,
  `fecha_de_venta` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `costo_por_empresa`
--
ALTER TABLE `costo_por_empresa`
  ADD PRIMARY KEY (`id`),
  ADD KEY `id_empresa` (`id_empresa`);

--
-- Indices de la tabla `empleado_por_empresa`
--
ALTER TABLE `empleado_por_empresa`
  ADD PRIMARY KEY (`id`),
  ADD KEY `id_usuario` (`id_usuario`),
  ADD KEY `id_empresa` (`id_empresa`),
  ADD KEY `id_rol` (`id_rol`);

--
-- Indices de la tabla `empresa`
--
ALTER TABLE `empresa`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `gasto_por_empresa`
--
ALTER TABLE `gasto_por_empresa`
  ADD PRIMARY KEY (`id`),
  ADD KEY `id_empresa` (`id_empresa`);

--
-- Indices de la tabla `giros_comerciales`
--
ALTER TABLE `giros_comerciales`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `inventario_por_empresa`
--
ALTER TABLE `inventario_por_empresa`
  ADD PRIMARY KEY (`id`),
  ADD KEY `id_empresa` (`id_empresa`),
  ADD KEY `id_producto_por_empresa` (`id_producto_por_empresa`);

--
-- Indices de la tabla `producto`
--
ALTER TABLE `producto`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `producto_por_empresa`
--
ALTER TABLE `producto_por_empresa`
  ADD PRIMARY KEY (`id`),
  ADD KEY `id_producto` (`id_producto`),
  ADD KEY `id_empresa` (`id_empresa`);

--
-- Indices de la tabla `producto_por_venta`
--
ALTER TABLE `producto_por_venta`
  ADD PRIMARY KEY (`id`),
  ADD KEY `id_venta_por_empresa` (`id_venta_por_empresa`),
  ADD KEY `id_producto_por_empresa` (`id_producto_por_empresa`);

--
-- Indices de la tabla `roles`
--
ALTER TABLE `roles`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `sectores`
--
ALTER TABLE `sectores`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `servicios`
--
ALTER TABLE `servicios`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `usuarios`
--
ALTER TABLE `usuarios`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `venta_por_empresa`
--
ALTER TABLE `venta_por_empresa`
  ADD PRIMARY KEY (`id`),
  ADD KEY `id_empresa` (`id_empresa`),
  ADD KEY `id_empleado` (`id_empleado`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `costo_por_empresa`
--
ALTER TABLE `costo_por_empresa`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `empleado_por_empresa`
--
ALTER TABLE `empleado_por_empresa`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `empresa`
--
ALTER TABLE `empresa`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de la tabla `gasto_por_empresa`
--
ALTER TABLE `gasto_por_empresa`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `giros_comerciales`
--
ALTER TABLE `giros_comerciales`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT de la tabla `inventario_por_empresa`
--
ALTER TABLE `inventario_por_empresa`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `producto`
--
ALTER TABLE `producto`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `producto_por_empresa`
--
ALTER TABLE `producto_por_empresa`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `producto_por_venta`
--
ALTER TABLE `producto_por_venta`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `roles`
--
ALTER TABLE `roles`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `sectores`
--
ALTER TABLE `sectores`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT de la tabla `servicios`
--
ALTER TABLE `servicios`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `usuarios`
--
ALTER TABLE `usuarios`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de la tabla `venta_por_empresa`
--
ALTER TABLE `venta_por_empresa`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `costo_por_empresa`
--
ALTER TABLE `costo_por_empresa`
  ADD CONSTRAINT `costo_por_empresa_ibfk_1` FOREIGN KEY (`id_empresa`) REFERENCES `empresa` (`id`);

--
-- Filtros para la tabla `empleado_por_empresa`
--
ALTER TABLE `empleado_por_empresa`
  ADD CONSTRAINT `empleado_por_empresa_ibfk_1` FOREIGN KEY (`id_usuario`) REFERENCES `usuarios` (`id`),
  ADD CONSTRAINT `empleado_por_empresa_ibfk_2` FOREIGN KEY (`id_empresa`) REFERENCES `empresa` (`id`),
  ADD CONSTRAINT `empleado_por_empresa_ibfk_3` FOREIGN KEY (`id_rol`) REFERENCES `roles` (`id`);

--
-- Filtros para la tabla `gasto_por_empresa`
--
ALTER TABLE `gasto_por_empresa`
  ADD CONSTRAINT `gasto_por_empresa_ibfk_1` FOREIGN KEY (`id_empresa`) REFERENCES `empresa` (`id`);

--
-- Filtros para la tabla `inventario_por_empresa`
--
ALTER TABLE `inventario_por_empresa`
  ADD CONSTRAINT `inventario_por_empresa_ibfk_1` FOREIGN KEY (`id_empresa`) REFERENCES `empresa` (`id`),
  ADD CONSTRAINT `inventario_por_empresa_ibfk_2` FOREIGN KEY (`id_producto_por_empresa`) REFERENCES `producto_por_empresa` (`id`);

--
-- Filtros para la tabla `producto_por_empresa`
--
ALTER TABLE `producto_por_empresa`
  ADD CONSTRAINT `producto_por_empresa_ibfk_1` FOREIGN KEY (`id_producto`) REFERENCES `producto` (`id`),
  ADD CONSTRAINT `producto_por_empresa_ibfk_2` FOREIGN KEY (`id_empresa`) REFERENCES `empresa` (`id`);

--
-- Filtros para la tabla `producto_por_venta`
--
ALTER TABLE `producto_por_venta`
  ADD CONSTRAINT `producto_por_venta_ibfk_1` FOREIGN KEY (`id_venta_por_empresa`) REFERENCES `venta_por_empresa` (`id`),
  ADD CONSTRAINT `producto_por_venta_ibfk_2` FOREIGN KEY (`id_producto_por_empresa`) REFERENCES `producto_por_empresa` (`id`);

--
-- Filtros para la tabla `venta_por_empresa`
--
ALTER TABLE `venta_por_empresa`
  ADD CONSTRAINT `venta_por_empresa_ibfk_1` FOREIGN KEY (`id_empresa`) REFERENCES `empresa` (`id`),
  ADD CONSTRAINT `venta_por_empresa_ibfk_2` FOREIGN KEY (`id_empleado`) REFERENCES `empleado_por_empresa` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
