extends CharacterBody3D
class_name Player

const SPEED = 2
const JUMP_FORCE = 3
const SHOT = null

#@export var state_machine: StateMachine
@export var mouse_sensibility: float = 0.2

@onready var head = $head
@onready var camera = $head/Camera3D

@onready var score: Label = $HUD/ReferenceRect/scoreboard/score
@onready var combo: Label = $HUD/ReferenceRect/scoreboard/combo
@onready var time_bar: ProgressBar = $HUD/ReferenceRect/scoreboard/time_bar
@onready var highscore: Label = $HUD/ReferenceRect/scoreboard/highscore
@onready var ammo_counter: Label = $HUD/ReferenceRect/ammo_counter



var camera_sense = 0.003
var sprint = 2
var a: float = 0

var current_level: String = ""

func _physics_process(delta):
	#moviment(delta)
	if !is_on_floor():
		velocity += get_gravity() * delta
	
	#a += 0.01
	#print("COSSENO: " + str(cos(a)))
	#print("VALOR: " + str(a))
	
	# DIMINUIR TIMER DE COMBO
	if time_bar.value > 0:
		time_bar.value -= 1
	else:
		Score_control.reset_combo()
		combo.text = "COMBO: "
	
	
	move_and_slide()

func _ready():
	if get_owner().get_owner():
		current_level = get_owner().get_owner().name
	
	Score_control.enemyDead.connect(change_scoreboard)
	Score_control.reset_combo()
	Score_control.reset_score()
	Score_control.set_level(current_level)
	
	print(current_level)
	
	$head/RayCast3D.add_exception(self)
	var this_level = get_parent()
	if this_level.name == "main":
		$HUD/ReferenceRect/Panel.visible = true
	else:
		$HUD/ReferenceRect/Panel.visible = false
	
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	
	#SETANDO A CAMERA DOS INIMIGOS E ITENS
	get_tree().call_group("enemy_item", "set_camera", camera)
	
	print(get_owner().get_owner())
	
func _input(event):
	if event.is_action_pressed("free_mouse"):
		if Input.mouse_mode == Input.MOUSE_MODE_CAPTURED:
			Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
		elif Input.mouse_mode == Input.MOUSE_MODE_VISIBLE:
			Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
			
	if event is InputEventMouseMotion:
		rotate_y(deg_to_rad(-event.relative.x * mouse_sensibility)) 
		head.rotation.x -= event.relative.y * camera_sense
		head.rotation.x = clamp(head.rotation.x, deg_to_rad(-60), deg_to_rad(60))
		#rotate_y(deg_to_rad(-event.relative.x * mouse_sensibility))
		#print(rotation)
		#print(head.rotation)
	
func _on_killzone_body_entered(body):
	if body.name == "player":
		get_tree().reload_current_scene()


func _on_show_tutorial_body_exited(body):
	if body.name == "player":
		$HUD/ReferenceRect/Panel.visible = false
		
func change_scoreboard(new_score: float, new_combo: float, new_highscore: float):
	score.text = "SCORE: " + str(new_score)
	combo.text = "COMBO: " + str(new_combo)
	highscore.text = "HIGHSCORE: " + str(new_highscore)
	time_bar.value = time_bar.max_value


func _on_save_pressed() -> void:
	match current_level:
		"level_1":
			SaveLoad.contents_to_save.highscore_level_1 = Score_control.highscore.get(current_level)
		"level_2":
			SaveLoad.contents_to_save.highscore_level_2 = Score_control.highscore.get(current_level)
		"level_3":
			SaveLoad.contents_to_save.highscore_level_3 = Score_control.highscore.get(current_level)
			
	SaveLoad._save()

func _on_load_pressed() -> void:
	SaveLoad._load()
	
	match current_level:
		"level_1":
			Score_control.highscore.set(current_level, SaveLoad.contents_to_save.highscore_level_1)
		"level_2":
			Score_control.highscore.set(current_level, SaveLoad.contents_to_save.highscore_level_2)
		"level_3":
			Score_control.highscore.set(current_level, SaveLoad.contents_to_save.highscore_level_3)
	
	highscore.text = "HIGHSCORE: " +str(Score_control.highscore.get(current_level))


func _on_ammo_box_detector_area_entered(area: Area3D) -> void:
	if area.get_parent().is_in_group("shotgun_ammo"):
		$inventory_component/shotgun.add_ammo(8)
		$"Sounds Effects/pick_audio".play()
		area.get_parent().queue_free()
