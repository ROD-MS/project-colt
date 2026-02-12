extends RigidBody3D
class_name EnemyItem

var launched: bool = false
@onready var attack_area: Area3D = $attack_area

@export var damage: float = 10.0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	attack_area.monitoring = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if launched:
		attack_area.monitoring = true
	else:
		attack_area.monitoring = false
	

func _on_attack_area_body_entered(body: Node3D) -> void:
	if body is Enemy:
		var _enemy: Enemy = body as Enemy
		var health: HealthComponent
		for child in _enemy.get_children():
			if child is HealthComponent:
				health = child as HealthComponent
				break

		if health:
			var attack = Attack.new()
			attack.damage = damage
			
			health.damage(attack)
			launched = false
