extends RigidBody3D
class_name ExplosionItem

var launched: bool = false
@onready var explosion_area: Area3D = $explosion_area
@onready var launch_detect: Area3D = $launch_detect
@onready var audio: AudioStreamPlayer3D = $audio
@onready var animation: AnimationPlayer = $animation

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$animation2d.hide()
	explosion_area.monitoring = false
	if !launched:
		launch_detect.monitoring = false

func _physics_process(delta: float) -> void:
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	#print("launched: " + str(launched))
	if launched:
		launch_detect.monitoring = true
	else:
		launch_detect.monitoring = false
		
		
func explosion():
	explosion_area.monitoring = true
	$barrel_red.hide()
	if $CollisionShape3D:
		$CollisionShape3D.queue_free()
	animation.play("explosion")
	await get_tree().create_timer(0.1).timeout
	explosion_area.monitoring = false
	launch_detect.monitoring = false
	await animation.animation_finished
	queue_free()
		
	
func _on_explosion_area_body_entered(body: Node3D) -> void:
	if body is Enemy:
		var enemy = body as Enemy
		enemy.queue_free()
	if body is ExplosionItem:
		var new_barrel: ExplosionItem = body as ExplosionItem
		new_barrel.explosion()
	if body is Door:
		var door: Door = body as Door
		door.level.secret()
		door.queue_free()


func _on_launch_detect_body_entered(body: Node3D) -> void:
	if body is Enemy:
		explosion()
		
	if body is Door:
		explosion()
