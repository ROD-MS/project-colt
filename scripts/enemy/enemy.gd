extends CharacterBody3D
class_name Enemy

const SPEED := 5.0


@onready var panela: AudioStreamPlayer3D = $panela
@onready var particles: CPUParticles3D = $CPUParticles3D


@export var damage: int = 10
@export var time_reload_sec = 0
@export var knockback_force = 0
@export var stun_time = 0
@export var enemy_value: float = 10

@export var current_level: Level

@onready var nav = $nav
@onready var sounds = $sounds
@onready var detect_player: Area3D = $detect_player
@onready var raycast: RayCast3D = $RayCast3D
@onready var collision: CollisionShape3D = $CollisionShape3D
@onready var collision_area: Area3D = null

const ENEMY_ITEM = preload("res://scenes/objects/item_test_enemy.tscn")

var follow: bool = false
var sound_list: Array
var timer: int = 0
var player: Player = null
var last_position: Vector3 = Vector3.ZERO
var knockbacking: bool = false

var move_timer: Timer = null
@onready var state_machine: StateMachine = $StateMachine

func _ready():
	if current_level: # APENAS PARA O TUTORIAL
		current_level.add_target_counter()
		
	
	
	for col in get_children():
		if col.name == "detect_collision":
			collision_area = col as Area3D
			collision_area.monitoring = false

	knockbacking = false
	for child in get_children():
		if child is GPUParticles3D:
			var _particles = child as GPUParticles3D
	
	#print(get_parent().get_children())
	for child in get_parent().get_children():
		#print(child)
		#print(player)
		if child is Player:
			player = child
			break
			
	for child in get_children():
		#print(child)
		#print(player)
		if child is Timer:
			move_timer = child as Timer
			break
	
	if $RayCast3D:
		$RayCast3D.add_exception(self)
	if sounds:
		for sound in sounds.get_children():
			sound_list.append(sound)
	randomize()
	timer = randi_range(2, 8)
	
	if detect_player:
		detect_player.process_mode = Node.PROCESS_MODE_DISABLED
	
func _physics_process(delta):
	if not is_on_floor():
		velocity += get_gravity() * delta
		
	
	if get_parent().name != "menu_scene":
		sound(delta)
		
	if player:
		target_position(player.position)
		
	velocity.x = move_toward(velocity.x, 0, SPEED*0.05)
	velocity.z = move_toward(velocity.z, 0, SPEED*0.05)
		
	move_and_slide()
	
	#print(state_machine.current_state)
	#print("enemy follow: " + str(follow))
	last_position = global_position
	#print("enemy parent: " +str(last_position))
	
func _process(delta: float) -> void:
	if collision_area:
		if knockbacking:
			collision_area.monitoring = true
		else:
			collision_area.monitoring = false
	
	
func _exit_tree() -> void:
	Score_control.add_normal_point(enemy_value)
	collision.disabled = true
	if current_level:
		current_level.sub_target_counter()
	
		
func target_position(target):
	nav.target_position = target
	
func sound(delta):
	if timer <= 0:
		randomize()
		# PLAY SOUND
		var random_sound: int = randi_range(0, 3)
		if sound_list:
			sound_list[random_sound].play()
		
		# RANDOMIZE TIME AGAIN
		var _timer = randi_range(5, 15)
		timer = 60 * _timer
		
	timer -= 1 * delta


func _on_detect_collision_body_entered(body: Node3D) -> void:
	if body is ExplosionItem:
		var barrel: ExplosionItem = body as ExplosionItem
		barrel.explosion()
