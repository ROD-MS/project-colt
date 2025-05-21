extends AnimatedSprite3D

var camera = null

func set_camera(cam):
	camera = cam
	#print(camera)

func _process(_delta):
	if camera == null:
		return
	
	var player_fwd = -camera.global_transform.basis.z
	var fwd = global_transform.basis.z
	var left = global_transform.basis.x
	
	# dot products (dar uma olhada no que são)
	var l_dot = left.dot(player_fwd)
	var f_dot = fwd.dot(player_fwd)
	
	
	# encarando o jogador
	flip_h = false
	
	if f_dot < -0.85:
		play("front")# sprite frontal
	elif f_dot > 0.85:
		play("back") # sprite traseiro
	else:
		flip_h = l_dot > 0 #vira pro lado certo
		if abs(f_dot) < 0.3:
			play("left") # sprite perpendicular pra esquerda
		elif f_dot < 0:
			play("front_left") # sprite frente esquerda
		else:
			play("back_left") # sprite traiseira esquerda
