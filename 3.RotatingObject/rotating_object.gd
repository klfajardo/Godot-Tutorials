extends MeshInstance3D

# This script makes the object rotate around a specified axis with optional turbulence effect.
# Este script hace que el objeto rote alrededor de un eje especificado con un efecto de turbulencia opcional.

# Base rotation speed of the object.
# Velocidad de rotación base del objeto.
@export var rotation_speed: float = 2

# Intensity of the turbulence effect.
# Intensidad del efecto de turbulencia.
@export var turbulence_intensity: float = 0.85

# Frequency of the turbulence effect.
# Frecuencia del efecto de turbulencia.
@export var turbulence_frequency: float = 0.5

# Rotation axis, default is the X-axis.
# Eje de rotación, por defecto es el eje X.
@export var rotation_axis: Vector3 = Vector3(1, 0, 0)

var time_passed: float = 0.0  # Time accumulator to calculate turbulence.

# Called every frame, handles rotation and turbulence.
# Se llama en cada cuadro, maneja la rotación y la turbulencia.
func _process(delta):
    if delta <= 0:
        return  # Ensure delta is positive to avoid errors.

    time_passed += delta
    
    # Calculate turbulence using a sine wave.
    # Calcular la turbulencia usando una onda seno.
    var turbulence = sin(time_passed * turbulence_frequency) * turbulence_intensity
    
    # Calculate the current rotation speed with added turbulence.
    # Calcular la velocidad de rotación actual con la turbulencia añadida.
    var current_rotation_speed = rotation_speed + turbulence
    
    # Apply the rotation on the specified axis.
    # Aplicar la rotación en el eje especificado.
    rotate(rotation_axis, deg_to_rad(current_rotation_speed * delta))

# Function to dynamically update the rotation axis.
# Función para actualizar dinámicamente el eje de rotación.
func set_rotation_axis(axis: Vector3):
    rotation_axis = axis
