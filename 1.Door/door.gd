extends Node3D

# This script manages door interactions including animations and sound effects for opening and closing actions.
# Este script gestiona las interacciones con puertas, incluyendo animaciones y efectos de sonido para las acciones de abrir y cerrar.

# Animation names for opening and closing the door.
# Nombres de las animaciones para abrir y cerrar la puerta.
@export var open_animation: String
@export var close_animation: String

# Sound effects for opening and closing the door.
# Efectos de sonido para abrir y cerrar la puerta.
@export var open_sound: AudioStream
@export var close_sound: AudioStream

var is_open = false  # Tracks if the door is currently open.
var player_near = false  # Tracks if the player is near the door.
var is_animating = false  # Tracks if the door is currently animating.

@onready var animation_player = $DoorAnimation
@onready var open_sound = $OpenSound
@onready var close_sound = $CloseSound

# Detect if the player enters the interaction area.
# Detecta si el jugador entra en el área de interacción.
func _on_Area_body_entered(body):
    print("Entered object name: ", body.name)
    if body.name == "Player":
        player_near = true
        print("Player has entered the detection area")

# Detect if the player exits the interaction area.
# Detecta si el jugador sale del área de interacción.
func _on_Area_body_exited(body):
    print("Exited object name: ", body.name)
    if body.name == "Player":
        player_near = false
        print("Player has exited the detection area")

# Process interaction with the door.
# Procesa la interacción con la puerta.
func _process(delta):
    if player_near and Input.is_action_just_pressed("ui_interact") and not is_animating:
        print("Player is near and 'E' key pressed")
        toggle_door()

# Toggle the door open or closed.
# Cambia la puerta de abierta a cerrada o viceversa.
func toggle_door():
    is_animating = true
    if is_open:
        animation_player.play(close_animation)
        print("Closing door")
    else:
        animation_player.play(open_animation)
        open_sound.play()
        print("Opening door")
    is_open = !is_open

# Callback when an animation finishes.
# Se llama cuando una animación termina.
func _on_AnimationPlayer_animation_finished(anim_name):
    is_animating = false
    print("Animation finished: ", anim_name)
    if anim_name == close_animation:
        close_sound.play()
