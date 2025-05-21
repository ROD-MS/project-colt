extends State

@onready var head = $"../../head"

func enter():
	print("IDLE")
	agent.velocity.x = 0
	agent.velocity.z = 0
	
func exit():
	pass
	
func update(delta: float):
	pass
	
func physics_update(delta: float):
	# Add the gravity.
	#if not agent.is_on_floor():
		#agent.velocity += agent.get_gravity() * delta
	#if agent.velocity != Vector3.ZERO and !Input.is_action_pressed("sprint"):
		#Transitioned.emit(self, "walk")
	#elif agent.velocity != Vector3.ZERO and Input.is_action_pressed("sprint"):
		#Transitioned.emit(self, "run")
	pass
	
func input(event: InputEvent):
	if Input.get_vector("left", "right", "foward", "back") and !Input.is_action_pressed("sprint"):
		Transitioned.emit(self, "walk")
	if Input.get_vector("left", "right", "foward", "back") and Input.is_action_pressed("sprint"):
		Transitioned.emit(self, "run")
	if Input.is_action_just_pressed("jump") and agent.is_on_floor():
		Transitioned.emit(self, "jump")
	if Input.is_action_just_pressed("fire"):
			Transitioned.emit(self, "shoot")

#func trigger(new_state: StringName):
	#state_machine.trigger(new_state)

	
	
	
	
