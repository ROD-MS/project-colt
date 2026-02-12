extends Node

const save_location = "user://SaveFile.json"

var contents_to_save: Dictionary = {
	"highscore_level_1": 0.0,
	"highscore_level_2": 0.0,
	"highscore_level_3": 0.0
}


func _ready() -> void:
	_load()

func _save():
	var file = FileAccess.open_encrypted_with_pass(save_location, FileAccess.WRITE, "75347pc0")
	file.store_var(contents_to_save.duplicate())
	file.close()

func _load():
	if FileAccess.file_exists(save_location):
		var file = FileAccess.open_encrypted_with_pass(save_location, FileAccess.READ, "75347pc0")
		var data = file.get_var()
		file.close()
		
		var save_data = data.duplicate()
		contents_to_save.highscore_level_1 = save_data.highscore_level_1
		contents_to_save.highscore_level_2 = save_data.highscore_level_2
		contents_to_save.highscore_level_3 = save_data.highscore_level_3
