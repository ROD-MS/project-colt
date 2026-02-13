extends StaticBody3D
class_name Breakable

@onready var broken: AudioStreamPlayer3D = $broken
@onready var collision_shape_3d: CollisionShape3D = $CollisionShape3D
@onready var particles: CPUParticles3D = $CPUParticles3D
@onready var mesh: MeshInstance3D = $MeshInstance3D
@onready var destroy_others: Area3D = $destroy_others


func _ready() -> void:
	destroy_others.monitoring = false

func destroy():
	mesh.hide()
	collision_layer = 8
	collision_mask = 8
	particles.emitting = true
	destroy_others.monitoring = true
	broken.play()
	await broken.finished
	queue_free()
	


func _on_destroy_others_body_entered(body: Node3D) -> void:
	if body is Breakable:
		var _wood: Breakable = body as Breakable
		_wood.destroy()
