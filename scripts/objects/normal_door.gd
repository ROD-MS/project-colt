extends StaticBody3D
class_name Door


@export var level: Level
@export var tutorial: TutorialLevel

@onready var collision: CollisionShape3D = $CSGBakedCollisionShape3D

@export var is_open: bool = false
var can_open: bool = false

@onready var door_kick_sound: AudioStreamPlayer3D = $door_kick
@onready var door_open_sound: AudioStreamPlayer3D = $door_open


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#if is_open:
		#global_rotation_degrees.y = 90
	#else:
		#global_rotation_degrees.y = 0 #mudar para 0 dps
		
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("interaction") and can_open:
		open("normal")


func _on_detect_player_body_entered(body: Node3D) -> void:
	if body is Player:
		can_open = true
		print(is_open)


func _on_detect_player_body_exited(body: Node3D) -> void:
	if body is Player:
		can_open = false
		
func open(how_did_open: String = ""):
	if !is_open:
		if how_did_open == "normal":
			door_open_sound.play()
		elif how_did_open == "":
			door_kick_sound.play()
		
		print(global_rotation_degrees.y)
		
		global_rotation_degrees.y += 90
		
		print(global_rotation_degrees.y)

		is_open = true
