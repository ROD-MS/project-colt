extends StaticBody3D

@export var button: DoorButton = null

var open = false

func _ready() -> void:
	if button:
		button.click.connect(open_door)

func open_door():
		$animation.play("open")
		open = true

#func _on_detect_player_body_entered(body):
	#if body.name == "player":
		#canOpen = true
#
#func _on_detect_player_body_exited(body):
	#if body.name == "player":
		#canOpen = false
		#if open and !$animation.current_animation == "open":
			#$animation.play("close")
			#open = false
