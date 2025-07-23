extends Node3D

class_name HealthComponent

@export var MAX_HEALTH: int = 10
@export var health_bar: ProgressBar
var health: float

func _ready():
	health = MAX_HEALTH
	if health_bar:
		health_bar.max_value = MAX_HEALTH
		health_bar.value = health
	
func damage(attack: Attack):
	health -= attack.damage
	if health_bar and health >= 0:
		health_bar.value = health
		print("VIDA RESTANTE: " + str(health))
	if get_parent().name == "player":
		$"../HUD/hit".show()
		await get_tree().create_timer(0.1).timeout
		$"../HUD/hit".hide()
	
	if health <= 0:
		if get_parent().name == "player":
			get_tree().reload_current_scene()
		print("MORREU")
		get_parent().queue_free()

func heal(heal_value: int):
	if health < MAX_HEALTH:
		health += heal_value
	print("curou " + str(heal_value) + " pontos de vida")
	if health_bar and health >= 0:
		health_bar.value = health
	
#FUNÇÃO DE CURA
#func heal(healing: Cure):
	#health += healing
