extends Node3D

signal enemyDead

# ARMAZENANDO O HIGHSCORE
var level: Dictionary = {}
var level_highscore: Dictionary = {}

# SCORE E COMBOS NO MOMENTO DA GAMEPLAY
var score: float = 0
var max_combo: float = 10
var combo: float = 0

func add_normal_point(new_point: float) -> void: # PONTOS SÃO DADOS APENAS QUANDO INIMIGOS SÃO MORTOS SEM HEADSHOT
	var add_combo: float = 1
	if combo <= max_combo:
		combo += add_combo
		
	score += new_point * combo
	
	enemyDead.emit(score, combo)
	
func reset_combo() -> void:
	combo = 0
	
func reset_score() -> void:
	score = 0
	
	
