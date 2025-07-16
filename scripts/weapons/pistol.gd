extends Weapon

@onready var new_animation = $AnimatedSprite3D

func weapon_up():
	if raycast and !raycast_configured:
		raycast.target_position.z = raycast_distance
	
	#sprite_animation.play("idle")
	#animation_player.play("weapon_up")
	#await animation_player.animation_finished
	print(sprite_animation)
	#sprite_animation.sprite_frames = new_animation.sprite_frames
	#sprite_animation.animation = new_animation.animation
	current_state = STATES.WEAPON_IDLE
	
func weapon_down():
	#sprite_animation.play("idle")
	#animation_player.play("weapon_down")
	#await animation_player.animation_finished
	Change.emit(self, "shotgun")
	
func weapon_idle():
	#sprite_animation.play("idle")
	
	# SHOT
	if Input.is_action_pressed("fire"):
		current_state = STATES.WEAPON_SHOT
		
	# CHANGE WEAPON TO SHOTGUN
	if Input.is_action_just_pressed("2"):
		current_state = STATES.WEAPON_DOWN
	
	if agent.velocity != Vector3.ZERO:
		current_state = STATES.WEAPON_IDLE_MOVE
		
func weapon_idle_move():
	#sprite_animation.play("idle")
	#animation_player.play("weapon_idle_move")
	
	# SHOT
	if Input.is_action_pressed("fire"):
		#animation_player.stop()
		current_state = STATES.WEAPON_SHOT
		
	# CHANGE WEAPON TO SHOTGUN
	if Input.is_action_just_pressed("2"):
		#animation_player.stop()
		current_state = STATES.WEAPON_DOWN
	
	if agent.velocity == Vector3.ZERO:
		#animation_player.stop()
		current_state = STATES.WEAPON_IDLE
		
func weapon_shot():
	#print(animation_player.current_animation)
	#sprite_animation.play("shot")
	
	if raycast.is_colliding() and raycast.get_collider().is_in_group("enemy") and !shotted:
		var enemy = raycast.get_collider()
		var health: HealthComponent = null
		for child in enemy.get_children():
			if child is HealthComponent:
				health = child
				break
				
		if health:
			var attack = Attack.new()
			attack.damage = damage
			attack.knockback_force = knockback_force
			attack.stun_time = stun_time
			
			health.damage(attack)
	
	shotted = true
			
	#await sprite_animation.animation_finished
	shotted = false
	current_state = STATES.WEAPON_IDLE
	
	
	
