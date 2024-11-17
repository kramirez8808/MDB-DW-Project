#Importar librerias
import pandas as pd
import numpy as np

# -- Clientes
# CREATE TABLE LubricentroTX.dbo.clientes (
#     idCliente INT IDENTITY(1,1) PRIMARY KEY,
#     nombreCliente VARCHAR(50) NOT NULL,
#     apellidoCliente VARCHAR(50) NOT NULL,
#     telefonoCliente VARCHAR(15) NOT NULL,
#     emailCliente VARCHAR(50) NOT NULL,
#     provinciaCliente VARCHAR(50) NOT NULL,
#     cantonCliente VARCHAR(50) NOT NULL,
#     distritoCliente VARCHAR(50) NOT NULL
# )

# Path
path = 'D:/Backup/Fidelitas/VIQ Data Warehouse/Proyecto Grupal/sql-scripts-tx/'

# Cantidad de registros
entries = 875000

# IDs de los clientes
idsClientes = np.arange(1, entries + 1)

# Posibles nombres y apellidos
nombre = [
    "Sofía", "Mateo", "Isabella", "Luca", "Camila", "Nicolás", "Valentina", "Gabriel", "Emilia", "Leonardo",
    "Ariana", "Diego", "Lucía", "Marco", "María", "Javier", "Antonia", "Alejandro", "Clara", "Fernando",
    "Julieta", "Samuel", "Mía", "Andrés", "Bianca", "Esteban", "Lía", "Pablo", "Catalina", "Rafael",
    "Elena", "Santiago", "Zoe", "Gonzalo", "Inés", "Claudio", "Julia", "Hugo", "Marta", "Rocío",
    "Paula", "Tomás", "Diana", "Adrián", "Teresa", "Santiago", "Laura", "Miguel", "Elisa", "César",
    "Nina", "Julio", "Marisol", "Violeta", "Victor", "Luciano", "Gabriela", "Emilio", "Silvia", "Estela",
    "Héctor", "Ana", "Simón", "Carla", "Renato", "Oscar", "Carolina", "Roberto", "Fabiana", "Cecilia",
    "Vicente", "Mauricio", "Daniela", "Ramiro", "Miriam", "Cristina", "Octavio", "Verónica", "Manuel", "Rita",
    "Humberto", "Andrea", "Enrique", "Patricia", "Felipe", "Iván", "Daniel", "Beatriz", "Joaquín", "Rebeca"
]

nombre_p = np.random.dirichlet(np.ones(len(nombre)),size=1).tolist()[0]
nombres = np.random.choice(nombre, size=entries, p=nombre_p)

apellido = [
    "González", "Rodríguez", "Pérez", "Fernández", "López", "Martínez", "García", "Sánchez", "Romero", "Torres",
    "Hernández", "Vázquez", "Castillo", "Morales", "Silva", "Ortega", "Rojas", "Jiménez", "Flores", "Benítez",
    "Molina", "Medina", "Arias", "Cabrera", "Herrera", "Ponce", "Ramos", "Sosa", "Reyes", "Navarro",
    "Aguilar", "Rivera", "Suárez", "Cruz", "Méndez", "Valenzuela", "Salinas", "Vera", "Campos", "Bravo",
    "Orellana", "Montoya", "Peña", "Fuentes", "Escobar", "Guzmán", "Cordero", "Chávez", "Lara", "Pizarro",
    "Carrillo", "Valle", "Contreras", "Tapia", "Godoy", "Ibáñez", "Araya", "Palacios", "Leiva", "Cáceres",
    "Vargas", "Ramos", "Espinoza", "Álvarez", "Salazar", "Riquelme", "Muñoz", "Bustamante", "Santana", "Villalobos"
]

apellido_p = np.random.dirichlet(np.ones(len(apellido)),size=1).tolist()[0]
apellidos = np.random.choice(apellido, size=entries, p=apellido_p)

# Posibles provincias, cantones y distritos
provincia = [
    "San José", "Alajuela", "Cartago", "Guanacaste", 
    "Heredia", "Puntarenas", "Limón"
]

