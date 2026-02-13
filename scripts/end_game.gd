extends Control

func _ready():
	Dialogic.end_timeline()
	$ReferenceRect/Panel/score.text = str(Score_control.max_score)
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE

func _on_reiniciar_pressed():
	Score_control.reset_max_score()
	get_tree().change_scene_to_file("res://scenes/menu.tscn")

func _on_sair_pressed():
	get_tree().quit()
