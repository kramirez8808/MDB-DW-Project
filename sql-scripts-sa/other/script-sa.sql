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

-- Crear las tablas de transformación en el SA a partir de las tablas de extracción
-- 1.1 Crear Dimensión TipoServicio
CREATE TABLE LubricentroSA.tra.tipoServicio_d(
    idTipoServicio INT IDENTITY(1,1) PRIMARY KEY,
    nombreServicio NVARCHAR(100) NOT NULL
)

-- 1.2 Insertar los datos en TipoServicio del Transformación Stage Area a partir del campo nombreServicio de la tabla Servicios
INSERT INTO LubricentroSA.tra.tipoServicio_d(nombreServicio)
    SELECT DISTINCT nombreServicio
    FROM LubricentroSA.ext.servicios;

-- 2.1 Crear Dimensión Empleados
CREATE TABLE LubricentroSA.tra.empleados_d(
    idEmpleado INT IDENTITY(1,1) PRIMARY KEY,
    nombreEmpleado NVARCHAR(50) NOT NULL,
    apellidoEmpleado NVARCHAR(50) NOT NULL,
    nombreCargo NVARCHAR(50) NOT NULL
)

-- 2.2 Insertar los datos en Empleados del Transformación Stage Area a partir de los campos nombreEmpleado, apellidoEmpleado y nombreCargo de la tabla Empleados
SELECT e.idEmpleado, e.nombreEmpleado, e.apellidoEmpleado,
       c.nombreCargo, c.salario
INTO LubricentroSA.tra.empleados_d
FROM LubricentroSA.ext.empleados e
    LEFT JOIN LubricentroSA.ext.cargos c
    ON e.idCargo = c.idCargo;


-- 3.1 Crear Dimensión Vehiculos
CREATE TABLE LubricentroSA.tra.vehiculos_d(
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
)

-- 3.2 Insertar los datos en Vehiculos del Transformación Stage Area a partir de los campos placa, marca, modelo, color, nombreCliente, apellidoCliente, provinciaCliente, cantonCliente y distritoCliente de la tabla Vehiculos
SELECT v.idVehiculo, v.placa, v.marca, v.modelo, v.color,
       c.nombreCliente, c.apellidoCliente, c.provinciaCliente,
       c.cantonCliente, c.distritoCliente
INTO LubricentroSA.tra.vehiculos_d
FROM LubricentroSA.ext.vehiculos v
    LEFT JOIN LubricentroSA.ext.clientes c
    ON v.idCliente = c.idCliente;

-- 4.1 Crear Dimensión Tiempo
CREATE TABLE LubricentroSA.tra.tiempo_d(
    tiempo DATETIME PRIMARY KEY,
    fecha DATE NOT NULL,
    hora TIME NOT NULL,
    nombreDia NVARCHAR(10) NOT NULL,
    nombreMes NVARCHAR(25) NOT NULL,
    trimestre NVARCHAR(1) NOT NULL,
    anno INT NOT NULL
)

-- 4.2 Insertar los datos en Tiempo del Transformación Stage Area a partir del campo fechaCita de la tabla Citas
-- 4.2.1 Lista de horarios distintos (unir fechaCita y horaCita)
SELECT DISTINCT 
    CAST(CONCAT(CONVERT(VARCHAR, fechaCita, 23), ' ', CONVERT(VARCHAR, horaCita, 8)) AS DATETIME) AS tiempo
FROM LubricentroTX.dbo.citas;


-- 4.2.2 Cantidad total de registros en la tabla de Citas
SELECT COUNT(CAST(CONCAT(CONVERT(VARCHAR, fechaCita, 23), ' ', CONVERT(VARCHAR, horaCita, 8)) AS DATETIME))
    FROM LubricentroSA.ext.citas

-- 4.2.3 Cantidad de horarios distintos (unir fechaCita y horaCita)
SELECT COUNT(DISTINCT 
    CAST(CONCAT(CONVERT(VARCHAR, fechaCita, 23), ' ', CONVERT(VARCHAR, horaCita, 8)) AS DATETIME))
    FROM LubricentroSA.ext.citas

-- 4.2.4 Determinar el trimestre de cada fecha
SELECT DATEPART(QUARTER, fechaCita)
    FROM LubricentroSA.ext.citas

-- 4.2.5 SELECT y creación de la tabla Tiempo
SELECT ctmp.tiempo,
    DATE(tiempo) AS fecha,
    TIME(tiempo) AS hora,
    DATENAME(WEEKDAY, tiempo) AS nombreDia,
    DATENAME(MONTH, tiempo) AS nombreMes,
    DATEPART(QUARTER, tiempo) AS trimestre,
    YEAR(tiempo) AS anno
INTO LubricentroSA.tra.tiempo_d
FROM (SELECT DISTINCT CAST(CONCAT(fechaCita, ' ', horaCita) AS DATETIME) AS tiempo
      FROM LubricentroSA.ext.citas) AS ctmp;

-- Fixed
SELECT ctmp.tiempo,
    DATE(tiempo) AS fecha,
    TIME(tiempo) AS hora,
    DATENAME(WEEKDAY, tiempo) AS nombreDia,
    DATENAME(MONTH, tiempo) AS nombreMes,
    DATEPART(QUARTER, tiempo) AS trimestre,
    YEAR(tiempo) AS anno
INTO LubricentroSA.tra.tiempo_d
FROM (SELECT DISTINCT 
    CAST(CONCAT(CONVERT(VARCHAR, fechaCita, 23), ' ', CONVERT(VARCHAR, horaCita, 8)) AS DATETIME) AS tiempo
    FROM LubricentroSA.ext.citas) AS ctmp;

