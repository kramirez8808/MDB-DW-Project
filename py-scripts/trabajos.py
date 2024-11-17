# Script para generar INSERTS para la tabla de Trabajos

#Importar librerias
import pandas as pd
import numpy as np

# Trabajos
# CREATE TABLE trabajos (
#     idTrabajo INT IDENTITY(1,1) PRIMARY KEY,
#     idServicio INT NOT NULL,
#     idCita INT NOT NULL,
#     idEmpleado INT NOT NULL,
#     FOREIGN KEY (idServicio) REFERENCES servicios(idServicio), 
#     FOREIGN KEY (idCita) REFERENCES citas(idCita),
#     FOREIGN KEY (idEmpleado) REFERENCES empleados(idEmpleado)
# )

# Path
path = 'D:/Backup/Fidelitas/VIQ Data Warehouse/Proyecto Grupal/sql-scripts-tx/'

# Cantidad de registros
entries = 1000000

# Servicio
# Valores posibles para el idServicio
servicio = np.arange(1, 25 + 1)

# Distribución de probalidad para el día, mes y año
servicio_p = [
    0.10,  # Servicio 1
    0.10,  # Servicio 2
    0.07,  # Servicio 3
    0.08,  # Servicio 4
    0.03,  # Servicio 5
    0.03,  # Servicio 6
    0.04,  # Servicio 7
    0.07,  # Servicio 8
    0.03,  # Servicio 9
    0.03,  # Servicio 10
    0.02,  # Servicio 11
    0.03,  # Servicio 12
    0.03,  # Servicio 13
    0.03,  # Servicio 14
    0.03,  # Servicio 15
    0.03,  # Servicio 16
    0.03,  # Servicio 17
    0.04,  # Servicio 18
    0.03,  # Servicio 19
    0.03,  # Servicio 20
    0.02,  # Servicio 21
    0.02,  # Servicio 22
    0.03,  # Servicio 23
    0.03,  # Servicio 24
    0.02   # Servicio 25
]

# Generar los servicios para cada registro
servicios = np.random.choice(servicio, size=entries, p=servicio_p)

# Empleado

# Valores para el idTrabajo
idsTrabajos = np.arange(1, entries + 1)

# Valores posibles para el idEmpleado
empleado = np.arange(1, 500 + 1)

# Distribución de probalidad para el idEmpleado
empleado_p = np.random.dirichlet(np.ones(500), size=1)[0]
empleado_p = empleado_p / empleado_p.sum()

# Generar los empleados para cada registro
empleados = np.random.choice(empleado, size=entries, p=empleado_p)

# Array de Citas (1-25185)
cita = np.arange(1, 25185 + 1)

# Distribución de probalidad para las citas
citas_p = np.random.dirichlet(np.ones(25185), size=1)[0]
citas_p = citas_p / citas_p.sum()

# Generar las citas para cada registro
citas = np.random.choice(cita, size=entries, p=citas_p)

# Valores posibles para el idFactura
factura = np.arange(1, 900000 + 1)

# Distribución de probalidad para el idFactura
factura_p = np.random.dirichlet(np.ones(900000), size=1)[0]
factura_p = factura_p / factura_p.sum()

# Generar las facturas para cada registro
facturas = np.random.choice(factura, size=entries, p=factura_p)

# Diccionario con los datos de los trabajos
data = {
    'idTrabajo': idsTrabajos,
    'idServicio': servicios,
    'idCita': citas,
    'idEmpleado': empleados,
    'idFactura': facturas
}

# DataFrame a partir del diccionario
df = pd.DataFrame(data)
df.Name = 'trabajos'

# Guardar el DataFrame en un archivo CSV
df.to_csv(path + 'trabajos.csv', index=None)

# Mostrar los primeros registros del DataFrame
df.head()

# Generar los INSERTS
registry = df.iloc[0]

# Función para generar un INSERT
def generateInsert(registry, tableName):
    columns = str(tuple(registry.index)).replace("'", "")
    insert = 'INSERT INTO ' + tableName + columns + ' VALUES ('
    
    for value in registry:
        if type(value) != np.str_ and type(value) != str:
            if type(value) == pd._libs.tslibs.timestamps.Timestamp:
                valueDate = str(value)[:10]
                insert += 'to_date(' + "'" + valueDate + "'" + ', ' + "'YYYY-MM-DD'" + '), '
            else:
                insert += str(value) + ', '
        else:
            insert += "'" + value + "'" + ', '
    
    insert = insert[:-2] + ');'
    return insert



# Función para generar los INSERTS
def generateInserts(df):
    inserts = []
    for i in range(len(df)):
        registry = df.iloc[i]
        insert = generateInsert(registry, df.Name)
        inserts.append(insert)
    return inserts

# Generar los INSERTS
inserts = generateInserts(df)

# Guardar los INSERTS en un archivo SQL
with open(path + 'trabajos.sql', 'wt') as file:
    for insert in inserts:
        file.write(insert + '\n')