provincia_p = np.random.dirichlet(np.ones(len(provincia)),size=1).tolist()[0]
provincias = np.random.choice(provincia, size=entries, p=provincia_p)

canton = [
    "San José", "Escazú", "Desamparados", "Puriscal", "Turrubares",
    "Aserrí", "Mora", "Goicoechea", "Santa Ana", "Alajuelita",
    "Vázquez de Coronado", "Curridabat", "Pérez Zeledón", "Tibás",
    "Moravia", "Cartago", "Paraíso", "La Unión", "Jiménez",
    "Turrialba", "Alvarado", "Oreamuno", "El Guarco", "Liberia",
    "Nicoya", "Santa Cruz", "Bagaces", "Carrillo", "Cañas",
    "Abangares", "Tilarán", "Hojancha", "La Cruz", "Heredia",
    "Barva", "Santo Domingo", "Santa Bárbara", "San Rafael",
    "San Isidro", "Belén", "Flores", "San Pablo", "Puntarenas",
    "Esparza", "Buenos Aires", "Montes de Oro", "Osa", "Aguirre",
    "Coto Brus", "Parrita"
]

canton_p = np.random.dirichlet(np.ones(len(canton)),size=1).tolist()[0]
cantones = np.random.choice(canton, size=entries, p=canton_p)

distrito = [
    "San José", "Escazú", "Desamparados", "Puriscal", "Turrubares",
    "Aserrí", "Mora", "Goicoechea", "Santa Ana", "Alajuelita",
    "Vázquez de Coronado", "Curridabat", "Pérez Zeledón", "Tibás",
    "Moravia", "Cartago", "Paraíso", "La Unión", "Jiménez",
    "Turrialba", "Alvarado", "Oreamuno", "El Guarco", "Liberia",
    "Nicoya", "Santa Cruz", "Bagaces", "Carrillo", "Cañas",
    "Abangares", "Tilarán", "Hojancha", "La Cruz", "Heredia",
    "Barva", "Santo Domingo", "Santa Bárbara", "San Rafael",
    "San Isidro", "Belén", "Flores", "San Pablo", "Puntarenas",
    "Esparza", "Buenos Aires", "Montes de Oro", "Osa", "Aguirre",
    "Coto Brus", "Parrita"
]

distrito_p = np.random.dirichlet(np.ones(len(distrito)),size=1).tolist()[0]
distritos = np.random.choice(distrito, size=entries, p=distrito_p)

# Generar valor aleatorio para el teléfono
telefonos = np.random.randint(80000000, 89999999, size=entries)

# Generar valor aleatorio para el correo que genere una cadena de 10 caracteres aleatorios en este formato abcdefg123
# correo = np.random.choice(list('abcdefghijklmnopqrstuvwxyz'), size=(entries, 7)) + np.random.choice(list('1234567890'), size=(entries, 3)) + '@gmail.com'
correos = [
    ''.join(np.random.choice(list('abcdefghijklmnopqrstuvwxyz'), size=7)) +
    ''.join(np.random.choice(list('1234567890'), size=3)) +
    '@gmail.com'
    for e in range(entries)
]

# Diccionario con los datos de los clientes
data = {
    'idCliente': idsClientes,
    'nombreCliente': nombres,
    'apellidoCliente': apellidos,
    'telefonoCliente': telefonos,
    'emailCliente': correos,
    'provinciaCliente': provincias,
    'cantonCliente': cantones,
    'distritoCliente': distritos
}

# DataFrame a partir del diccionario
df = pd.DataFrame(data)
df.Name = 'clientes'

# Guardar el DataFrame en un archivo CSV
df.to_csv(path + 'clientes.csv', index=None)

# Mostrar los primeros registros del DataFrame
df.head()

# Generar los INSERTS
registry = df.iloc[0]

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
inserts = generateInserts(df)

# Guardar los INSERTS en un archivo SQL
with open(path + 'clientes.sql', 'wt') as file:
    for insert in inserts:
        file.write(insert + '\n')