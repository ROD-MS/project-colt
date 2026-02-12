extends StaticBody3D
class_name Breakable

@onready var broken: AudioStreamPlayer3D = $broken
@onready var collision_shape_3d: CollisionShape3D = $CollisionShape3D

func destroy():
	visible = false
	collision_layer = 8
	collision_mask = 8
	broken.play()
	await broken.finished
	queue_free()
	
