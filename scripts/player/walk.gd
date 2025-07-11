extends State

const SPEED = 2

func enter():
	pass
	
func exit():
	pass
	
func update(delta: float):
	pass
	
func physics_update(delta: float):
	# Add the gravity.
	#if not agent.is_on_floor():
		#agent.velocity += agent.get_gravity() * delta

	# Handle jump.
	#if Input.is_action_just_pressed("jump") and agent.is_on_floor():
		#Transitioned.emit(self, "jump")
		#
	#if Input.is_action_pressed("sprint"):
		#Transitioned.emit(self, "run")

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	#("left", "right", "foward", "backward")
	var input_dir = Input.get_vector("left", "right", "foward", "back")
	var direction = ($"../../head".transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		agent.velocity.x = direction.x * SPEED
		agent.velocity.z = direction.z * SPEED
	#else:
		#Transitioned.emit(self, "idle")
		

	agent.move_and_slide()
	
func input(event: InputEvent):
	if !Input.get_vector("left", "right", "foward", "back"):
		Transitioned.emit(self, "idle")
	if Input.get_vector("left", "right", "foward", "back") and Input.is_action_pressed("sprint"):
		Transitioned.emit(self, "run")
	if Input.is_action_just_pressed("jump") and agent.is_on_floor():
		Transitioned.emit(self, "jump")
	if Input.is_action_just_pressed("fire"):
			Transitioned.emit(self, "shoot")
