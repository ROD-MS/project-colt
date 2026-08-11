extends Control

@export var level: PackedScene

func _ready() -> void:
	SaveLoad._load()

func _on_button_pressed() -> void:
	Dialogic.VAR.set_variable("tutorialClear", false)
	Dialogic.VAR.set_variable("tutorial", 0)
	get_tree().change_scene_to_packed(level)
