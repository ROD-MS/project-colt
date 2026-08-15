extends State

func enter():
	print("DEATH")
	var enemy = agent as Enemy
	print(enemy.collision_layer)
	print(enemy.collision_mask)
	enemy.set_collision_layer_value(2, true)
	enemy.set_collision_mask_value(2, true)
	enemy.set_collision_layer_value(1, false)
	enemy.set_collision_mask_value(1, false)
	print(enemy.collision_layer)
	print(enemy.collision_mask)
	if animation3D:
		animation3D.play("death")
		await animation3D.animation_finished
		enemy.queue_free()
	else:
		enemy.queue_free()
