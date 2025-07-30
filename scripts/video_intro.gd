extends Node2D

@onready var video = $VideoStreamPlayer

func _ready() -> void:
	await video.finished
	print("Me ve dois alfajor por favor muchacho")
	get_tree().change_scene_to_file("res://scenes/levels/level_1.tscn")
