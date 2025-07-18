extends CharacterBody3D
class_name Player

const SPEED = 2
const JUMP_FORCE = 3
const SHOT = null

@export var state_machine: StateMachine
@export var mouse_sensibility: float = 0.2

@onready var head = $head
@onready var camera = $head/Camera3D

var camera_sense = 0.003
var sprint = 2

func _physics_process(delta):
	#moviment(delta)
	if !is_on_floor():
		velocity += get_gravity() * delta
		
	move_and_slide()

func _ready():
	
	$head/RayCast3D.add_exception(self)
	$HUD/ReferenceRect/hand_animation.position = Vector2(1042, 562)
	var this_level = get_parent()
	if this_level.name == "main":
		$HUD/ReferenceRect/Panel.visible = true
	else:
		$HUD/ReferenceRect/Panel.visible = false
	
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	
	#SETANDO A CAMERA DOS INIMIGOS E ITENS
	get_tree().call_group("enemy_item", "set_camera", camera)
	
func _input(event):
	if event.is_action_pressed("free_mouse"):
		if Input.mouse_mode == Input.MOUSE_MODE_CAPTURED:
			Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
		elif Input.mouse_mode == Input.MOUSE_MODE_VISIBLE:
			Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
			
	if event is InputEventMouseMotion:
		rotate_y(deg_to_rad(-event.relative.x * mouse_sensibility)) 
		head.rotation.x -= event.relative.y * camera_sense
		head.rotation.x = clamp(head.rotation.x, deg_to_rad(-60), deg_to_rad(60))
		#rotate_y(deg_to_rad(-event.relative.x * mouse_sensibility))
		#print(rotation)
		#print(head.rotation)
	
func _on_killzone_body_entered(body):
	if body.name == "player":
		get_tree().reload_current_scene()


func _on_show_tutorial_body_exited(body):
	if body.name == "player":
		$HUD/ReferenceRect/Panel.visible = false
		
		
		
		
	
