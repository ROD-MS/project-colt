extends Node

@export var raycast: RayCast3D
@export var rope: Node3D

@export var player: Player
@export var state_machine: StateMachine

@export_group("wall settings")
@export var wall_rest_length := 0.0
@export var wall_stiffness := 15.0 # FORCE
@export var wall_damping := 1.0 # FORCE

@export_group("ceiling settings")
@export var ceiling_rest_length := 1.0
@export var ceiling_stiffness := 15.0
@export var ceiling_damping := 1.0

var rest_length := 1.0
var stiffness := 15.0
var damping := 1.0

var launched := false
var target: StaticBody3D = null
var target_point: Vector3

func _physics_process(delta: float) -> void:
	if Input.is_action_just_pressed("shot_hook"):
		launch()
	if Input.is_action_just_released("shot_hook"):
		retract()
		
	if launched:
		handle_grapple(delta)
		
	update_rope()

func launch():
	if raycast.is_colliding():
		
		if raycast.get_collider() is StaticBody3D:
			target = raycast.get_collider()
		
		print(target)
		
		if target.is_in_group("grappling_hook_block"):
			target_point = raycast.get_collision_point()
			if target.is_in_group("wall_gh"):
				rest_length = wall_rest_length
				stiffness = wall_stiffness
				damping = wall_damping
				state_machine.set_active(false)
				
			elif target.is_in_group("ceiling_gh"):
				rest_length = ceiling_rest_length
				stiffness = ceiling_stiffness
				damping = ceiling_damping
			
			launched = true
	
func retract():
	launched = false
	
func handle_grapple(delta: float):
	var target_dir := player.global_position.direction_to(target_point)
	var target_dist := player.global_position.distance_to(target_point)
	
	var displacement := target_dist - rest_length
	
	var force := Vector3.ZERO
	
	if displacement > 0:
		var spring_force_magnitude := stiffness * displacement
		var spring_force := target_dir * spring_force_magnitude
		
		var vel_dot := player.velocity.dot(target_dir)
		var damping = -damping * vel_dot * target_dir
		
		force = spring_force + damping
	
	player.velocity += force * delta
		
func update_rope():
	if !launched:
		state_machine.set_active(true)
		rope.visible = false
		return
		
	rope.visible = true
	
	var dist = player.global_position.distance_to(target_point)
	
	rope.look_at(target_point)
	rope.scale = Vector3(1, 1, dist)
		
		
		
		
		
		
		
	
