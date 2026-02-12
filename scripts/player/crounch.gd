extends State

const SPEED: float = 1.5
var player: Player

var is_crouch: bool = false

@onready var animation: AnimationPlayer = $"../../animation"
@onready var up_detector: RayCast3D = $"../../up_detector"


func enter():
	is_crouch = true
	animation.play("crouch")
	player = agent as Player
	
func exit():
	is_crouch = false
	animation.play("stand")
	
func update(delta: float):
	pass
	
func physics_update(delta: float):

	var input_dir = Input.get_vector("left", "right", "foward", "back")
	var direction = (player.transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction and is_crouch:
		
		player.velocity.x = lerp(player.velocity.x, direction.x * SPEED, delta * 20)
		player.velocity.z = lerp(player.velocity.z, direction.z * SPEED, delta * 20)
	
	else:
		player.velocity.x = lerp(player.velocity.x, 0.0, delta * 20)
		player.velocity.z = lerp(player.velocity.z, 0.0, delta * 20)
		

	player.move_and_slide()
	
func input(event: InputEvent):
	if !Input.is_action_pressed("crouch") and !up_detector.is_colliding():
		is_crouch = false
		if !Input.get_vector("left", "right", "foward", "back"):
			Transitioned.emit(self, "idle")
		if Input.get_vector("left", "right", "foward", "back") and player.running:
			Transitioned.emit(self, "run")
		if Input.get_vector("left", "right", "foward", "back") and !player.running :
			Transitioned.emit(self, "walk")
		if Input.is_action_just_pressed("jump") and player.is_on_floor():
			Transitioned.emit(self, "jump")
		if Input.is_action_just_pressed("fire"):
				Transitioned.emit(self, "shoot")
