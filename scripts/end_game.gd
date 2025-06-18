extends Control

func _ready():
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE

func _on_reiniciar_pressed():
	get_tree().change_scene_to_file("res://scenes/main.tscn")

func _on_sair_pressed():
	get_tree().quit()
