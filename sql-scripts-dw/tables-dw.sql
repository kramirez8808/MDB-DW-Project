-- DATABASE
CREATE DATABASE LubricentroDW;
USE LubricentroDW;

-- DIMENSIONES
-- Dimensión Vehiculos
CREATE TABLE LubricentroDW.dbo.vehiculos_d (
    idVehiculo INT PRIMARY KEY,
    placa NVARCHAR(10) NOT NULL,
    marca NVARCHAR(50) NOT NULL,
    modelo NVARCHAR(50) NOT NULL,
    color NVARCHAR(25) NOT NULL,
    clienteNombre NVARCHAR(50) NOT NULL,
    clienteApellido NVARCHAR(50) NOT NULL,
    clienteProvincia NVARCHAR(50) NOT NULL,
    clienteCanton NVARCHAR(50) NOT NULL,
    clienteDistrito NVARCHAR(50) NOT NULL
);

-- Dimensión Empleados
CREATE TABLE LubricentroDW.dbo.empleados_d (
    idEmpleado INT PRIMARY KEY,
    empleadoNombre NVARCHAR(50) NOT NULL,
    empleadoApellido NVARCHAR(50) NOT NULL,
    cargoNombre NVARCHAR(50) NOT NULL
);

-- Dimensión Tipo de Servicios
CREATE TABLE LubricentroDW.dbo.tipoServicio_d (
    idTipoServicio INT PRIMARY KEY,
    nombreServicio NVARCHAR(100) NOT NULL
);

-- Dimensión Tiempo
CREATE TABLE LubricentroDW.dbo.tiempo_d (
    tiempo DATETIME PRIMARY KEY,
    fecha DATE NOT NULL,
    hora TIME NOT NULL,
    nombreDia NVARCHAR(10) NOT NULL,
    nombreMes NVARCHAR(25) NOT NULL,
    trimestre NVARCHAR(1) NOT NULL,
    anno INT NOT NULL
);

-- HECHOS
-- Hecho Ventas
CREATE TABLE LubricentroDW.dbo.ventas_h (
    idVenta INT PRIMARY KEY,
    montoServicio DECIMAL(10,2) NOT NULL,
    idVehiculo INT NOT NULL,
    idTipoServicio INT NOT NULL,
    idEmpleado INT NOT NULL,
    tiempo DATETIME NOT NULL,
    FOREIGN KEY (idVehiculo) REFERENCES vehiculos_d(idVehiculo),
    FOREIGN KEY (idTipoServicio) REFERENCES tipoServicio_d(idTipoServicio),
    FOREIGN KEY (idEmpleado) REFERENCES empleados_d(idEmpleado),
    FOREIGN KEY (tiempo) REFERENCES tiempo_d(tiempo)
);

-- DROPS
DROP TABLE IF EXISTS LubricentroDW.dbo.ventas_h;
DROP TABLE IF EXISTS LubricentroDW.dbo.tiempo_d;
DROP TABLE IF EXISTS LubricentroDW.dbo.tipoServicio_d;
DROP TABLE IF EXISTS LubricentroDW.dbo.empleados_d;
DROP TABLE IF EXISTS LubricentroDW.dbo.vehiculos_d;

DROP DATABASE IF EXISTS LubricentroDW.dbo.LubricentroDW;
DROP DATABASE IF EXISTS LubricentroDW;

-- DELETES
DELETE FROM LubricentroDW.dbo.ventas_h;
DELETE FROM LubricentroDW.dbo.tiempo_d;
DELETE FROM LubricentroDW.dbo.tipoServicio_d;
DELETE FROM LubricentroDW.dbo.empleados_d;
DELETE FROM LubricentroDW.dbo.vehiculos_d;

-- COUNTS
SELECT COUNT(*) FROM LubricentroDW.dbo.ventas_h;
SELECT COUNT(*) FROM LubricentroDW.dbo.tiempo_d;
SELECT COUNT(*) FROM LubricentroDW.dbo.tipoServicio_d;
SELECT COUNT(*) FROM LubricentroDW.dbo.empleados_d;
SELECT COUNT(*) FROM LubricentroDW.dbo.vehiculos_d;