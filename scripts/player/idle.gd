extends State

@onready var head = $"../../head"
var player: Player
const SPEED: float = 3

func enter():
	player = agent as Player
	#agent.velocity.x = 0
	#agent.velocity.z = 0
	
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
	if player.is_on_floor():
		player.velocity.x = lerp(player.velocity.x, 0.0, delta * 20)
		player.velocity.z = lerp(player.velocity.z, 0.0, delta * 20)
	
	#print(player.velocity)
	
	pass
	
func input(event: InputEvent):
	if Input.get_vector("left", "right", "foward", "back") and !Input.is_action_pressed("sprint"):
		Transitioned.emit(self, "run")
	if Input.get_vector("left", "right", "foward", "back") and Input.is_action_pressed("sprint"):
		Transitioned.emit(self, "walk")
	if Input.is_action_just_pressed("jump") and player.is_on_floor():
		Transitioned.emit(self, "jump")
	if Input.is_action_pressed("crouch"):
		Transitioned.emit(self, "crouch")
	if Input.is_action_just_pressed("fire"):
			Transitioned.emit(self, "shoot")

#func trigger(new_state: StringName):
	#state_machine.trigger(new_state)

	
	
	
	
