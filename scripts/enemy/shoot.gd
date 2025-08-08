extends State

@export var time_reload_sec: float
@export var raycast: RayCast3D

var time_reload: float
var attack: bool = false

var damage: int = 0
var knockback_force = 0
var stun_time = 0

func enter():
	time_reload = time_reload_sec
	damage = agent.damage
	knockback_force = agent.knockback_force
	stun_time = agent.stun_time
	attack = true
	
func update(delta):
	await get_tree().create_timer(0.1).timeout
	if attack:
		shoot()
		attack = false

	if agent.follow:
		Transitioned.emit(self, "followPlayer")
	else:
		Transitioned.emit(self, "idle")

func shoot():
	if raycast.get_collider() and raycast.get_collider().name == "player":
		var health: HealthComponent = null
		var player = raycast.get_collider()
		for child in player.get_children():
			if child is HealthComponent:
				health = child
				break
			
		if health:
			var attack = Attack.new()
			attack.damage = damage
			attack.knockback_force = knockback_force
			attack.stun_time = stun_time
			
			
			health.damage(attack)
