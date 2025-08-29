extends State

const SPEED: float = 6
var player: Player

func enter():
	player = agent as Player
	
func exit():
	pass
	
func update(delta: float):
	pass
	
func physics_update(delta: float):
	var input_dir = Input.get_vector("left", "right", "foward", "back")
	var direction = (player.transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		
		player.velocity.x = lerp(player.velocity.x, direction.x * SPEED, delta * 20)
		player.velocity.z = lerp(player.velocity.z, direction.z * SPEED, delta * 20)

	player.move_and_slide()
	
func input(event: InputEvent):
	if !Input.get_vector("left", "right", "foward", "back"):
		Transitioned.emit(self, "idle")
	if Input.get_vector("left", "right", "foward", "back") and !Input.is_action_pressed("sprint"):
		Transitioned.emit(self, "walk")
	if Input.is_action_just_pressed("jump") and player.is_on_floor():
		Transitioned.emit(self, "jump")
	if Input.is_action_pressed("crouch"):
		Transitioned.emit(self, "slide")
	if Input.is_action_just_pressed("fire"):
			Transitioned.emit(self, "shoot")
