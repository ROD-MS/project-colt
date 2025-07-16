extends State

var time_reload: float
var enemy: Enemy

func enter():
	enemy = agent as Enemy
	print(str(name) + ": FOLLOW PLAYER")
	time_reload = agent.time_reload_sec
	

func update(delta: float):
	var next_location = agent.nav.get_next_path_position()
	var current_location = agent.global_transform.origin
	var new_velocity = (next_location - current_location).normalized() * agent.SPEED
	enemy.look_at(Vector3(agent.nav.target_position), Vector3.DOWN)
	
	if time_reload > 0:
		time_reload -= 0.016
	
	if agent.follow:
		agent.velocity = agent.velocity.move_toward(new_velocity, 0.25)
		
		if time_reload <= 0:
			Transitioned.emit(self, "shoot")
			
	else:
		Transitioned.emit(self, "idle")
	


func _on_detect_player_body_exited(body):
	if body.name == "player":
		agent.follow = false
		Transitioned.emit(self, "idle")
