# Script para generar INSERTS para la tabla de Citas

#Importar librerias
import pandas as pd
import numpy as np

# Citas
# CREATE TABLE citas (
#     idCita INT PRIMARY KEY,
#     fechaCita DATE NOT NULL,
#     horaCita TIME NOT NULL
# )

# Path
path = 'D:/Backup/Fidelitas/VIQ Data Warehouse/Proyecto Grupal/sql-scripts-tx/'

# Cantidad de registros
entries = 25185

# IDs de las citas
idsCitas = np.arange(1, entries + 1)

# Fecha YYYY-MM-DD
# Valores posibles para día, mes y año
day = np.arange(1, 32)
month = np.arange(1, 13)
year = np.arange(2021, 2024)

# Distribución de probalidad para el día, mes y año
day_p = [
    0.0500, 0.0467, 0.0414, 0.0185, 0.0020, 0.0099, 0.0282, 0.0134, 0.0520, 0.0480,
    0.0048, 0.0529, 0.0629, 0.0466, 0.0655, 0.0028, 0.0261, 0.0202, 0.0591, 0.0007,
    0.0281, 0.0577, 0.0365, 0.0205, 0.0540, 0.0471, 0.0563, 0.0478, 0.0001, 0.0001,
    0.0001
]
print(sum(day_p))

month_p = [
    0.1649, 0.0592, 0.0647, 0.1073, 0.0166, 0.0756, 0.1363, 0.0225, 0.0337, 0.0737,
    0.1150, 0.1305
]

year_p = [0.27, 0.33, 0.40]

# Generar los días, meses y años para cada registro
days = np.random.choice(day, size=entries, p=day_p)
months = np.random.choice(month, size=entries, p=month_p)
years = np.random.choice(year, size=entries, p=year_p)

# Hora HH:MM:SS
# Valores posibles para hora, minuto y segundo
hour = np.arange(7, 18)
minute = ['00', '30']
second = '00'

# Distribución de probalidad para la hora, minuto y segundo
hour_p = [
    0.0450, 0.0626, 0.0925, 0.1153, 0.1400, 0.1905, 0.1429, 0.0762, 0.0571, 0.0476,
    0.0303
]

minute_p = [0.5, 0.5]

# Generar las horas y minutos para cada registro
hours = np.random.choice(hour, size=entries, p=hour_p)
minutes = np.random.choice(minute, size=entries, p=minute_p)

# Diccionario con los datos de las citas
data = {
    'idCita': idsCitas,
    'fechaCita': [f'{years[i]}-{months[i]:02d}-{days[i]:02d}' for i in range(entries)],
    'horaCita': [f'{hours[i]:02d}:{minutes[i]}:{second}' for i in range(entries)]
}

# DataFrame a partir del diccionario
df = pd.DataFrame(data)
df.Name = 'citas'

# Guardar el DataFrame en un archivo CSV
df.to_csv(path + 'citas.csv', index=None)

# Mostrar los primeros registros del DataFrame
df.head()

# Generar los INSERTS
registry = df.iloc[0]

# Función para generar un INSERT
# def generateInsert(registry, tableName):
#     columns = str(tuple(registry.index)).replace("'", "")
#     insert = 'INSERT INTO ' + tableName + columns + ' VALUES ('
    
#     for value in registry:
#         if type(value) != np.str_ and type(value) != str:
#             if type(value) == pd._libs.tslibs.timestamps.Timestamp:
#                 valueDate = str(value)[:10]
#                 insert += 'to_date(' + "'" + valueDate + "'" + ', ' + "'YYYY-MM-DD'" + '), '
#             else:
#                 insert += str(value) + ', '
#         else:
#             insert += "'" + value + "'" + ', '
    
#     insert = insert[:-2] + ');'
#     return insert

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
            # Otherwise, add the value directly (e.g., for numbers)
            insert += f"{value}, "
    
    # Remove the trailing comma and space, then close the parenthesis
    insert = insert[:-2] + ');'
    return insert

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
with open(path + 'citas.sql', 'wt') as file:
    for insert in inserts:
        file.write(insert + '\n')