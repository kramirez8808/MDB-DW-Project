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