extends Node3D
class_name Kick

@onready var knockback_timer: Timer = $knockback_timer
@onready var sprite_animation = $AnimatedSprite3D
@onready var sound = $sound
@onready var kick_raycast: RayCast3D = $kick_raycast
var player: Player = null
var shotted := false
var slide_shotted := false

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
		#if player.state_machine.current_state.name == "slide":
			#kick_raycast.target_position = -player.velocity.normalized()
		#else:
			#kick_raycast.target_position = Vector3(0, 0, -1.5)
		weapon_idle()
	print(shotted)
	
func weapon_idle():
	sprite_animation.hide()
	
	if player.state_machine.current_state.name != "slide":
		slide_shotted = false
	
	if Input.is_action_just_pressed("kick") and player.state_machine.current_state.name != "slide":
		weapon_shot(kick_raycast)
	## =====================
	## KICK WHILE SLIDE
	#if player.state_machine.current_state.name == "slide":
		#if kick_raycast.is_colliding() and kick_raycast.get_collider() != null and kick_raycast.get_collider().is_in_group("enemy") and !shotted:
			#var target = kick_raycast.get_collider() # A CollisionObject3D.
			#var shape_id = kick_raycast.get_collider_shape() # The shape index in the collider.
			#var owner_id = target.shape_find_owner(shape_id) # The owner ID in the collider.
			#var shape = target.shape_owner_get_owner(owner_id)
			#
			#var headshot: bool = false
			#var enemy = kick_raycast.get_collider()
			#var health: HealthComponent = null
			#
			##if shape.name == "head":
				##headshot = true
			#
			#for child in enemy.get_children():
				#if child is HealthComponent:
					#health = child
					#break
					#
					#
			#if health:
				#var attack = Attack.new()
				#if headshot:
					#attack.damage = damage * 999
				#else:
					#attack.damage = damage
				#attack.knockback_force = knockback_force
				#attack.stun_time = stun_time
				#
				#health.damage(attack)
				#
				#var knockback_direction = -(player.global_position - enemy.global_position).normalized()
				#print("ridectoin:" + str(knockback_direction))
				#print(Vector3(1, 1, 1))
				#var knockback = knockback_direction * attack.knockback_force
	#
				#knockback_timer.start(1)
	#
				#player.velocity = -knockback/4
				#
				#sprite_animation.show()
				#sprite_animation.play("shoot")
			#
		#if sprite_animation.is_playing():
			#shotted = true
			#await sprite_animation.animation_finished
			#shotted = false
			#weapon_idle()
		
func weapon_shot(_raycast: RayCast3D):
	sprite_animation.show()
	sprite_animation.play("shoot")
	if !shotted:
		sound.play()
	
	if _raycast.is_colliding() and _raycast.get_collider() != null and _raycast.get_collider().is_in_group("enemy") and !shotted:
		var target = _raycast.get_collider() # A CollisionObject3D.
		var shape_id = _raycast.get_collider_shape() # The shape index in the collider.
		var owner_id = target.shape_find_owner(shape_id) # The owner ID in the collider.
		var shape = target.shape_owner_get_owner(owner_id)
		
		var headshot: bool = false
		var enemy = _raycast.get_collider()
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
			
			#var knockback_direction = -(player.global_position - enemy.global_position).normalized()
			#print("ridectoin:" + str(knockback_direction))
			#print(Vector3(1, 1, 1))
			#var knockback = knockback_direction * attack.knockback_force
#
			#knockback_timer.start(1)
			#
			#player.velocity = Vector3.ZERO
			#player.velocity = -knockback
			#
			
			health.damage(attack)

	if _raycast.is_colliding() and _raycast.get_collider() != null and _raycast.get_collider() is StaticBody3D and _raycast.get_collider().is_in_group("breakable") and !shotted:
		print("AAA")
		var target = kick_raycast.get_collider() as StaticBody3D # A CollisionObject3D.
		print(target)
		target.queue_free()
	
	shotted = true
	await sprite_animation.animation_finished
	shotted = false
	weapon_idle()
	
func slide_shot(_raycast: RayCast3D):
	# =====================
	# KICK WHILE SLIDE
	if player.state_machine.current_state.name == "slide" and !slide_shotted:
		if _raycast.is_colliding() and _raycast.get_collider() != null and _raycast.get_collider().is_in_group("enemy") and !shotted:
			var target = _raycast.get_collider() # A CollisionObject3D.
			var shape_id = _raycast.get_collider_shape() # The shape index in the collider.
			var owner_id = target.shape_find_owner(shape_id) # The owner ID in the collider.
			var shape = target.shape_owner_get_owner(owner_id)
			
			var headshot: bool = false
			var enemy = _raycast.get_collider()
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
				
				#var knockback_direction = -(player.global_position - enemy.global_position).normalized()
				#print("ridectoin:" + str(knockback_direction))
				#print(Vector3(1, 1, 1))
				#var knockback = knockback_direction * attack.knockback_force
	#
				#knockback_timer.start(1)
	#
				player.velocity = Vector3.ZERO
				
				sprite_animation.show()
				sprite_animation.play("shoot")
			
		if sprite_animation.is_playing():
			shotted = true
			await sprite_animation.animation_finished
			shotted = false
			slide_shotted = true
			weapon_idle()
