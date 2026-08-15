extends State

func enter():
	if animation3D:
		animation3D.play("prep_attack")
		await animation3D.animation_finished
		Transitioned.emit(self, "shoot")