-- Fixed 2.0
SELECT 
    ctmp.tiempo,
    CONVERT(DATE, ctmp.tiempo) AS fecha,
    CONVERT(TIME, ctmp.tiempo) AS hora,
    DATENAME(WEEKDAY, ctmp.tiempo) AS nombreDia,
    DATENAME(MONTH, ctmp.tiempo) AS nombreMes,
    DATEPART(QUARTER, ctmp.tiempo) AS trimestre,
    DATEPART(YEAR, ctmp.tiempo) AS anno
INTO LubricentroSA.tra.tiempo_d
FROM (
    SELECT DISTINCT 
        CAST(CONCAT(CONVERT(VARCHAR, fechaCita, 23), ' ', CONVERT(VARCHAR, horaCita, 8)) AS DATETIME) AS tiempo
    FROM LubricentroSA.ext.citas
) AS ctmp;


-- 5.1 Crear y asociar las dimensiones con la tabla Hechos (Ventas_H)
CREATE TABLE LubricentroSA.tra.ventas_h(
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
)

-- 5.2 Verificar que el SELECT de la tabla de Hechos sea correcto antes de insertar los datos
SELECT tra.idTrabajo,
        serv.precioServicio,
        veh.idVehiculo,
        ts.idTipoServicio,
        emp.idEmpleado,
        CAST(CONCAT(CONVERT(VARCHAR, cit.fechaCita, 23), ' ', CONVERT(VARCHAR, cit.horaCita, 8)) AS DATETIME) AS tiempo

FROM LubricentroSA.ext.trabajos tra

    LEFT JOIN LubricentroSA.ext.servicios serv
        ON tra.idServicio = serv.idServicio

    LEFT JOIN LubricentroSA.ext.facturas fac
        ON tra.idFactura = fac.idFactura
    LEFT JOIN LubricentroSA.tra.vehiculos_d veh
        ON fac.idVehiculo = veh.idVehiculo

    LEFT JOIN LubricentroSA.tra.tipoServicio_d ts
        ON tra.idServicio = ts.idTipoServicio

    LEFT JOIN LubricentroSA.tra.empleados_d emp
        ON tra.idEmpleado = emp.idEmpleado

    LEFT JOIN LubricentroSA.ext.citas cit
        ON tra.idCita = cit.idCita

SELECT COUNT(*) FROM (
        SELECT tra.idTrabajo,
        serv.precioServicio,
        veh.idVehiculo,
        ts.idTipoServicio,
        emp.idEmpleado,
        CAST(CONCAT(CONVERT(VARCHAR, cit.fechaCita, 23), ' ', CONVERT(VARCHAR, cit.horaCita, 8)) AS DATETIME) AS tiempo
        FROM LubricentroSA.ext.trabajos tra

            LEFT JOIN LubricentroSA.ext.servicios serv
                ON tra.idServicio = serv.idServicio

            -- LEFT JOIN LubricentroSA.tra.vehiculos_d veh
            --     ON tra.idVehiculo = veh.idVehiculo
            LEFT JOIN LubricentroSA.ext.facturas fac
                ON tra.idFactura = fac.idFactura
            LEFT JOIN LubricentroSA.tra.vehiculos_d veh
                ON fac.idVehiculo = veh.idVehiculo

            -- LEFT JOIN LubricentroSA.tra.tipoServicio_d ts
            --     ON serv.nombreServicio = ts.nombreServicio
            LEFT JOIN LubricentroSA.tra.tipoServicio_d ts
                ON tra.idServicio = ts.idTipoServicio

            LEFT JOIN LubricentroSA.tra.empleados_d emp
                ON tra.idEmpleado = emp.idEmpleado

            -- LEFT JOIN LubricentroSA.ext.citas cit
            --     ON tra.idCita = cit.idCita
            LEFT JOIN LubricentroSA.ext.citas cit
                ON tra.idCita = cit.idCita
) AS tmp

-- 5.3 SELECT y creación de la tabla Hechos
SELECT tra.idTrabajo,
        serv.precioServicio,
        veh.idVehiculo,
        ts.idTipoServicio,
        emp.idEmpleado,
        CAST(CONCAT(CONVERT(VARCHAR, cit.fechaCita, 23), ' ', CONVERT(VARCHAR, cit.horaCita, 8)) AS DATETIME) AS tiempo
INTO LubricentroSA.tra.ventas_h
FROM LubricentroSA.ext.trabajos tra

    LEFT JOIN LubricentroSA.ext.servicios serv
        ON tra.idServicio = serv.idServicio

    LEFT JOIN LubricentroSA.ext.facturas fac
        ON tra.idFactura = fac.idFactura
    LEFT JOIN LubricentroSA.tra.vehiculos_d veh
        ON fac.idVehiculo = veh.idVehiculo

    LEFT JOIN LubricentroSA.tra.tipoServicio_d ts
        ON tra.idServicio = ts.idTipoServicio

    LEFT JOIN LubricentroSA.tra.empleados_d emp
        ON tra.idEmpleado = emp.idEmpleado

    LEFT JOIN LubricentroSA.ext.citas cit
        ON tra.idCita = cit.idCita

-- 6.1 Cargar las tablas y datos de las dimensiones y hechos al Data Warehouse
SELECT * INTO LubricentroDW.dbo.tipoServicio_d
    FROM LubricentroSA.tra.tipoServicio_d;

SELECT * INTO LubricentroDW.dbo.empleados_d
    FROM LubricentroSA.tra.empleados_d;

SELECT * INTO LubricentroDW.dbo.vehiculos_d
    FROM LubricentroSA.tra.vehiculos_d;

SELECT * INTO LubricentroDW.dbo.tiempo_d
    FROM LubricentroSA.tra.tiempo_d;

SELECT * INTO LubricentroDW.dbo.ventas_h
    FROM LubricentroSA.tra.ventas_h;