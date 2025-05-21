extends Node3D

class_name HealthComponent

@export var MAX_HEALTH: int = 10
var health: float

func _ready():
	health = MAX_HEALTH
	
func damage(attack: Attack):
	health -= attack.damage
	
	if health <= 0:
		get_parent().queue_free()
