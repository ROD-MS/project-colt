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
	player = get_owner()
	kick_raycast.add_exception(player)
	
func _process(delta):
	if !shotted:
		#if player.state_machine.current_state.name == "slide":
			#kick_raycast.target_position = -player.velocity.normalized()
		#else:
			#kick_raycast.target_position = Vector3(0, 0, -1.5)
		weapon_idle()
	
func weapon_idle():
	sprite_animation.hide()
	
	if player.state_machine.current_state.name != "slide":
		slide_shotted = false
	
	if Input.is_action_just_pressed("kick") and player.state_machine.current_state.name != "slide":
		weapon_shot(kick_raycast)

		
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

			
			health.damage(attack)

	if _raycast.is_colliding() and _raycast.get_collider() != null and _raycast.get_collider() is Breakable and _raycast.get_collider().is_in_group("breakable") and !shotted:
		var target = kick_raycast.get_collider() as Breakable # A CollisionObject3D.
		target.destroy()

	if _raycast.is_colliding() and _raycast.get_collider() != null and _raycast.get_collider() is Door and !shotted:
		var door: Door = _raycast.get_collider() as Door
		door.open()
	
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

		if _raycast.is_colliding() and _raycast.get_collider() != null and _raycast.get_collider() is Door and !shotted:
			var door: Door = _raycast.get_collider() as Door
			door.open()
