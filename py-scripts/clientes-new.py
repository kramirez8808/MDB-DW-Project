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

nombre_p = np.random.dirichlet(np.ones(len(nombre)), size=1).tolist()[0]
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

apellido_p = np.random.dirichlet(np.ones(len(apellido)), size=1).tolist()[0]
apellidos = np.random.choice(apellido, size=entries, p=apellido_p)

# Relación de provincias, cantones y distritos
ubicaciones = {
    "San José": {
        "San José": ["Carmen", "Merced", "Hospital", "Catedral"],
        "Escazú": ["San Antonio", "Escazú"],
        "Desamparados": ["Desamparados", "San Miguel", "San Juan de Dios"],
        "Tarrazú": ["San Marcos", "San Lorenzo", "San Carlos"]
    },
    "Alajuela": {
        "Alajuela": ["San José", "Carrizal"],
        "San Ramón": ["San Ramón", "Peñas Blancas", "Volcán"],
        "Grecia": ["Grecia", "San Isidro", "San Roque"],
        "Atenas": ["Atenas", "Jesús"]
    },
    "Cartago": {
        "Cartago": ["Oriental", "Occidental", "San Nicolás"],
        "Paraíso": ["Paraíso", "Santiago", "Orosi"],
        "La Unión": ["Tres Ríos", "San Diego", "San Rafael"],
        "Jiménez": ["Juan Viñas", "Tucurrique", "Pejibaye"],
    },
    "Heredia": {
        "Heredia": ["Heredia", "Mercedes", "San Francisco"],
        "Barva": ["Barva", "San Pedro", "San Pablo"],
        "Santo Domingo": ["Santo Domingo", "San Vicente",],
        "Santa Bárbara": ["Santa Bárbara", "San Juan"]
    },
    "Guanacaste": {
        "Liberia": ["Liberia", "Cañas", "Abangares"],
        "Nicoya": ["Nicoya", "Mansión"],
        "Santa Cruz": ["Santa Cruz", "Bolsón", "Veintisiete de Abril"],
        "Bagaces": ["Bagaces", "La Fortuna", "Mogote"]
    },
    "Puntarenas": {
        "Puntarenas": ["Puntarenas", "Pitahaya", "Chomes"],
        "Esparza": ["Espíritu Santo", "San Juan Grande", "Macacona"],
        "Buenos Aires": ["Buenos Aires", "Potrero Grande"],
        "Montes de Oro": ["Miramar", "La Unión"]
    },
    "Limón": {
        "Limón": ["Limón", "Valle La Estrella", "Río Blanco"],
        "Pococí": ["Guápiles", "Jiménez", "La Rita"],
        "Siquirres": ["Siquirres", "Pacuarito", "Florida"],
        "Talamanca": ["Bratsi", "Sixaola", "Cahuita"]
    }

}

# Selección aleatoria basada en la jerarquía
def obtener_ubicacion(ubicaciones):
    provincia = np.random.choice(list(ubicaciones.keys()))
    canton = np.random.choice(list(ubicaciones[provincia].keys()))
    distrito = np.random.choice(ubicaciones[provincia][canton])
    return provincia, canton, distrito

provincias, cantones, distritos = zip(*[obtener_ubicacion(ubicaciones) for _ in range(entries)])

# Generar valor aleatorio para el teléfono
telefonos = np.random.randint(80000000, 89999999, size=entries)

# Generar valor aleatorio para el correo que genere una cadena de 10 caracteres aleatorios
def generar_correo():
    return (
        ''.join(np.random.choice(list('abcdefghijklmnopqrstuvwxyz'), size=7)) +
        ''.join(np.random.choice(list('1234567890'), size=3)) +
        '@gmail.com'
    )

correos = [generar_correo() for _ in range(entries)]

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
