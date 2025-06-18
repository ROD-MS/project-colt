extends Node3D

func _process(delta):
	if $player:
		get_tree().call_group("enemy", "target_position", $player.global_transform.origin)
	else:
		get_tree().reload_current_scene()


func _on_final_body_entered(body):
	if body.name == "player":
		get_tree().change_scene_to_file("res://scenes/end_game.tscn")
