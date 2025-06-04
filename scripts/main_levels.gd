extends Node3D

func _process(delta):
	if $player:
		get_tree().call_group("enemy", "target_position", $player.global_transform.origin)
	else:
		get_tree().reload_current_scene()
