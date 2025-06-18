extends StaticBody3D

var canOpen = false
var open = false
var animation_finished = false


func _process(delta):
	var interaction = Input.is_action_just_pressed("interaction")
	if canOpen and !open and interaction:
		$animation.play("open")
		open = true

func _on_detect_player_body_entered(body):
	if body.name == "player":
		canOpen = true

func _on_detect_player_body_exited(body):
	if body.name == "player":
		canOpen = false
		if open and !$animation.current_animation == "open":
			$animation.play("close")
			open = false
