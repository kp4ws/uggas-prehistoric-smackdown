extends Node

#signals
signal score_updated(score)
signal lives_updated(lives)
signal player_died()

#globals
var score = 0
var player_lives = 3

func add_point():
	score += 1
	print(score)
	score_updated.emit(score)
	if score == 5:
		#TODO should next level be a signal that's emitted?
		SceneManager.goto_scene("res://scenes/levels/level2.tscn")

func take_life():
	player_lives -= 1
	lives_updated.emit(player_lives)
	
	if player_lives <= 0:
		player_died.emit()

func reset_score():
	score = 0
	score_updated.emit(score)
