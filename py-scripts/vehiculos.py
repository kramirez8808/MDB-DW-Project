#Importar librerias
import pandas as pd
import numpy as np

# -- Vehiculos
# CREATE TABLE LubricentroTX.dbo.vehiculos (
#     idVehiculo INT IDENTITY(1,1) PRIMARY KEY,
#     placa VARCHAR(10) NOT NULL,
#     marca VARCHAR(50) NOT NULL,
#     modelo VARCHAR(50) NOT NULL,
#     color VARCHAR(25) NOT NULL,
#     idCliente INT NOT NULL,
#     FOREIGN KEY (idCliente) REFERENCES clientes(idCliente)
# )

# Path
path = 'D:/Backup/Fidelitas/VIQ Data Warehouse/Proyecto Grupal/sql-scripts-tx/'

# Cantidad de registros
entries = 900000

# IDs de los vehículos
idsVehiculos = range(1, entries + 1)

# Posibles marcas, modelos y colores
marca = [
    "Toyota", "Honda", "Ford", "Chevrolet", "Nissan", "Hyundai", "Kia", "Volkswagen", "Subaru", "Mazda",
    "BMW", "Mercedes-Benz", "Audi", "Lexus", "Dodge", "Chrysler", "Jeep", "GMC", "Volvo", "Fiat",
    "Renault", "Peugeot", "Citroën", "Tesla", "Land Rover", "Jaguar", "Porsche", "Mitsubishi", "Ferrari", "Lamborghini",
    "Aston Martin", "Bentley", "Bugatti", "Rolls Royce", "Infiniti", "Acura", "Alfa Romeo", "Cadillac", "Lincoln", "Genesis"
]

marca_p = np.random.dirichlet(np.ones(len(marca)),size=1).tolist()[0]
marcas = np.random.choice(marca, size=entries, p=marca_p)

modelo = [
    "Corolla", "Civic", "F-150", "Silverado", "Altima", "Elantra", "Sportage", "Jetta", "Impreza", "CX-5",
    "X5", "C-Class", "A4", "RX", "Challenger", "Cherokee", "Sierra", "V60", "500", "A3",
    "Model S", "Model X", "Model 3", "Model Y", "Evoque", "Defender", "Range Rover", "911", "Cayenne", "Outlander",
    "Mustang", "Escalade", "Navigator", "Stelvio", "Giulia", "Murano", "Pathfinder", "Equinox", "Blazer", "Trailblazer"
]

modelo_p = np.random.dirichlet(np.ones(len(modelo)),size=1).tolist()[0]
modelos = np.random.choice(modelo, size=entries, p=modelo_p)

color = [
    "Rojo", "Azul", "Negro", "Blanco", "Gris", "Verde", "Amarillo", "Naranja", "Violeta", "Marrón",
    "Turquesa", "Cian", "Púrpura", "Plateado", "Oro", "Bronce", "Burdeos", "Beige", "Lila", "Esmeralda"
]

color_p = np.random.dirichlet(np.ones(len(color)),size=1).tolist()[0]
colores = np.random.choice(color, size=entries, p=color_p)

# Generar valor aleatorio para las placas con el formato XXX-000
placas = [
    ''.join(np.random.choice(list('QWERTYUIOPASDFGHJKLZXCVBNM'), size=3)) +
    ''.join('-') +
    ''.join(np.random.choice(list('1234567890'), size=3))
    for e in range(entries)
]

# Posibles valores para idCliente
cliente = np.arange(1, 875000 + 1)
clientes_p = np.random.dirichlet(np.ones(875000), size=1)[0]
clientes_p = clientes_p / clientes_p.sum()

clientes = np.random.choice(cliente, size=entries, p=clientes_p)

# Diccionario con los datos de los trabajos
data = {
    'idVehiculo': idsVehiculos,
    'placa': placas,
    'marca': marcas,
    'modelo': modelos,
    'color': colores,
    'idCliente': clientes
}

# DataFrame a partir del diccionario
df_vehiculos = pd.DataFrame(data)
df_vehiculos.Name = 'vehiculos'

# Guardar el DataFrame en un archivo CSV
df_vehiculos.to_csv(path + 'vehiculos.csv', index=None)

# Mostrar los primeros registros del DataFrame
df_vehiculos.head()

# Generar los INSERTS
registry = df_vehiculos.iloc[0]

# Función para generar un INSERT
def generateInsert(registry, tableName):
    # Extract the columns from the registry's index
    columns = str(tuple(registry.index)).replace("'", "")
    # Initialize the insert string with the table name and columns
    insert = f'INSERT INTO {tableName} {columns} VALUES ('
    
    # Loop through each value in the registry
    for value in registry:
        if isinstance(value, (np.str_, str)):
            # If the value is a string, wrap it in quotes
            insert += f"'{value}', "
        elif isinstance(value, pd._libs.tslibs.timestamps.Timestamp):
            # If the value is a Timestamp, format it as a date string
            valueDate = str(value)[:10]
            insert += f"'{valueDate}', "
        else:
            insert += f"{value}, "
    
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
inserts = generateInserts(df_vehiculos)

# Guardar los INSERTS en un archivo SQL
with open(path + 'vehiculos.sql', 'wt') as file:
    for insert in inserts:
        file.write(insert + '\n')