extends Node3D

@onready var sprite_animation = $AnimatedSprite3D
@onready var sound = $sound
@onready var kick_raycast: RayCast3D = $kick_raycast
var player: Player = null
var shotted := false

@export_group("Damage config")
@export var damage: float = 10
@export var knockback_force: float = 0
@export var stun_time: float = 0

func _ready():
	print(sprite_animation.animation)
	player = get_owner()
	print("PLAYER KICK:" + str(player))
	kick_raycast.add_exception(player)
	
func _process(delta):
	if !shotted:
		weapon_idle()
	
func weapon_idle():
	sprite_animation.hide()
	
	if Input.is_action_just_pressed("kick"):
		weapon_shot()
		
func weapon_shot():
	sprite_animation.show()
	sprite_animation.play("shoot")
	if !shotted:
		sound.play()
	
	if kick_raycast.is_colliding() and kick_raycast.get_collider() != null and kick_raycast.get_collider().is_in_group("enemy") and !shotted:
		var target = kick_raycast.get_collider() # A CollisionObject3D.
		var shape_id = kick_raycast.get_collider_shape() # The shape index in the collider.
		var owner_id = target.shape_find_owner(shape_id) # The owner ID in the collider.
		var shape = target.shape_owner_get_owner(owner_id)
		
		var headshot: bool = false
		var enemy = kick_raycast.get_collider()
		var health: HealthComponent = null
		
		#if shape.name == "head":
			#headshot = true
		
		for child in enemy.get_children():
			if child is HealthComponent:
				health = child
				break
				
				
		if health:
			var attack = Attack.new()
			if headshot:
				attack.damage = damage * 999
			else:
				attack.damage = damage
			attack.knockback_force = knockback_force
			attack.stun_time = stun_time
			
			health.damage(attack)

	if kick_raycast.is_colliding() and kick_raycast.get_collider() != null and kick_raycast.get_collider() is StaticBody3D and kick_raycast.get_collider().is_in_group("breakable") and !shotted:
		print("AAA")
		var target = kick_raycast.get_collider() as StaticBody3D # A CollisionObject3D.
		print(target)
		target.queue_free()
	
	shotted = true
	await sprite_animation.animation_finished
	shotted = false
	weapon_idle()
	
	
