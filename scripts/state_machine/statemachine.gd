extends Node
class_name StateMachine

@export var initial_state: State = null
@export var agent: Node3D = null
@export var active: bool = false


var current_state: State = null
var states: Dictionary = {}

func _ready():
	for child in get_children():
		if child is State:
			states[child.name.to_lower()] = child
			states[child.name.to_lower()].agent = agent
			child.Transitioned.connect(on_child_transition)
			#print(get_parent().name + str(child))
			
	if initial_state:
		initial_state.enter()
		current_state = initial_state

func on_child_transition(state, new_state_name):
	if state != current_state:
		return
		
	var new_state = states.get(new_state_name.to_lower())
	if !new_state:
		return
	
	if current_state:
		current_state.exit()
	
	new_state.enter()
	
	current_state = new_state
		
func set_active(value: bool):
	active = value
	set_process(active)
	set_physics_process(active)
	set_process_unhandled_input(active)
		
func _process(delta):
	if active and current_state:
		current_state.update(delta)
		
func _physics_process(delta):
	if active and current_state:
		current_state.physics_update(delta)
		
func _unhandled_input(event):
	if active and current_state:
		current_state.input(event)
