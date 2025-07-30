extends Weapon
class_name pistol

@onready var new_sprite_animation = $AnimatedSprite3D
var shotgun_raycast: Node3D = null

func weapon_up():
	#print("entered pistol")
	if raycast and !raycast_configured:
		raycast.target_position.z = raycast_distance
	
	if raycast and !raycast_configured:
		raycast.target_position.z = raycast_distance
		for child in get_owner().get_children():
			if child is Head:
				for _child in child.get_children():
					if _child.name == "shotgun_raycast":
						shotgun_raycast = _child
						break
						
	for child in shotgun_raycast.get_children():
		var raycast = child as RayCast3D
		raycast.target_position.z = raycast_distance
		raycast.add_exception(agent)
	
	sprite_animation.play("idle")
	sprite_animation.sprite_frames = new_sprite_animation.sprite_frames
	sprite_animation.animation = new_sprite_animation.animation
	animation_player.play("pistol_up")
	await animation_player.animation_finished
	current_state = STATES.WEAPON_IDLE
	
func weapon_down():
	#print("down pistol")
	sprite_animation.play("idle")
	animation_player.play("pistol_down")
	#Change.emit(self, "shotgun")
	
func weapon_idle():
	#print("idle pistol")
	sprite_animation.play("idle")
	
	# SHOT
	if Input.is_action_pressed("fire"):
		current_state = STATES.WEAPON_SHOT
		
	# CHANGE WEAPON TO SHOTGUN
	if Input.is_action_just_pressed("change_to_shotgun"):
		Change.emit(self, "shotgun")
		
func weapon_shot():
	sprite_animation.play("shoot")
	
	if raycast.is_colliding() and raycast.get_collider() != null and raycast.get_collider().is_in_group("enemy") and !shotted:
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
			
	await sprite_animation.animation_finished
	shotted = false
	current_state = STATES.WEAPON_IDLE
	
	
	
