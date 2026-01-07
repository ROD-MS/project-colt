extends State

#var time_reload := 0.0
var enemy: Enemy
var move_timer: Timer = null
var ranged_following := false
@onready var raycast: RayCast3D = $"../../RayCast3D"
@onready var detect_player: Area3D = $"../../detect_player"

func enter():
	enemy = agent as Enemy
	move_timer = enemy.move_timer
	#time_reload = enemy.time_reload_sec
	
	enemy.velocity.x = 0
	enemy.velocity.z = 0
	detect_player.process_mode = Node.PROCESS_MODE_DISABLED
	
	if enemy.follow:
		if !enemy.is_in_group("enemy_range"):
			Transitioned.emit(self, "followPlayer")
			
		if enemy.is_in_group("enemy_range") and !raycast.get_collider() or !raycast.get_collider() is Player:
			Transitioned.emit(self, "followPlayer")
	
func _process(delta: float) -> void:		
	if raycast.is_colliding() and raycast.get_collider() and raycast.get_collider() is Player:
		agent.follow = true
		detect_player.process_mode = Node.PROCESS_MODE_INHERIT
		Transitioned.emit(self, "followPlayer")
	else:
		detect_player.process_mode = Node.PROCESS_MODE_DISABLED
		
	if enemy.follow:
		Transitioned.emit(self, "followPlayer")


func _on_detect_player_body_entered(body):
	if !enemy.is_in_group("enemy_stopped"):
		if body is Enemy:
			var other_enemy := body as Enemy
			other_enemy.follow = true
		
		
		
