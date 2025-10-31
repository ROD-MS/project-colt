extends Area3D

@export var next_level: String = ""

func _on_body_entered(body: Node3D) -> void:
	if body.name == "player":
		Score_control.add_score()
		get_tree().change_scene_to_file(next_level)
		
func _physics_process(delta: float) -> void:
	$MeshInstance3D.rotation.y += 0.05
