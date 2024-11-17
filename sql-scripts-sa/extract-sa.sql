-- Crear StageArea (SA)
CREATE DATABASE LubricentroSA;
USE LubricentroSA;

-- Extraer las tablas de la base de datos TX al SA
SELECT * INTO LubricentroSA.ext.clientes
FROM LubricentroTX.dbo.clientes;

SELECT * INTO LubricentroSA.ext.vehiculos
FROM LubricentroTX.dbo.vehiculos;

SELECT * INTO LubricentroSA.ext.facturas
FROM LubricentroTX.dbo.facturas;

SELECT * INTO LubricentroSA.ext.citas
FROM LubricentroTX.dbo.citas;

SELECT * INTO LubricentroSA.ext.servicios
FROM LubricentroTX.dbo.servicios;

SELECT * INTO LubricentroSA.ext.cargos
FROM LubricentroTX.dbo.cargos;

SELECT * INTO LubricentroSA.ext.empleados
FROM LubricentroTX.dbo.empleados;

SELECT * INTO LubricentroSA.ext.trabajos
FROM LubricentroTX.dbo.trabajos;