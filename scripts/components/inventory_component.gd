extends Node3D
class_name Inventory

@export var initial_weapon: Weapon = null
@export var raycast: RayCast3D = null
@export var sprite_animation: AnimatedSprite3D = null
@export var animation_player: AnimationPlayer = null

var agent: CharacterBody3D = null

var current_weapon = null
var weapons: Dictionary = {}

func _ready():
	agent = get_parent()
	
	for child in get_children():
		if child is Weapon:
			weapons[child.name.to_lower()] = child
			weapons[child.name.to_lower()].agent = agent
			weapons[child.name.to_lower()].raycast = raycast
			weapons[child.name.to_lower()].sprite_animation = sprite_animation
			weapons[child.name.to_lower()].animation_player = animation_player
			child.Change.connect(change_weapon)
			
	if initial_weapon:
		initial_weapon.weapon_up()
		current_weapon = initial_weapon
	
	
func change_weapon(weapon, new_weapon_name):
	if weapon != current_weapon:
		return
		
	var new_weapon = weapons.get(new_weapon_name.to_lower())
	if !new_weapon:
		return
	
	if current_weapon:
		current_weapon.weapon_down()
		
	await current_weapon.animation_player.animation_finished
	new_weapon.weapon_up()
	
	current_weapon = new_weapon
	
func _process(delta):
	if current_weapon:
		current_weapon.update(delta)
	
