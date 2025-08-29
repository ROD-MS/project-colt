extends State

const JUMP_FORCE = 3.5
const SPEED = 3
var player: Player

func enter():
	player = agent as Player
	
func exit():
	pass
	
func update(delta: float):
	pass
	
func physics_update(delta: float):
	if Input.is_action_just_pressed("jump"):
		player.velocity.y = JUMP_FORCE
	
	var input_dir = Input.get_vector("left", "right", "foward", "back")
	var direction = (player.transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		player.velocity.x = direction.x * SPEED
		player.velocity.z = direction.z * SPEED
	if direction and Input.is_action_pressed("sprint"):
		player.velocity.x = direction.x * (SPEED * 2)
		player.velocity.z = direction.z * (SPEED * 2)
			
	if player.is_on_floor():
		if direction and Input.is_action_pressed("sprint"):
			Transitioned.emit(self, "run")
		if direction and !Input.is_action_pressed("sprint"):
			Transitioned.emit(self, "walk")
		if !direction:
			Transitioned.emit(self, "idle")
	pass
	
func input(event: InputEvent):

	if Input.is_action_just_pressed("fire"):
			Transitioned.emit(self, "shoot")
