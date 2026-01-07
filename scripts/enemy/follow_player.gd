extends State

var time_reload: float
var enemy: Enemy
var raycast: RayCast3D = null
var detect_player: Area3D = null


func enter():
	enemy = agent as Enemy
	raycast = enemy.raycast
	#detect_player = enemy.detect_player
	time_reload = agent.time_reload_sec
	

func update(delta: float):
	var next_location = enemy.nav.get_next_path_position()
	var current_location = enemy.global_transform.origin
	var new_velocity = (next_location - current_location).normalized() * enemy.SPEED
	#enemy.look_at(Vector3(enemy.nav.target_position), Vector3.,DOWN)
	enemy.rotation.y = cos((enemy.global_position - enemy.nav.target_position).length())
	
	#enemy.look_at(Vector3(enemy.nav.target_position), Vector3.DOWN)
	raycast.look_at(Vector3(enemy.nav.target_position), Vector3.DOWN)
	
	if time_reload > 0:
		time_reload -= 0.016
		print("time_reload: " + str(time_reload))
	
	if enemy.follow:
		if !enemy.is_in_group("enemy_stopped") and !enemy.is_in_group("enemy_range"):
			enemy.velocity = enemy.velocity.move_toward(new_velocity, 0.25)
			
		if enemy.is_in_group("enemy_range") and raycast.get_collider() and raycast.get_collider() is Player:
				enemy.velocity = Vector3.ZERO
		elif enemy.is_in_group("enemy_range") and !raycast.get_collider() or enemy.is_in_group("enemy_range") and !raycast.get_collider() is Player:
				enemy.velocity = enemy.velocity.move_toward(new_velocity, 0.25)
		
		if time_reload <= 0:
			Transitioned.emit(self, "shoot")
			
	else:
		Transitioned.emit(self, "idle")
	

#
#func _on_detect_player_body_exited(body):
	#if body.name == "player":
		#agent.follow = false
		#Transitioned.emit(self, "idle")
