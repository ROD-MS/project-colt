extends State

func enter():
	print(str(name) + ": FOLLOW PLAYER")

func update(delta: float):
	var next_location = agent.nav.get_next_path_position()
	var current_location = agent.global_transform.origin
	var new_velocity = (next_location - current_location).normalized() * agent.SPEED
	agent.look_at(Vector3(agent.nav.target_position), Vector3.UP)
	
	if agent.follow:
		agent.velocity = agent.velocity.move_toward(new_velocity, 0.25)
		agent.shot()
	else:
		Transitioned.emit(self, "idle")
	


func _on_detect_player_body_exited(body):
	if body.name == "player":
		agent.follow = false
		Transitioned.emit(self, "idle")
