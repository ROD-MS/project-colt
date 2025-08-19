extends StaticBody3D
class_name DoorButton

@onready var sound: AudioStreamPlayer3D = $sound
@onready var animation: AnimationPlayer = $animation

var can_press: bool = false
var pressed: bool = false

signal click

func _ready() -> void:
	pass

func _process(delta: float) -> void:
	if can_press and Input.is_action_just_pressed("interaction"):
		click.emit()
		pressed = true
		can_press = false
		animation.play("pressed")
		sound.play()
		

func _on_brunos_button_body_entered(body: Node3D) -> void:
	if body.name == "player" and !pressed:
		can_press = true

func _on_brunos_button_body_exited(body: Node3D) -> void:
	if body.name == "player" and !pressed:
		can_press = false
