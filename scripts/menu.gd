extends Control

func _ready() -> void:
	SaveLoad._load()

func _on_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/levels/level_1.tscn")
