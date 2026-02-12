extends Node2D

@onready var video = $VideoStreamPlayer

func _ready() -> void:
	await video.finished
	get_tree().change_scene_to_file("res://scenes/menu.tscn")
