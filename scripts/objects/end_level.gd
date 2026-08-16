extends Area3D

@export var next_level: PackedScene
@export var bestscoreHud: BestscoreHUD

func _ready() -> void:
	if bestscoreHud:
		bestscoreHud.change_visibility(false)
		bestscoreHud.next_level = next_level

func _process(delta: float) -> void:
	pass

func _on_body_entered(body: Node3D) -> void:
	if body is Player:
		Score_control.add_score()
		
		#if Dialogic.VAR.get_variable("tutorial") < 8:
		Dialogic.VAR.tutorial = -1
		Dialogic.VAR.set_variable("tutorialClear", true)
		Dialogic.end_timeline(true)


		if bestscoreHud:
			var player = body as Player
			bestscoreHud.player = player
			print(bestscoreHud.player)
			
			bestscoreHud.change_visibility(true)
		else:
			get_tree().change_scene_to_file("res://scenes/levels/level_1.tscn")

func _physics_process(delta: float) -> void:
	$MeshInstance3D.rotation.y += 0.05
