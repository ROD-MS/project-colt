extends StaticBody3D
class_name Door


@onready var collision: CollisionShape3D = $CSGBakedCollisionShape3D

@export var is_open: bool = false
var can_open: bool = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if is_open:
		global_rotation_degrees.y = 90
	else:
		global_rotation_degrees.y = 90 #mudar para 0 dps


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("interaction") and can_open:
		open()


func _on_detect_player_body_entered(body: Node3D) -> void:
	pass
	#if body is Player:
		#can_open = true


func _on_detect_player_body_exited(body: Node3D) -> void:
	pass
	#if body is Player:
		#can_open = false
		
func open():
	global_rotation_degrees.y = 90
	is_open = true
