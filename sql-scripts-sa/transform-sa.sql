-- 1.1 Crear Schemas en el SA
CREATE SCHEMA tra;

-- 1.2 Crear e Insertar los datos en la dimensión TipoServicio
CREATE TABLE LubricentroSA.tra.tipoServicio_d(
    idTipoServicio INT IDENTITY(1,1) PRIMARY KEY,
    nombreServicio NVARCHAR(100) NOT NULL
)

INSERT INTO LubricentroSA.tra.tipoServicio_d(nombreServicio)
    SELECT DISTINCT nombreServicio
    FROM LubricentroSA.ext.servicios;

-- 1.3 SELECT y creación de la dimensión Empleados
SELECT e.idEmpleado, e.nombreEmpleado, e.apellidoEmpleado,
       c.nombreCargo, c.salario
INTO LubricentroSA.tra.empleados_d
FROM LubricentroSA.ext.empleados e
    LEFT JOIN LubricentroSA.ext.cargos c
    ON e.idCargo = c.idCargo;

-- 1.4 SELECT y creación de la dimensión Vehiculos
SELECT v.idVehiculo, v.placa, v.marca, v.modelo, v.color,
       c.nombreCliente, c.apellidoCliente, c.provinciaCliente,
       c.cantonCliente, c.distritoCliente
INTO LubricentroSA.tra.vehiculos_d
FROM LubricentroSA.ext.vehiculos v
    LEFT JOIN LubricentroSA.ext.clientes c
    ON v.idCliente = c.idCliente;

-- 1.5 SELECT y creación de la dimensión Tiempo
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

-- 1.6.1 Verificar el SELECT de la tabla Hechos antes de crearla
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

-- 1.6.2 SELECT y creación de la tabla Hechos
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