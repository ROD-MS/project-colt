extends State

var enemy: Enemy
@onready var raycast: RayCast3D = $"../../RayCast3D"
@onready var detect_player: Area3D = $"../../detect_player"



func enter():
	enemy = agent as Enemy
	
	agent.velocity.x = 0
	agent.velocity.z = 0
	detect_player.process_mode = Node.PROCESS_MODE_DISABLED
	
	if agent.follow:
		Transitioned.emit(self,"followPlayer")
	
func _process(delta: float) -> void:
	if self and raycast.is_colliding() and raycast.get_collider().name == "player":
		agent.follow = true
		detect_player.process_mode = Node.PROCESS_MODE_INHERIT
		Transitioned.emit(self, "followPlayer")
		
	if enemy.follow:
		Transitioned.emit(self, "followPlayer")

func _on_detect_player_body_entered(body):
	if body is Enemy:
		var _body := body as Enemy
		_body.follow = true
		
		
		
