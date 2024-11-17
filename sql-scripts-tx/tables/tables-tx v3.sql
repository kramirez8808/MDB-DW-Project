-- DB
CREATE DATABASE LubricentroTX;
USE LubricentroTX;

-- TABLES

-- Servicios
CREATE TABLE LubricentroTX.dbo.servicios (
    idServicio INT PRIMARY KEY,
    nombreServicio NVARCHAR(100) NOT NULL,
    descripcionServicio NVARCHAR(200) NOT NULL,
    precioServicio DECIMAL(10,2) NOT NULL    
);

-- Citas
CREATE TABLE LubricentroTX.dbo.citas (
    idCita INT PRIMARY KEY,
    fechaCita DATE NOT NULL,
    horaCita TIME NOT NULL
)

-- Cargo
CREATE TABLE LubricentroTX.dbo.cargos (
    idCargo INT PRIMARY KEY,
    nombreCargo NVARCHAR(50) NOT NULL,
    descripcionCargo NVARCHAR(100) NOT NULL,
    salario DECIMAL(10,2) NOT NULL
)

-- Empleados
CREATE TABLE LubricentroTX.dbo.empleados (
    idEmpleado INT PRIMARY KEY,
    nombreEmpleado NVARCHAR(50) NOT NULL,
    apellidoEmpleado NVARCHAR(50) NOT NULL,
    idCargo INT NOT NULL,
    FOREIGN KEY (idCargo) REFERENCES cargos(idCargo)
)

-- Clientes
CREATE TABLE LubricentroTX.dbo.clientes (
    idCliente INT PRIMARY KEY,
    nombreCliente NVARCHAR(50) NOT NULL,
    apellidoCliente NVARCHAR(50) NOT NULL,
    telefonoCliente NVARCHAR(15) NOT NULL,
    emailCliente NVARCHAR(50) NOT NULL,
    provinciaCliente NVARCHAR(50) NOT NULL,
    cantonCliente NVARCHAR(50) NOT NULL,
    distritoCliente NVARCHAR(50) NOT NULL
)

-- Vehiculo
CREATE TABLE LubricentroTX.dbo.vehiculos (
    idVehiculo INT PRIMARY KEY,
    placa NVARCHAR(10) NOT NULL,
    marca NVARCHAR(50) NOT NULL,
    modelo NVARCHAR(50) NOT NULL,
    color NVARCHAR(25) NOT NULL,
    idCliente INT NOT NULL,
    FOREIGN KEY (idCliente) REFERENCES clientes(idCliente)
)

-- Factura
CREATE TABLE LubricentroTX.dbo.facturas (
    idFactura INT PRIMARY KEY,
    fechaFactura DATETIME NOT NULL,
    total DECIMAL(8,2) NOT NULL,
    idVehiculo INT NOT NULL,
    FOREIGN KEY (idVehiculo) REFERENCES vehiculos(idVehiculo)
)

-- Trabajos
CREATE TABLE LubricentroTX.dbo.trabajos (
    idTrabajo INT PRIMARY KEY,
    idServicio INT NOT NULL,
    idCita INT NOT NULL,
    idEmpleado INT NOT NULL,
    idFactura INT NOT NULL,
    FOREIGN KEY (idServicio) REFERENCES servicios(idServicio), 
    FOREIGN KEY (idCita) REFERENCES citas(idCita),
    FOREIGN KEY (idEmpleado) REFERENCES empleados(idEmpleado),
    FOREIGN KEY (idFactura) REFERENCES facturas(idFactura)
)

-- Sucursal
CREATE TABLE LubricentroTX.dbo.sucursales (
    idSucursal INT PRIMARY KEY,
    nombreSucursal NVARCHAR(50) NOT NULL,
    provinciaSucursal NVARCHAR(50) NOT NULL,
    cantonSucursal NVARCHAR(50) NOT NULL,
    distritoSucursal NVARCHAR(50) NOT NULL,
    emailSucursal NVARCHAR(50) NOT NULL,
    telefonoSucursal NVARCHAR(15) NOT NULL
)

