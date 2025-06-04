extends State

func enter():
	print(str(name) + ": IDLE")
	agent.velocity.x = 0
	agent.velocity.z = 0
	
func _on_detect_player_body_entered(body):
	if body.name == "player":
		agent.follow = true
		Transitioned.emit(self, "followPlayer")
