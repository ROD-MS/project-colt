extends Control
class_name DeathHud

@export var name_level: String
@export var player: Player

@onready var score_label: Label = $CanvasLayer/Panel/score
@onready var highscore_label: Label = $CanvasLayer/Panel/highscore
@onready var canvas_layer: CanvasLayer = $CanvasLayer

var visibility: bool = false

var score: float
var highscore: float

func _ready() -> void:
	canvas_layer.visible = false
	highscore = Score_control.highscore.get(name_level)
	SaveLoad._load()
	print(Score_control.highscore)

func change_visibility(active: bool):
	canvas_layer.visible = active
	if active == true:
		#var current_level = Score_control.get_level()
		#SaveLoad._load()
		#
		#match current_level:
			#"level_1":
				#Score_control.highscore.set(current_level, SaveLoad.contents_to_save.highscore_level_1)
			#"level_2":
				#Score_control.highscore.set(current_level, SaveLoad.contents_to_save.highscore_level_2)
			#"level_3":
				#Score_control.highscore.set(current_level, SaveLoad.contents_to_save.highscore_level_3)
			
		
		score = Score_control.score
		print("score: " + str(Score_control.score))
		highscore = Score_control.get_highscore()
		print("highscore: " + str(Score_control.get_highscore()))
		
		score_label.text = "Score: " + str(score)
		highscore_label.text = "Highscore: " + str(highscore)

func _on_restart_pressed() -> void:
	print("aquiaaaaa")
	get_tree().paused = false
	print("aqui")
	get_tree().reload_current_scene()

func _on_menu_pressed() -> void:
	get_tree().paused = false
	get_tree().change_scene_to_file("res://scenes/menu.tscn")
