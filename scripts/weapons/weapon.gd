extends Node3D
class_name Weapon

signal Change

enum STATES {
	WEAPON_UP,
	WEAPON_DOWN,
	WEAPON_IDLE,
	WEAPON_IDLE_MOVE,
	WEAPON_SHOT,
	WEAPON_RELOAD
}

var raycast_configured: bool = false

@export var space_bar: int = 1
@export var raycast_distance: float = 10

# DAMAGE CONFIG
@export var damage: int = 10
@export var knockback_force = 0
@export var stun_time = 0

var agent: CharacterBody3D = null
var raycast: RayCast3D = null
var sprite_animation: AnimatedSprite2D = null
var animation_player: AnimationPlayer = null

var current_state = STATES.WEAPON_UP

var shotted: bool = false

func _ready():
	sprite_animation = $animation/ReferenceRect/AnimatedSprite2D
	animation_player = $AnimationPlayer
	raycast_distance = -raycast_distance
	
func _process(delta):
	match current_state:
		STATES.WEAPON_UP:
			weapon_up()
		STATES.WEAPON_DOWN:
			weapon_down()
		STATES.WEAPON_IDLE:
			weapon_idle()
		STATES.WEAPON_IDLE_MOVE:
			weapon_idle_move()
		STATES.WEAPON_SHOT:
			weapon_shot()
		STATES.WEAPON_RELOAD:
			weapon_reload()
			

func weapon_up():
	pass
	
func weapon_down():
	pass
	
func weapon_idle():
	pass
	
func weapon_idle_move():
	pass
	
func weapon_shot():
	pass
	
func weapon_reload():
	pass
	
