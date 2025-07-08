extends Area3D

var entered = false
@export var health_value: int = 10

func _on_body_entered(body: Node3D) -> void:
	if body.name == "player" and entered == false:
		var health_component = body.get_child(2)
		health_component.heal(health_value)
		
		$som_bebendo.play()
		
		hide()
		entered = true
		
		await $som_bebendo.finished
		
		queue_free()
