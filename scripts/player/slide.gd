extends State

const SPEED: float = 3
var player: Player

@export var sprint_force_multiplier: float = 1.5
@export var raycast_slide_kick: RayCast3D = null

@onready var animation: AnimationPlayer = $"../../animation"
@onready var up_detector: RayCast3D = $"../../up_detector"


func enter():
	player = agent as Player
	animation.play("crouch")
	player.velocity.x = player.velocity.x * sprint_force_multiplier
	player.velocity.z = player.velocity.z * sprint_force_multiplier
	
	
func exit():
	animation.play("stand")
	
func update(delta: float):
	pass
	
func physics_update(delta: float):
	player.velocity.x = lerp(player.velocity.x, 0.0, 1 * delta)
	player.velocity.z = lerp(player.velocity.z, 0.0, 1 * delta)

	#print(player.velocity.length())
	
	if player.velocity.length() < 0.06 and Input.is_action_pressed("crouch"):
		player.velocity.x = 0.0
		player.velocity.z = 0.0
		Transitioned.emit(self, "crouch")
	elif !Input.is_action_pressed("crouch") and !up_detector.is_colliding():
		Transitioned.emit(self, "idle")
	
	player.kick.slide_shot(raycast_slide_kick)
	
	player.move_and_slide()
	
func input(event: InputEvent):
	if !Input.is_action_pressed("crouch") and !up_detector.is_colliding():
		print("AAAA")
		if !Input.get_vector("left", "right", "foward", "back"):
			Transitioned.emit(self, "idle")
		if Input.get_vector("left", "right", "foward", "back") and !Input.is_action_pressed("sprint"):
			Transitioned.emit(self, "run")
		if Input.get_vector("left", "right", "foward", "back") and Input.is_action_pressed("sprint"):
			Transitioned.emit(self, "walk")
		if Input.is_action_just_pressed("jump") and player.is_on_floor():
			Transitioned.emit(self, "jump")
		if Input.is_action_just_pressed("fire"):
				Transitioned.emit(self, "shoot")
	
	
