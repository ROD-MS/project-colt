extends Node3D

@export_group("Bobbing Settings")
@export var bob_frequency = 2.0
@export var bob_amplitude = 0.20
@export var bob_smoothing = 8.0

# ARRUMA ISSO AQ TÔ CODANDO NO DISCORD KKKKKKKKKKKKKK
@onready var player: CharacterBody3D = $".."
@onready var inventory = $"../inventory_component"

var bob_time = 0.0
var min_velocity_threshold = 0.1


func _process(delta):
	var horizontal_velocity = Vector2(player.velocity.x, player.velocity.z).length()
	var bob_target = Vector3.ZERO
	var weapon = inventory.current_weapon.sprite_animation
	var weapon_start_position = inventory.current_weapon.default_position
	var bob_target_weapon = weapon_start_position

	if player.is_on_floor() and horizontal_velocity > min_velocity_threshold:
		bob_time += delta * horizontal_velocity * bob_frequency

		bob_target.x = cos(bob_time) * bob_amplitude
		bob_target.y = sin(bob_time * 2) * bob_amplitude * 0.5
		
		bob_target_weapon.x = cos(bob_time) * bob_amplitude * 0.1 + weapon_start_position.x
		bob_target_weapon.y = sin(bob_time) * bob_amplitude * 0.05 + weapon_start_position.y
		
	else:
		bob_time = 0

	#$Camera3D.position = position.move_toward(bob_target, delta * bob_smoothing)
	#$RayCast3D.position = position.move_toward(bob_target, delta * bob_smoothing)
	position = position.move_toward(bob_target, delta * bob_smoothing)
	#$RayCast3D.position = position.move_toward(bob_target, delta * bob_smoothing)
	$hand_animation.position = $hand_animation.position.move_toward(bob_target_weapon, delta * bob_smoothing)
