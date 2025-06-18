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
	print (health)
	
	if health <= 0:
		print("MORTO")
		get_parent().queue_free()
