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
		agent.velocity.y = JUMP_FORCE
	
	var input_dir = Input.get_vector("left", "right", "foward", "back")
	var direction = (agent.transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		agent.velocity.x = direction.x * SPEED
		agent.velocity.z = direction.z * SPEED
	if direction and Input.is_action_pressed("sprint"):
		agent.velocity.x = direction.x * (SPEED * 2)
		agent.velocity.z = direction.z * (SPEED * 2)
			
	if agent.is_on_floor():
		if direction and Input.is_action_pressed("sprint"):
			Transitioned.emit(self, "run")
		if direction and !Input.is_action_pressed("sprint"):
			Transitioned.emit(self, "walk")
		if !direction:
			Transitioned.emit(self, "idle")
	#if Input.is_action_just_pressed("jump") and agent.is_on_floor():
		#agent.velocity.y = JUMP_FORCE
		
	# Add the gravity.
	#if not agent.is_on_floor():
		#agent.velocity += agent.get_gravity() * delta
		
	#if agent.velocity != Vector3.ZERO and !Input.is_action_pressed("sprint") and agent.is_on_floor():
		#Transitioned.emit(self, "walk")
	#elif agent.velocity != Vector3.ZERO and Input.is_action_pressed("sprint") and agent.is_on_floor():
		#Transitioned.emit(self, "run")
	
	#agent.move_and_slide()
	pass
	
func input(event: InputEvent):
	#if !Input.get_vector("left", "right", "foward", "back"):
		#Transitioned.emit(self, "idle")
	#if Input.get_vector("left", "right", "foward", "back") and !Input.is_action_pressed("sprint"):
		#Transitioned.emit(self, "walk")
	#if Input.get_vector("left", "right", "foward", "back") and Input.is_action_pressed("sprint"):
		#Transitioned.emit(self, "run")
	if Input.is_action_just_pressed("fire"):
			Transitioned.emit(self, "shoot")
