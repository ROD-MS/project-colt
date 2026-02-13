extends Node3D
class_name Level

var target_count: int = 0
var max_target: int = 0

@export var player: Player

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Dialogic.start("tutorial")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func add_target_counter():
	target_count += 1
	max_target = target_count
	print(max_target)
	
func sub_target_counter():
	target_count -= 1
	print(target_count)
	if target_count == max_target - 1:
		Dialogic.VAR.tutorial = 5
		Dialogic.start("tutorial")
	if target_count == 0:
		Dialogic.VAR.tutorial = 6
		Dialogic.start("tutorial")
		Engine.time_scale = 0.5
		await get_tree().create_timer(0.5).timeout
		Engine.time_scale = 1
		
		player.play_voice()
		
func launched_item():
	if Dialogic.VAR.tutorial == 5:
		Dialogic.end_timeline()

func secret():
	Dialogic.VAR.tutorial = 9
	Dialogic.start("tutorial")
	await get_tree().create_timer(5).timeout
	Dialogic.end_timeline()

func _on_tutorial_1_body_entered(body: Node3D) -> void:
	if body is Player:
		if Dialogic.VAR.tutorial == 0:
			Dialogic.VAR.tutorial = 1
			Dialogic.start("tutorial")


func _on_tutorial_2_body_entered(body: Node3D) -> void:
	if body is Player:
		if Dialogic.VAR.tutorial == 1:
			Dialogic.VAR.tutorial = 2
			Dialogic.start("tutorial")


func _on_tutorial_3_body_entered(body: Node3D) -> void:
	if body is Player:
		if Dialogic.VAR.tutorial == 2:
			Dialogic.VAR.tutorial = 3
			Dialogic.start("tutorial")


func _on_tutorial_4_body_entered(body: Node3D) -> void:
	if body is Player:
		if Dialogic.VAR.tutorial == 3:
			Dialogic.VAR.tutorial = 4
			Dialogic.start("tutorial")


func _on_tutorial_7_body_entered(body: Node3D) -> void:
	if body is Player:
		if Dialogic.VAR.tutorial == 6 or Dialogic.VAR.tutorial == 5:
			Dialogic.VAR.tutorial = 7
			Dialogic.start("tutorial")


func _on_tutorial_8_body_entered(body: Node3D) -> void:
	if body is Player:
		if Dialogic.VAR.tutorial == 7:
			Dialogic.VAR.tutorial = 8
			Dialogic.start("tutorial")
			await get_tree().create_timer(3).timeout
			Dialogic.end_timeline()
