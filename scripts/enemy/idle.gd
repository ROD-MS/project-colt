extends State

var enemy: Enemy
var move_timer: Timer = null
@onready var raycast: RayCast3D = $"../../RayCast3D"
@onready var detect_player: Area3D = $"../../detect_player"



func enter():
	enemy = agent as Enemy
	move_timer = enemy.move_timer
	
	agent.velocity.x = 0
	agent.velocity.z = 0
	detect_player.process_mode = Node.PROCESS_MODE_DISABLED
	
	if enemy.follow:
		Transitioned.emit(self,"followPlayer")
	
func _process(delta: float) -> void:
	#if !enemy.is_in_group("enemy_stopped"):
		## IDLE MOVE - GIVE MORE "LIFE" TO GAME
		#if move_timer and move_timer.is_stopped():
			#randomize()
			#var _direction = randi_range(0, 359)
			##var next_location = enemy.nav.get_next_path_position()
			##var current_location = enemy.global_transform.origin
			#var new_velocity = enemy.SPEED * _direction
			#enemy.rotate_y(_direction)
			#agent.velocity = agent.velocity.move_toward(new_velocity, 0.25)
			#await get_tree().create_timer(1).timeout
			#move_timer.start(3)

		
	if raycast.is_colliding() and raycast.get_collider() and raycast.get_collider().name == "player":
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
		
		
		
