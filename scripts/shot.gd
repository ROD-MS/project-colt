extends CharacterBody3D

const SPEED = 50
var shot_damage: float = 10
var shot_knockback: float = 0
var shot_stun: float = 0

var dont_hit: CharacterBody3D = null

func _physics_process(delta):
	var direction = (transform.basis * Vector3(0, 0, -SPEED).normalized())
	velocity.y = direction.y * SPEED
	velocity.x = direction.x * SPEED
	velocity.z = direction.z * SPEED
	
	if is_on_wall() or is_on_floor() or is_on_ceiling():
		queue_free()
	
	move_and_slide()
	
	
func _on_hitbox_component_area_entered(area):
	print(area)
	if area as HitboxComponent and area.get_parent() != dont_hit:
		print(str(area.get_parent()) + "AQUI1")
		print(str(dont_hit) + "AQUI2")
		var hitbox: HitboxComponent = area
		
		var attack = Attack.new()
		attack.damage = shot_damage
		attack.knockback_force = shot_knockback
		attack.stun_time = shot_stun
		
		hitbox.damage(attack)
