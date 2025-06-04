extends Node3D

class_name ShotComponent

const SHOT = preload("res://scenes/shot.tscn")
@export var time_reload_sec: float
@export var aim: RayCast3D
var time_reload: float
var shotted: float = false

func _ready():
	time_reload = time_reload_sec

func shot():
	if time_reload <= 0:
		var shot = SHOT.instantiate()
		shot.position = aim.global_position
		shot.rotation = aim.global_rotation
		get_parent().get_parent().add_child(shot)
		shotted = true
		
func _process(delta):
	if time_reload > 0:
		time_reload -= 0.016
	elif shotted:
		time_reload = time_reload_sec
		shotted = false
