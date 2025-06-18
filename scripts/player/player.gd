extends CharacterBody3D

const SPEED = 2
const JUMP_FORCE = 3
const SHOT = null

@export var state_machine: StateMachine

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
	$HUD/ReferenceRect/Panel.visible = true
	
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
		head.rotation.y -= event.relative.x * camera_sense
		head.rotation.x -= event.relative.y * camera_sense
		head.rotation.x = clamp(head.rotation.x, deg_to_rad(-60), deg_to_rad(60))
		
	shot(event)
	
	#await $HUD/ReferenceRect/hand_animation.animation_finished
	#$HUD/ReferenceRect/hand_animation.play("default")
		
func moviment(delta):
	# Add the gravity.
	if !is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_FORCE
		
	if Input.is_action_pressed("sprint"):
		sprint = 2
	else:
		sprint = 0

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir = Input.get_vector("left", "right", "foward", "back")
	var direction = ($head.transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		velocity.x = direction.x * (SPEED + sprint)
		velocity.z = direction.z * (SPEED + sprint)
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)

	move_and_slide()
	
func shot(event):
	if event.is_action_pressed("fire"):
		$ShotComponent.shot()
		$HUD/ReferenceRect/hand_animation.play("fire")
		await $HUD/ReferenceRect/hand_animation.animation_finished
		$HUD/ReferenceRect/hand_animation.play("default")


func _on_killzone_body_entered(body):
	if body.name == "player":
		get_tree().reload_current_scene()


func _on_show_tutorial_body_exited(body):
	if body.name == "player":
		$HUD/ReferenceRect/Panel.visible = false
