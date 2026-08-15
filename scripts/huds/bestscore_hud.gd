extends Control
class_name BestscoreHUD

var player: Player
var score: float
var highscore: float
var next_level: PackedScene



@onready var canvas_layer: CanvasLayer = $CanvasLayer
@onready var score_label: Label = $CanvasLayer/Panel/score
@onready var highscore_label: Label = $CanvasLayer/Panel/highscore

@export var menu_level: PackedScene = preload("res://scenes/menu.tscn")

func _ready() -> void:
	canvas_layer.visible = false

func change_visibility(active: bool):
	canvas_layer.visible = active
	if active == true:
		if player:
			var current_level = player.current_level
			SaveLoad._load()
			
			match current_level:
				"level_1":
					Score_control.highscore.set(current_level, SaveLoad.contents_to_save.highscore_level_1)
				"level_2":
					Score_control.highscore.set(current_level, SaveLoad.contents_to_save.highscore_level_2)
				"level_3":
					Score_control.highscore.set(current_level, SaveLoad.contents_to_save.highscore_level_3)
				
			
		score = Score_control.score
		print("score: " + str(Score_control.score))
		highscore = Score_control._new_highscore
		print("highscore: " + str(Score_control._new_highscore))
		
		score_label.text = "Score: " + str(score)
		highscore_label.text = "Highscore: " + str(highscore)
		
		Dialogic.end_timeline(true)
		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
		get_tree().paused = true


func _on_next_level_pressed() -> void:
	get_tree().paused = false
	get_tree().change_scene_to_packed(next_level)

func _on_menu_pressed() -> void:
	get_tree().change_scene_to_packed(menu_level)
