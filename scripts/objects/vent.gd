extends StaticBody3D
class_name Vent

@onready var breaking_audio: AudioStreamPlayer3D = $breaking
@onready var collision: CollisionShape3D = $CSGBakedCollisionShape3D

func _break():
	hide()
	collision.disabled = true
	
	breaking_audio.play()
	await breaking_audio.finished
	queue_free()
	
