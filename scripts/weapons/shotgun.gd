extends Weapon
class_name shotgun

@onready var new_sprite_animation = $AnimatedSprite3D
var shotgun_raycast = null

func weapon_up():
	if raycast and !raycast_configured:
		raycast.target_position.z = raycast_distance
		for child in get_owner().get_children():
			if child is Head:
				for _child in child.get_children():
					if _child.name == "shotgun_raycast":
						shotgun_raycast = _child
						break
		for child in shotgun_raycast.get_children():
			pass
	
	sprite_animation.play("idle")
	sprite_animation.sprite_frames = new_sprite_animation.sprite_frames
	sprite_animation.animation = new_sprite_animation.animation
	animation_player.play("shotgun_up")
	await animation_player.animation_finished
	current_state = STATES.WEAPON_IDLE
	
func weapon_down():
	#print("down shotgun")
	sprite_animation.play("idle")
	animation_player.play("shotgun_down")
	#Change.emit(self, "pistol")
	
func weapon_idle():
	#print("idle shotgun")
	sprite_animation.play("idle")
	
	# SHOT
	if Input.is_action_pressed("fire"):
		current_state = STATES.WEAPON_SHOT
		
	# CHANGE WEAPON TO SHOTGUN
	if Input.is_action_just_pressed("change_to_pistol"):
		Change.emit(self, "pistol")
		
	if Input.is_action_just_pressed("reload"):
		current_state = STATES.WEAPON_RELOAD
		
func weapon_shot():
	#print("shoot shotgun")
	sprite_animation.play("shoot")
	
	#create_raycast()
	
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


	for __raycast in shotgun_raycast.get_children():
		var _raycast = __raycast as RayCast3D
		if _raycast.is_colliding() and _raycast.get_collider().is_in_group("enemy"):
			pass
	
	shotted = true
			
	await sprite_animation.animation_finished
	shotted = false
	current_state = STATES.WEAPON_IDLE

func weapon_reload():
	animation_player.play("shotgun_reload")
	await animation_player.animation_finished
	current_state = STATES.WEAPON_IDLE
	
	
	
