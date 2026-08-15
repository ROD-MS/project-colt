extends State

func enter():
	print("DEATH")
	var enemy = agent as Enemy
	if animation3D:
		animation3D.play("death")
		await animation3D.animation_finished
		enemy.queue_free()
	else:
		enemy.queue_free()
