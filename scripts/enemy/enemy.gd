extends CharacterBody3D
class_name Enemy

const SPEED = 2

@export var damage: int = 10
@export var time_reload_sec = 0
@export var knockback_force = 0
@export var stun_time = 0

@onready var nav = $nav
@onready var sounds = $sounds

var follow: bool = false
var sound_list: Array
var timer: int = 0
var player: Player = null

func _ready():
	#print(get_parent().get_children())
	for child in get_parent().get_children():
		print(child)
		print(player)
		if child is Player:
			player = child
			break
		
	$RayCast3D.add_exception(self)
	for sound in sounds.get_children():
		sound_list.append(sound)
	randomize()
	timer = randi_range(2, 8)
	
	
	print(player)
	
func _physics_process(delta):
	if not is_on_floor():
		velocity += get_gravity() * delta
	
	sound(delta)
	if player:
		target_position(player.position)
	move_and_slide()
		
func target_position(target):
	nav.target_position = target
	
func sound(delta):
	if timer <= 0:
		randomize()
		# PLAY SOUND
		var random_sound: int = randi_range(0, 3)
		sound_list[random_sound].play()
		
		# RANDOMIZE TIME AGAIN
		var _timer = randi_range(2, 8)
		timer = 60 * _timer
		
	timer -= 1 * delta
