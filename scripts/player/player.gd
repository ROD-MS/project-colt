extends CharacterBody3D

const SPEED = 2
const JUMP_FORCE = 3
const SHOT = null

@export var state_machine: StateMachine

@onready var head = $head
@onready var camera = $head/Camera3D

var camera_sense = 0.003
var sprint = 2
var gun_inventory = ["pistol", "shotgun"]

var current_gun: String = ""

func _physics_process(delta):
	#moviment(delta)
	if !is_on_floor():
		velocity += get_gravity() * delta
		
	move_and_slide()

func _ready():
	current_gun = gun_inventory[0]
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
		head.rotation.y -= event.relative.x * camera_sense
		head.rotation.x -= event.relative.y * camera_sense
		head.rotation.x = clamp(head.rotation.x, deg_to_rad(-60), deg_to_rad(60))
	
	if event != InputEventMouseButton:
		change_gun(event)
		
	shot(event)
	
	#await $HUD/ReferenceRect/hand_animation.animation_finished
	#$HUD/ReferenceRect/hand_animation.play("default")
		
#func moviment(delta):
	## Add the gravity.
	#if !is_on_floor():
		#velocity += get_gravity() * delta
#
	## Handle jump.
	#if Input.is_action_just_pressed("jump") and is_on_floor():
		#velocity.y = JUMP_FORCE
		#
	#if Input.is_action_pressed("sprint"):
		#sprint = 2
	#else:
		#sprint = 0
#
	## Get the input direction and handle the movement/deceleration.
	## As good practice, you should replace UI actions with custom gameplay actions.
	#var input_dir = Input.get_vector("left", "right", "foward", "back")
	#var direction = ($head.transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	#if direction:
		#velocity.x = direction.x * (SPEED + sprint)
		#velocity.z = direction.z * (SPEED + sprint)
	#else:
		#velocity.x = move_toward(velocity.x, 0, SPEED)
		#velocity.z = move_toward(velocity.z, 0, SPEED)
#
	#move_and_slide()
	
func shot(event):
	if event.is_action_pressed("fire"):
		$ShotComponent.shot()
		match current_gun:
			"pistol":
				$HUD/ReferenceRect/hand_animation.play("pistol_fire")
				await $HUD/ReferenceRect/hand_animation.animation_finished
				$HUD/ReferenceRect/hand_animation.play("pistol_idle")
			"shotgun":
				$HUD/ReferenceRect/hand_animation.play("shotgun_fire")
				await $HUD/ReferenceRect/hand_animation.animation_finished
				$HUD/ReferenceRect/hand_animation.play("shotgun_idle")


func _on_killzone_body_entered(body):
	if body.name == "player":
		get_tree().reload_current_scene()


func _on_show_tutorial_body_exited(body):
	if body.name == "player":
		$HUD/ReferenceRect/Panel.visible = false
		
		
func change_gun(event):
	# INPUT
	if event.is_action_pressed("change_to_pistol"):
		print(gun_inventory[0])
		current_gun = gun_inventory[0]
		
	if event.is_action_pressed("change_to_shotgun"):
		print(gun_inventory[1])
		current_gun = gun_inventory[1]
		
	# CHANGE GUN
	match current_gun:
		"pistol":
			$HUD/ReferenceRect/hand_animation.position = Vector2(1042, 562)
			$HUD/ReferenceRect/hand_animation.play("pistol_idle")
		"shotgun":
			$HUD/ReferenceRect/hand_animation.position = Vector2(615, 562)
			$HUD/ReferenceRect/hand_animation.play("shotgun_idle")
	
