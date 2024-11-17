import random
import pandas as pd

# Parámetros
cantidadClientes = 875000

# Listas de nombres y apellidos
nombresclientes = [
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

apellidos = [
    "González", "Rodríguez", "Pérez", "Fernández", "López", "Martínez", "García", "Sánchez", "Romero", "Torres",
    "Hernández", "Vázquez", "Castillo", "Morales", "Silva", "Ortega", "Rojas", "Jiménez", "Flores", "Benítez",
    "Molina", "Medina", "Arias", "Cabrera", "Herrera", "Ponce", "Ramos", "Sosa", "Reyes", "Navarro",
    "Aguilar", "Rivera", "Suárez", "Cruz", "Méndez", "Valenzuela", "Salinas", "Vera", "Campos", "Bravo",
    "Orellana", "Montoya", "Peña", "Fuentes", "Escobar", "Guzmán", "Cordero", "Chávez", "Lara", "Pizarro",
    "Carrillo", "Valle", "Contreras", "Tapia", "Godoy", "Ibáñez", "Araya", "Palacios", "Leiva", "Cáceres",
    "Vargas", "Ramos", "Espinoza", "Álvarez", "Salazar", "Riquelme", "Muñoz", "Bustamante", "Santana", "Villalobos"
]


# Listas para provincias y distritos
provincias = [
    "San José", "Alajuela", "Cartago", "Guanacaste", 
    "Heredia", "Puntarenas", "Limón"
]

distritos = [
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
    "Coto Brus", "Parrita", "Golfito", "Corredores", "Manuel Antonio", 
    "Limón", "Guácimo", "Pococí", "Siquirres", "Talamanca", 
    "Matina", "Batán", "Río Blanco", "San José"
]

# Generar datos para los clientes
idsClientes = range(1, cantidadClientes + 1)
nombres_generados = []
apellidos_generados = []
telefonos_generados = []
correos_generados = []
provincias_generadas = []
distritos_generados = []

for _ in range(cantidadClientes):
    nombre = random.choice(nombresclientes)
    apellido = random.choice(apellidos)
    telefono = random.randint(10000000, 99999999)
    correo = f"{nombre.lower()}.{apellido.lower()}@gmail.com"
    provincia = random.choice(provincias)
    distrito = random.choice(distritos)

    nombres_generados.append(nombre)
    apellidos_generados.append(apellido)
    telefonos_generados.append(telefono)
    correos_generados.append(correo)
    provincias_generadas.append(provincia)
    distritos_generados.append(distrito)

# Crear un DataFrame de pandas con los datos generados
datos = {
    'idCliente': idsClientes,
    'nombreCliente': nombres_generados,
    'apellidoCliente': apellidos_generados,
    'telefono': telefonos_generados,
    'correo': correos_generados,
    'provincia': provincias_generadas,
    'distrito': distritos_generados
}

df_clientes = pd.DataFrame(datos)

# Mostrar el DataFrame
print(df_clientes.head())