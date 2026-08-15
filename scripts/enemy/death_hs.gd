extends State

func enter():
	print("DEATH HS")
	var enemy = agent as Enemy
	if animation3D:
		animation3D.play("death_hs")
		await animation3D.animation_finished
		enemy.queue_free()
	else:
		enemy.queue_free()
