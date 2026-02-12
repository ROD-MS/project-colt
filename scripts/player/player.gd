extends CharacterBody3D
class_name Player

const SPEED = 2
const JUMP_FORCE = 3
const SHOT = null

@export var level: Level

@export var death_hud: DeathHud

@export var state_machine: StateMachine
@export var mouse_sensibility: float = 0.2

@onready var oh_yeah: AudioStreamPlayer = $oh_yeah_audio
@onready var alert_enemy: Area3D = $alert_enemy
@onready var head: Node3D = $head
@onready var camera: Camera3D = $head/Camera3D
@onready var inventory_component: Inventory = $inventory_component
@onready var kick: Kick = $head/kick


@onready var score: Label = $HUD/ReferenceRect/scoreboard/score
@onready var combo: Label = $HUD/ReferenceRect/scoreboard/combo
@onready var time_bar: ProgressBar = $HUD/ReferenceRect/scoreboard/time_bar
@onready var highscore: Label = $HUD/ReferenceRect/scoreboard/highscore
@onready var ammo_counter: Label = $HUD/ReferenceRect/ammo_counter

var camera_sense = 0.003
var sprint = 2
var running := true
var a: float = 0

var current_level: String = ""
var tentativas: int = 0
var timer: int = 0

var shotted: bool = false

var death: bool = false

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("sprint"):
		if running:
			running = false
		else:
			running = true
	
	if shotted:
		alert_enemy.process_mode = Node.PROCESS_MODE_INHERIT
		shotted = false
	else:
		alert_enemy.process_mode = Node.PROCESS_MODE_DISABLED
		

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
		Score_control.down_combo()
		
		if Score_control.combo <= 1:
			combo.text = "COMBO: "
		else:
			combo.text = "COMBO: " + str(Score_control.combo)
			
		if Score_control.combo > 0:
			time_bar.value = time_bar.max_value
		
	
	move_and_slide()

func _ready():
	if get_owner().get_owner():
		current_level = get_owner().get_owner().name
	
	Score_control.enemyDead.connect(change_scoreboard)
	Score_control.combo = 0
	Score_control.reset_score()
	Score_control.set_level(current_level)
	SaveLoad._load()
	
	match current_level:
		"level_1":
			tentativas = Score_control.tentativas_level1
			$HUD/aviso_shotgun.hide()
		"level_2":
			tentativas = Score_control.tentativas_level2
			$HUD/aviso_shotgun.show()
	
	
	$head/RayCast3D.add_exception(self)
	var this_level = get_parent()
	if this_level.name == "main":
		$HUD/ReferenceRect/Panel.visible = true
	else:
		$HUD/ReferenceRect/Panel.visible = false
	
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	
	#SETANDO A CAMERA DOS INIMIGOS E ITENS
	get_tree().call_group("enemy_item", "set_camera", camera)
	
	alert_enemy.process_mode = Node.PROCESS_MODE_DISABLED
	
func _input(event):
	if event.is_action_pressed("free_mouse"):
		if Input.mouse_mode == Input.MOUSE_MODE_CAPTURED:
			Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
		elif Input.mouse_mode == Input.MOUSE_MODE_VISIBLE:
			Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
			
	if event.is_action_pressed("peido"):
		oh_yeah.play()
		
			
	if event is InputEventMouseMotion:
		rotate_y(deg_to_rad(-event.relative.x * Config.mouse_sensibility)) 
		head.rotation.x -= event.relative.y * Config.mouse_sensibility/50
		head.rotation.x = clamp(head.rotation.x, deg_to_rad(-60), deg_to_rad(60))
		#rotate_y(deg_to_rad(-event.relative.x * mouse_sensibility))
		#print(rotation)
		#print(head.rotation)
		
	if event.is_action_pressed("change_to_shotgun"):
		$HUD/aviso_shotgun.hide()
	
func _on_killzone_body_entered(body):
	if body is Player:
		state_machine.set_active(false)
		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
		death_hud.change_visibility(true)


func _on_show_tutorial_body_exited(body):
	if body.name == "player":
		$HUD/ReferenceRect/Panel.visible = false
		
func change_scoreboard(new_score: float, new_combo: float, new_highscore: float):
	score.text = "SCORE: " + str(new_score)
	if Score_control.combo > 1:
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
		if inventory_component.current_weapon.name == "shotgun":
			$inventory_component/shotgun.add_ammo(8)
			$"Sounds Effects/pick_audio".play()
			area.get_parent().queue_free()


func _exit_tree() -> void:
	#match current_level:
		#"level_1":
			#Score_control.tentativas_level1 += 1
		#"level_2":
			#Score_control.tentativas_level2 += 1
			
	get_tree().reload_current_scene()


func _on_alert_enemy_body_entered(body: Node3D) -> void:
	if body is Enemy:
		var _body := body as Enemy
		_body.follow = true
