extends CharacterBody3D
class_name Enemy

const SPEED = 2

@export var damage: int = 10
@export var time_reload_sec = 0
@export var knockback_force = 0
@export var stun_time = 0

@onready var nav = $nav

var follow: bool = false

func _ready():
	$RayCast3D.add_exception(self)
	
func _physics_process(delta):
	if not is_on_floor():
		velocity += get_gravity() * delta
	
	move_and_slide()
		
func target_position(target):
	nav.target_position = target
