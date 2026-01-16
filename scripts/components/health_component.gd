extends Node3D

class_name HealthComponent

@onready var knockback_timer: Timer = $knockback_timer
@export var MAX_HEALTH: int = 10
@export var health_bar: ProgressBar
@export var life_bar: AnimatedSprite2D
const ENEMY_ITEM = preload("res://scenes/objects/item_test_enemy.tscn")

var health: float
var knockback: Vector3

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
		Score_control.down_combo()
		if Score_control.combo <= 1:
			player.combo.text = "COMBO: "
		else:
			player.combo.text = "COMBO: " + str(Score_control.combo)
		$"../HUD/hit".hide()
		
	if get_parent().is_in_group("enemy"):
		var enemy = get_parent() as Enemy
		print(enemy.detect_player)
		enemy.detect_player.process_mode = Node.PROCESS_MODE_INHERIT
		enemy.follow = true
		
		var knockback_direction = -(enemy.player.global_position - enemy.global_position).normalized()
		print("ridectoin:" + str(knockback_direction))
		print(Vector3(1, 1, 1))
		knockback = knockback_direction * attack.knockback_force
	
		knockback_timer.start(1)
	
		if enemy.is_in_group("weak_enemy"):
			enemy.velocity = knockback
		
	
		
		
	if get_parent().is_in_group("enemy"):
		randomize()
		var random_sound: int = randi_range(1, 2)
		if random_sound == 1:
				$"../sounds/dano_enemy1".play()
		if random_sound == 2:
				$"../sounds/dano_enemy2".play()
	
	if health <= 0:
		if get_parent() and get_parent().name == "player":
			if get_tree():
				get_tree().reload_current_scene()
		#if get_parent().is_in_group("enemy"):
			#print("HEALTH ENEMY: " +str(health))
			
		#print("MORREU")
		
		if get_parent() and get_parent() is Enemy and attack.damage > 999:
			var enemy = get_parent() as Enemy
			var enemy_item = ENEMY_ITEM.instantiate()
			enemy_item.global_position = enemy.global_position
			
			#print("enemy yes: " + str(enemy_item.global_position))
			#print("enemy yes: " + str(get_owner()))
			
			get_owner().get_parent().add_child(enemy_item)
			
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
