extends Node3D

signal enemyDead

# ARMAZENANDO O HIGHSCORE
var level: Dictionary = {
	"level_1": true,
	"level_2": false,
	"level_3": false
}

var highscore: Dictionary = {
	"level_1": 0.0,
	"level_2": 0.0,
	"level_3": 0.0
}

# SCORE E COMBOS NO MOMENTO DA GAMEPLAY
var score: float = 0
var max_combo: float = 9
var combo: float = 0
var _new_highscore: float = 0
var tentativas_level1: int = 0
var tentativas_level2: int = 0

var current_level: String = ""

# congeek
var max_score: float = 0

func add_score():
	max_score += score
	
func reset_max_score():
	max_score = 0


func _ready() -> void:
	current_level = level.find_key(true)
	print(highscore)
	#print(current_level)
	
func set_level(_level: String):
	match _level:
		"level_1":
			level["level_1"] = true
			level["level_2"] = false
			level["level_3"] = false
		"level_2":
			level["level_1"] = false
			level["level_2"] = true
			level["level_3"] = false
		"level_3":
			level["level_1"] = false
			level["level_2"] = false
			level["level_3"] = true
	
	current_level = level.find_key(true)

func add_normal_point(new_point: float) -> void: # PONTOS SÃO DADOS APENAS QUANDO INIMIGOS SÃO MORTOS SEM HEADSHOT
	var add_combo: float = 1
	if combo <= max_combo:
		combo += add_combo
		
	score += new_point * combo
	
	match current_level:
		"level_1":
			#print("level_1")
			_new_highscore = highscore.level_1
			if score > highscore.level_1:
				highscore.level_1 = score
				_new_highscore = score
				print("score if")
			print("Score 1: " + str(highscore.level_1))
		"level_2":
			_new_highscore = highscore.level_2
			if score > highscore.level_2:
				highscore.level_2 = score
				_new_highscore = score
			print("Score 2: " + str(highscore.level_1))
		"level_3":
			_new_highscore = highscore.level_3
			if score > highscore.level_3:
				highscore.level_3 = score
				_new_highscore = score
			print("Score 3: " + str(highscore.level_1))
	
	
	enemyDead.emit(score, combo, _new_highscore)
	
func down_combo() -> void:
	if combo == 2:
		combo = 0
	elif combo > 0:
		combo -= 1
	
func reset_score() -> void:
	score = 0
	
	
