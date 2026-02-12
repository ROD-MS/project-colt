extends CanvasLayer
var audio_bus_id: int = 0

func _ready() -> void:
	audio_bus_id = AudioServer.get_bus_index("Master")
	$config/slider_mouse.value = Config.mouse_sensibility
	$config/slider_sounds.value = Config.sound_volume
	visible = false
	
func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("free_mouse"):
		if visible:
			visible = false
			Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
			$config.hide()
			$menu_holder.show()
			get_tree().paused = false
		else:
			visible = true
			get_tree().paused = true
			
			
func _on_resume_pressed() -> void:
	visible = false
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	get_tree().paused = false
	
	
func _on_menu_pressed() -> void:
	get_tree().paused = false
	get_tree().change_scene_to_file("res://scenes/menu.tscn")

func _on_configuration_pressed() -> void:
	$menu_holder.hide()
	$config.show()
	
	
func _on_quit_pressed() -> void:
	get_tree().quit()


# ===========================
# ====== CONFIG MENU ========
# ===========================

func _on_back_config_pressed() -> void:
	$config.hide()
	$menu_holder.show()


func _on_slider_mouse_value_changed(value: float) -> void:
	Config.mouse_sensibility = value

func _on_slider_sounds_value_changed(value: float) -> void:
	Config.sound_volume = value
	var db = linear_to_db(value)
	AudioServer.set_bus_volume_db(audio_bus_id, db)
