extends CharacterBody3D

const SPEED = 2
const SHOT = preload("res://scenes/shot.tscn")

@onready var nav = $nav

var follow: bool = false

func _ready():
	$RayCast3D.add_exception($"../player")
	
func _physics_process(delta):
	if not is_on_floor():
		velocity += get_gravity() * delta
	
	if follow:
		shot()
	
	move_and_slide()
		
func target_position(target):
	nav.target_position = target
	
func shot():
	$ShotComponent.shot()
