-- 1.1 Cargar las tablas y datos de las dimensiones y hechos del Stage Area al Data Warehouse
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

-- 1.2 Modificar y aplicar llaves primarias del Data Warehouse para que no acepten NULL
ALTER TABLE LubricentroDW.dbo.tipoServicio_d
    ALTER COLUMN idTipoServicio INT NOT NULL;
ALTER TABLE LubricentroDW.dbo.empleados_d
    ALTER COLUMN idEmpleado INT NOT NULL;
ALTER TABLE LubricentroDW.dbo.vehiculos_d
    ALTER COLUMN idVehiculo INT NOT NULL;
ALTER TABLE LubricentroDW.dbo.tiempo_d
    ALTER COLUMN tiempo DATETIME NOT NULL;
ALTER TABLE LubricentroDW.dbo.ventas_h
    ALTER COLUMN idTrabajo INT NOT NULL;


ALTER TABLE LubricentroDW.dbo.tipoServicio_d
    ADD PRIMARY KEY (idTipoServicio);
ALTER TABLE LubricentroDW.dbo.empleados_d
    ADD PRIMARY KEY (idEmpleado);
ALTER TABLE LubricentroDW.dbo.vehiculos_d
    ADD PRIMARY KEY (idVehiculo);
ALTER TABLE LubricentroDW.dbo.tiempo_d
    ADD PRIMARY KEY (tiempo);
ALTER TABLE LubricentroDW.dbo.ventas_h
    ADD PRIMARY KEY (idTrabajo);


-- 1.3 Aplicar las llaves foráneas del Data Warehouse
ALTER TABLE LubricentroDW.dbo.ventas_h
    ADD FOREIGN KEY (idTipoServicio) REFERENCES LubricentroDW.dbo.tipoServicio_d(idTipoServicio);

ALTER TABLE LubricentroDW.dbo.ventas_h
    ADD FOREIGN KEY (idEmpleado) REFERENCES LubricentroDW.dbo.empleados_d(idEmpleado);

ALTER TABLE LubricentroDW.dbo.ventas_h
    ADD FOREIGN KEY (idVehiculo) REFERENCES LubricentroDW.dbo.vehiculos_d(idVehiculo);

ALTER TABLE LubricentroDW.dbo.ventas_h
    ADD FOREIGN KEY (tiempo) REFERENCES LubricentroDW.dbo.tiempo_d(tiempo);