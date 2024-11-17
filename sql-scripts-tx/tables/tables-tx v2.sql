-- DB
CREATE DATABASE LubricentroTX;
USE LubricentroTX;

-- TABLES

-- Servicios
CREATE TABLE servicios (
    idServicio INT IDENTITY(1,1) PRIMARY KEY,
    nombreServicio VARCHAR(100) NOT NULL,
    descripcionServicio VARCHAR(200) NOT NULL,
    precioServicio DECIMAL(8,2) NOT NULL    
);

-- Citas
CREATE TABLE citas (
    idCita INT IDENTITY(1,1) PRIMARY KEY,
    fechaCita DATE NOT NULL,
    horaCita TIME NOT NULL
)

-- Cargo
CREATE TABLE cargo (
    idCargo INT IDENTITY(1,1) PRIMARY KEY,
    nombreCargo VARCHAR(50) NOT NULL,
    descripcionCargo VARCHAR(100) NOT NULL,
    salario DECIMAL(8,2) NOT NULL
)

-- Empleados
CREATE TABLE empleados (
    idEmpleado INT IDENTITY(1,1) PRIMARY KEY,
    nombreEmpleado VARCHAR(50) NOT NULL,
    apellidoEmpleado VARCHAR(50) NOT NULL,
    idCargo INT NOT NULL,
    FOREIGN KEY (idCargo) REFERENCES cargo(idCargo)
)

-- Trabajos
CREATE TABLE trabajos (
    idTrabajo INT IDENTITY(1,1) PRIMARY KEY,
    idServicio INT NOT NULL,
    idCita INT NOT NULL,
    idEmpleado INT NOT NULL,
    FOREIGN KEY (idServicio) REFERENCES servicios(idServicio), 
    FOREIGN KEY (idCita) REFERENCES citas(idCita),
    FOREIGN KEY (idEmpleado) REFERENCES empleados(idEmpleado)
)

-- Clientes
CREATE TABLE clientes (
    idCliente INT IDENTITY(1,1) PRIMARY KEY,
    nombreCliente VARCHAR(50) NOT NULL,
    apellidoCliente VARCHAR(50) NOT NULL,
    telefonoCliente VARCHAR(15) NOT NULL,
    emailCliente VARCHAR(50) NOT NULL,
    provinciaCliente VARCHAR(50) NOT NULL,
    cantonCliente VARCHAR(50) NOT NULL,
    distritoCliente VARCHAR(50) NOT NULL
)

-- Vehiculo
CREATE TABLE vehiculo (
    idVehiculo INT IDENTITY(1,1) PRIMARY KEY,
    placa VARCHAR(10) NOT NULL,
    marca VARCHAR(50) NOT NULL,
    modelo VARCHAR(50) NOT NULL,
    color VARCHAR(25) NOT NULL,
    idCliente INT NOT NULL,
    FOREIGN KEY (idCliente) REFERENCES clientes(idCliente)
)

-- Factura
CREATE TABLE factura (
    idFactura INT IDENTITY(1,1) PRIMARY KEY,
    idTrabajo INT NOT NULL,
    fechaFactura DATETIME NOT NULL,
    total DECIMAL(8,2) NOT NULL,
    idVehiculo INT NOT NULL,
    FOREIGN KEY (idTrabajo) REFERENCES trabajos(idTrabajo),
    FOREIGN KEY (idVehiculo) REFERENCES vehiculo(idVehiculo)
)

-- Sucursal
CREATE TABLE sucursal (
    idSucursal INT IDENTITY(1,1) PRIMARY KEY,
    nombreSucursal VARCHAR(50) NOT NULL,
    provinciaSucursal VARCHAR(50) NOT NULL,
    cantonSucursal VARCHAR(50) NOT NULL,
    distritoSucursal VARCHAR(50) NOT NULL,
    emailSucursal VARCHAR(50) NOT NULL,
    telefonoSucursal VARCHAR(15) NOT NULL
)

-- Proveedor
CREATE TABLE proveedor (
    idProveedor INT IDENTITY(1,1) PRIMARY KEY,
    nombreProveedor VARCHAR(50) NOT NULL,
    telefonoProveedor VARCHAR(15) NOT NULL,
    emailProveedor VARCHAR(50) NOT NULL,
    provinciaProveedor VARCHAR(50) NOT NULL,
    cantonProveedor VARCHAR(50) NOT NULL,
    distritoProveedor VARCHAR(50) NOT NULL
)

-- Producto
CREATE TABLE producto (
    idProducto INT IDENTITY(1,1) PRIMARY KEY,
    nombreProducto VARCHAR(50) NOT NULL,
    precioProducto DECIMAL(8,2) NOT NULL,
    marcaProducto VARCHAR(50) NOT NULL,
    idProveedor INT NOT NULL,
    FOREIGN KEY (idProveedor) REFERENCES proveedor(idProveedor)
)

-- Inventario
CREATE TABLE inventario (
    idInventario INT IDENTITY(1,1) PRIMARY KEY,
    idProducto INT NOT NULL,
    cantidad INT NOT NULL,
    idSucursal INT NOT NULL,
    FOREIGN KEY (idProducto) REFERENCES producto(idProducto),
    FOREIGN KEY (idSucursal) REFERENCES sucursal(idSucursal)
)

-- DetalleFactura
CREATE TABLE detalleFactura (
    idDetalle INT IDENTITY(1,1) PRIMARY KEY,
    idFactura INT NOT NULL,
    idInventario INT NOT NULL,
    cantidadVendida INT NOT NULL,
    FOREIGN KEY (idFactura) REFERENCES factura(idFactura),
    FOREIGN KEY (idInventario) REFERENCES inventario(idInventario)
)

-- DROPS
DROP TABLE IF EXISTS detalleFactura;
DROP TABLE IF EXISTS inventario;
DROP TABLE IF EXISTS producto;
DROP TABLE IF EXISTS proveedor;
DROP TABLE IF EXISTS sucursal;
DROP TABLE IF EXISTS factura;
DROP TABLE IF EXISTS vehiculo;
DROP TABLE IF EXISTS clientes;
DROP TABLE IF EXISTS trabajos;
DROP TABLE IF EXISTS empleados;
DROP TABLE IF EXISTS cargo;
DROP TABLE IF EXISTS citas;
DROP TABLE IF EXISTS servicios;
DROP DATABASE IF EXISTS LubricentroTX;