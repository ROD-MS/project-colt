extends State

var enemy: Enemy

func enter():
	enemy = agent as Enemy
	agent.velocity.x = 0
	agent.velocity.z = 0
	
	if agent.follow:
		Transitioned.emit(self,"followPlayer")
	
func _on_detect_player_body_entered(body):
	if body.name == "player":
		agent.follow = true
		Transitioned.emit(self, "followPlayer")
