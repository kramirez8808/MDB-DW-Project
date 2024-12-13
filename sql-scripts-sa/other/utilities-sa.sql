-- Crear StageArea (SA)
CREATE DATABASE LubricentroSA;
USE LubricentroSA;

-- DROPS
DROP TABLE IF EXISTS LubricentroSA.ext.trabajos;
DROP TABLE IF EXISTS LubricentroSA.ext.facturas;
DROP TABLE IF EXISTS LubricentroSA.ext.vehiculos;
DROP TABLE IF EXISTS LubricentroSA.ext.clientes;
DROP TABLE IF EXISTS LubricentroSA.ext.empleados;
DROP TABLE IF EXISTS LubricentroSA.ext.cargos;
DROP TABLE IF EXISTS LubricentroSA.ext.citas;
DROP TABLE IF EXISTS LubricentroSA.ext.servicios;

DROP DATABASE IF EXISTS LubricentroSA.ext.LubricentroSA;
DROP DATABASE IF EXISTS LubricentroSA;

-- DELETES
DELETE FROM LubricentroSA.ext.trabajos;
DELETE FROM LubricentroSA.ext.facturas;
DELETE FROM LubricentroSA.ext.vehiculos;
DELETE FROM LubricentroSA.ext.clientes;
DELETE FROM LubricentroSA.ext.empleados;
DELETE FROM LubricentroSA.ext.cargos;
DELETE FROM LubricentroSA.ext.citas;
DELETE FROM LubricentroSA.ext.servicios;

-- COUNTS
SELECT COUNT(*) FROM LubricentroSA.ext.servicios;
SELECT COUNT(*) FROM LubricentroSA.ext.citas;
SELECT COUNT(*) FROM LubricentroSA.ext.cargos;
SELECT COUNT(*) FROM LubricentroSA.ext.empleados;
SELECT COUNT(*) FROM LubricentroSA.ext.trabajos;
SELECT COUNT(*) FROM LubricentroSA.ext.clientes;
SELECT COUNT(*) FROM LubricentroSA.ext.vehiculos;
SELECT COUNT(*) FROM LubricentroSA.ext.facturas;