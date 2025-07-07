extends Area3D

var qualquercoisaassim = false

func _on_body_entered(body: Node3D) -> void:
	if body.name == "player" and qualquercoisaassim == false:
		print("Se curou")
		$som_bebendo.play()
		
		hide()
		qualquercoisaassim = true
		
		await $som_bebendo.finished
			
		queue_free()
