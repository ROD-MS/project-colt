extends Node3D

class_name HealthComponent


@export var MAX_HEALTH: int = 10
@export var health_bar: ProgressBar
@export var life_bar: AnimatedSprite2D

var health: float

func _ready():
	health = MAX_HEALTH
	if health_bar:
		health_bar.max_value = MAX_HEALTH
		health_bar.value = health
	
func damage(attack: Attack) -> float:
	health -= attack.damage
	if life_bar and health >= 0:
		update_life_bar_damage()
		#print(health)
	#if health_bar and health >= 0:
		#health_bar.value = health
		#print("VIDA RESTANTE: " + str(health))
	if get_parent().name == "player":
		var player = get_parent() as Player
		$"../HUD/hit".show()
		await get_tree().create_timer(0.1).timeout
		Score_control.reset_combo()
		player.combo.text = "COMBO: "
		$"../HUD/hit".hide()
		
	if get_parent().is_in_group("enemy"):
		$"../sounds/dano_enemy".play()
		
	
	if health <= 0:
		if get_parent().name == "player":
			get_tree().reload_current_scene()
		#if get_parent().is_in_group("enemy"):
			#print("HEALTH ENEMY: " +str(health))
			
		#print("MORREU")
		get_parent().queue_free()
		
	return health

func heal(heal_value: int):
	if health < MAX_HEALTH:
		health += heal_value
	#print("curou " + str(heal_value) + " pontos de vida")
	if life_bar and health >= 0:
		update_life_bar_heal()
		
func update_life_bar_damage():
	# FEITO AS PRESSAS!!! SE EU ACHAR UMA MANREIRA MELHOR DE FAZER ISSO, COM CERTEZA VOU FAZER
	if health == 90:
		#print("AAAAAA")
		life_bar.play("100_hit")
		await life_bar.animation_finished
		life_bar.play("90")
		return
	if health == 80:
		#print("AAAAAA")
		life_bar.play("90_hit")
		await life_bar.animation_finished
		life_bar.play("80")
		return
	if health == 70:
		#print("AAAAAA")
		life_bar.play("80_hit")
		await life_bar.animation_finished
		life_bar.play("70")
		return
	if health == 60:
		#print("AAAAAA")
		life_bar.play("70_hit")
		await life_bar.animation_finished
		life_bar.play("60")
		return
	if health == 50:
		#print("AAAAAA")
		life_bar.play("60_hit")
		await life_bar.animation_finished
		life_bar.play("50")
		return
	if health == 40:
		#print("AAAAAA")
		life_bar.play("50_hit")
		await life_bar.animation_finished
		life_bar.play("40")
		return
	if health == 30:
		#print("AAAAAA")
		life_bar.play("40_hit")
		await life_bar.animation_finished
		life_bar.play("30")
		return
	if health == 20:
		#print(health)
		life_bar.play("30_hit")
		await life_bar.animation_finished
		life_bar.play("20")
		return
	if health == 10:
		#print(health)
		life_bar.play("20_hit")
		await life_bar.animation_finished
		life_bar.play("10")
		return
			
func update_life_bar_heal():
	# FEITO AS PRESSAS!!! SE EU ACHAR UMA MANREIRA MELHOR DE FAZER ISSO, COM CERTEZA VOU FAZER
	# FEITO AS PRESSAS!!! SE EU ACHAR UMA MANREIRA MELHOR DE FAZER ISSO, COM CERTEZA VOU FAZER
	if health == 90:

		life_bar.play("90")
		return
	if health == 80:

		life_bar.play("80")
		return
	if health == 70:

		life_bar.play("70")
		return
	if health == 60:

		life_bar.play("60")
		return
	if health == 50:
	
		life_bar.play("50")
		return
	if health == 40:

		life_bar.play("40")
		return
	if health == 30:

		life_bar.play("30")
		return
	if health == 20:
	
		life_bar.play("20")
		return
	if health == 100:

		life_bar.play("100")
		return
	
#FUNÇÃO DE CURA
#func heal(healing: Cure):
	#health += healing
