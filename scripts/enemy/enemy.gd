extends CharacterBody3D
class_name Enemy

const SPEED = 5

@export var damage: int = 10
@export var time_reload_sec = 0
@export var knockback_force = 0
@export var stun_time = 0
@export var enemy_value: float = 10

@onready var nav = $nav
@onready var sounds = $sounds
@onready var detect_player: Area3D = $detect_player
@onready var raycast: RayCast3D = $RayCast3D

var follow: bool = false
var sound_list: Array
var timer: int = 0
var player: Player = null

var move_timer: Timer = null
@onready var state_machine: StateMachine = $StateMachine

func _ready():
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
		
	$RayCast3D.add_exception(self)
	for sound in sounds.get_children():
		sound_list.append(sound)
	randomize()
	timer = randi_range(2, 8)
	
	detect_player.process_mode = Node.PROCESS_MODE_DISABLED
	
func _physics_process(delta):
	if not is_on_floor():
		velocity += get_gravity() * delta
		
	
	if get_parent().name != "menu_scene":
		sound(delta)
		
	if player:
		target_position(player.position)
	move_and_slide()
	
	print(state_machine.current_state)
	print("enemy follow: " + str(follow))
	
func _exit_tree() -> void:
	Score_control.add_normal_point(enemy_value)
		
func target_position(target):
	nav.target_position = target
	
func sound(delta):
	if timer <= 0:
		randomize()
		# PLAY SOUND
		var random_sound: int = randi_range(0, 3)
		sound_list[random_sound].play()
		
		# RANDOMIZE TIME AGAIN
		var _timer = randi_range(5, 15)
		timer = 60 * _timer
		
	timer -= 1 * delta
