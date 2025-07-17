extends Area3D

var entered = false
@export var health_value: int = 10


func _on_body_entered(body: Node3D) -> void:
	if body.name == "player" and entered == false:
		var health_component: HealthComponent = null
		for child in body.get_children():
			if child is HealthComponent:
				health_component = child
				break
				
		if !health_component:
			return
		
		health_component.heal(health_value)
		
		$som_bebendo.play()
		
		hide()
		entered = true
		
		await $som_bebendo.finished
		
		queue_free()
