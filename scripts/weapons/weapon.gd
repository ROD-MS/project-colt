extends Node3D
class_name Weapon

signal Change

enum STATES {
	WEAPON_UP,
	WEAPON_DOWN,
	WEAPON_IDLE,
	WEAPON_SHOT,
	WEAPON_RELOAD
}

var raycast_configured: bool = false


@export var space_bar: int = 1
@export var raycast_distance: float = 10
@export var default_position: Vector3

@export_group("Damage config")
@export var damage: float = 10
@export var knockback_force: float = 0
@export var stun_time: float = 0

@export_group("Ammo config")
@export var max_ammo: int = 0
@export var max_ammo_reload: int = 0

var ammo_remaining: int = 0
var ammo_in_weapon: int = 0

# RECEBE DO INVENTORY
var agent: CharacterBody3D = null
var raycast: RayCast3D = null
var sprite_animation: AnimatedSprite3D = null
var animation_player: AnimationPlayer = null

var shoot_sound: AudioStreamPlayer = null


var current_state = STATES.WEAPON_UP

var shotted: bool = false
var active: bool = false
	
func _ready():
	raycast_distance = -raycast_distance
	for child in get_children():
		if child is AudioStreamPlayer:
			shoot_sound = child
	
	ammo_remaining = max_ammo
	ammo_in_weapon = max_ammo_reload
	
func update(delta):
	match current_state:
		#STATES.WEAPON_UP:
			#weapon_up()
		#STATES.WEAPON_DOWN:
			#weapon_down()
		STATES.WEAPON_IDLE:
			weapon_idle()
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
	
func weapon_shot():
	pass
	
func weapon_reload():
	pass
	
func sub_ammo(ammo_used: int):
	ammo_in_weapon -= ammo_used
	print("MUNIÇÃO NA ARMA: " + str(ammo_in_weapon))
	print("MUNIÇÃO TOTAL: " + str(ammo_remaining))
	
func add_ammo(ammo_added: int):
	var adding_ammo: int = ammo_added/ammo_added
	
	for x in ammo_added:
		if ammo_remaining == max_ammo:
			print("RETORNOU")
			if agent.ammo_counter:
				agent.ammo_counter.text = str(ammo_in_weapon) + "/" + str(ammo_remaining)
			return
		ammo_remaining += adding_ammo
		print("MUNICAO ATUAL: " + str(ammo_remaining))
		
	if agent.ammo_counter:
		agent.ammo_counter.text = str(ammo_in_weapon) + "/" + str(ammo_remaining)
	print("MUNIÇÃO TOTAL: " + str(ammo_remaining))
	
func reload_ammo():
	for x in max_ammo_reload:
		if ammo_in_weapon == max_ammo_reload:
			return
		if ammo_remaining > 0:
			ammo_in_weapon += 1
			ammo_remaining -= 1
			
	print("MUNIÇÃO NA ARMA: " + str(ammo_in_weapon))
	print("MUNIÇÃO TOTAL: " + str(ammo_remaining))
	
