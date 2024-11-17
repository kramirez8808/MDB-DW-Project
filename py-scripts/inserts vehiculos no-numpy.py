import random

# Parámetros
cantidadVehiculos = 900000

# Listas de marcas, modelos y colores
marcas = [
    "Toyota", "Honda", "Ford", "Chevrolet", "Nissan", "Hyundai", "Kia", "Volkswagen", "Subaru", "Mazda",
    "BMW", "Mercedes-Benz", "Audi", "Lexus", "Dodge", "Chrysler", "Jeep", "GMC", "Volvo", "Fiat",
    "Renault", "Peugeot", "Citroën", "Tesla", "Land Rover", "Jaguar", "Porsche", "Mitsubishi", "Ferrari", "Lamborghini",
    "Aston Martin", "Bentley", "Bugatti", "Rolls Royce", "Infiniti", "Acura", "Alfa Romeo", "Cadillac", "Lincoln", "Genesis"
]

modelos = [
    "Corolla", "Civic", "F-150", "Silverado", "Altima", "Elantra", "Sportage", "Jetta", "Impreza", "CX-5",
    "X5", "C-Class", "A4", "RX", "Challenger", "Cherokee", "Sierra", "V60", "500", "A3",
    "Model S", "Model X", "Model 3", "Model Y", "Evoque", "Defender", "Range Rover", "911", "Cayenne", "Outlander",
    "Mustang", "Escalade", "Navigator", "Stelvio", "Giulia", "Murano", "Pathfinder", "Equinox", "Blazer", "Trailblazer"
]

colores = [
    "Rojo", "Azul", "Negro", "Blanco", "Gris", "Verde", "Amarillo", "Naranja", "Violeta", "Marrón",
    "Turquesa", "Cian", "Púrpura", "Plateado", "Oro", "Bronce", "Burdeos", "Beige", "Lila", "Esmeralda"
]

# Generar datos para los vehículos
idsVehiculos = range(1, cantidadVehiculos + 1)
plazas_generadas = []
marcas_generadas = []
modelos_generados = []
colores_generados = []
idClientes_generados = []


cantidadClientes = 875000

for i in range(cantidadVehiculos):
    plaza = f"PLZ-{random.randint(100000, 999999)}"  # Formato de plaza
    marca = random.choice(marcas)
    modelo = random.choice(modelos)
    color = random.choice(colores)
    idCliente = random.randint(1, cantidadClientes)  # Asociar un cliente aleatorio

    plazas_generadas.append(plaza)
    marcas_generadas.append(marca)
    modelos_generados.append(modelo)
    colores_generados.append(color)
    idClientes_generados.append(idCliente)

# Crear la lista de inserciones SQL
inserts_vehiculos = []
for i in range(cantidadVehiculos):
    inserts_vehiculos.append(
        f"INSERT INTO vehiculos (idVehiculo, plaza, marca, modelo, color, idCliente) "
        f"VALUES ({idsVehiculos[i]}, '{plazas_generadas[i]}', '{marcas_generadas[i]}', "
        f"'{modelos_generados[i]}', '{colores_generados[i]}', {idClientes_generados[i]});"
    )

# Imprimir las inserciones
print("\n".join(inserts_vehiculos))