-- Proveedor
CREATE TABLE LubricentroTX.dbo.proveedores (
    idProveedor INT PRIMARY KEY,
    nombreProveedor NVARCHAR(50) NOT NULL,
    telefonoProveedor NVARCHAR(15) NOT NULL,
    emailProveedor NVARCHAR(50) NOT NULL,
    provinciaProveedor NVARCHAR(50) NOT NULL,
    cantonProveedor NVARCHAR(50) NOT NULL,
    distritoProveedor NVARCHAR(50) NOT NULL
)

-- Producto
CREATE TABLE LubricentroTX.dbo.productos (
    idProducto INT PRIMARY KEY,
    nombreProducto NVARCHAR(50) NOT NULL,
    precioProducto DECIMAL(8,2) NOT NULL,
    marcaProducto NVARCHAR(50) NOT NULL,
    idProveedor INT NOT NULL,
    FOREIGN KEY (idProveedor) REFERENCES proveedores(idProveedor)
)

-- Inventario
CREATE TABLE LubricentroTX.dbo.inventario (
    idInventario INT PRIMARY KEY,
    idProducto INT NOT NULL,
    cantidad INT NOT NULL,
    idSucursal INT NOT NULL,
    FOREIGN KEY (idProducto) REFERENCES productos(idProducto),
    FOREIGN KEY (idSucursal) REFERENCES sucursales(idSucursal)
)

-- DetalleFactura
CREATE TABLE LubricentroTX.dbo.detalleFacturas (
    idDetalle INT PRIMARY KEY,
    idFactura INT NOT NULL,
    idInventario INT NOT NULL,
    cantidadVendida INT NOT NULL,
    FOREIGN KEY (idFactura) REFERENCES facturas(idFactura),
    FOREIGN KEY (idInventario) REFERENCES inventario(idInventario)
)

-- DROPS
DROP TABLE IF EXISTS LubricentroTX.dbo.detalleFacturas;
DROP TABLE IF EXISTS LubricentroTX.dbo.inventario;
DROP TABLE IF EXISTS LubricentroTX.dbo.productos;
DROP TABLE IF EXISTS LubricentroTX.dbo.proveedores;
DROP TABLE IF EXISTS LubricentroTX.dbo.sucursales;
DROP TABLE IF EXISTS LubricentroTX.dbo.trabajos;
DROP TABLE IF EXISTS LubricentroTX.dbo.facturas;
DROP TABLE IF EXISTS LubricentroTX.dbo.vehiculos;
DROP TABLE IF EXISTS LubricentroTX.dbo.clientes;
DROP TABLE IF EXISTS LubricentroTX.dbo.empleados;
DROP TABLE IF EXISTS LubricentroTX.dbo.cargos;
DROP TABLE IF EXISTS LubricentroTX.dbo.citas;
DROP TABLE IF EXISTS LubricentroTX.dbo.servicios;

DROP DATABASE IF EXISTS LubricentroTX.dbo.LubricentroTX;

-- DELETES
DELETE FROM LubricentroTX.dbo.detalleFacturas;
DELETE FROM LubricentroTX.dbo.inventario;
DELETE FROM LubricentroTX.dbo.productos;
DELETE FROM LubricentroTX.dbo.proveedores;
DELETE FROM LubricentroTX.dbo.sucursales;
DELETE FROM LubricentroTX.dbo.facturas;
DELETE FROM LubricentroTX.dbo.vehiculos;
DELETE FROM LubricentroTX.dbo.clientes;
DELETE FROM LubricentroTX.dbo.trabajos;
DELETE FROM LubricentroTX.dbo.empleados;
DELETE FROM LubricentroTX.dbo.cargos;
DELETE FROM LubricentroTX.dbo.citas;
DELETE FROM LubricentroTX.dbo.servicios;

-- COUNTS
SELECT COUNT(*) FROM servicios;
SELECT COUNT(*) FROM citas;
SELECT COUNT(*) FROM cargos;
SELECT COUNT(*) FROM empleados;
SELECT COUNT(*) FROM trabajos;
SELECT COUNT(*) FROM clientes;
SELECT COUNT(*) FROM vehiculos;
SELECT COUNT(*) FROM facturas;