extends Node

#Player
@export var base_lives: int = 5
var lives: int = 3
var score: int = 0

#Level
var relics: int = 0
var level_relics: int = 0

#GameManager Signals
signal lives_updated(lives)
signal score_updated(score)
signal relics_updated(relics)

func _set_lives(new_lives):
	lives = new_lives
	lives_updated.emit(lives)	

func _set_score(new_score):
	score = new_score
	score_updated.emit(score)

func _set_relics(new_relic):
	relics = new_relic
	relics_updated.emit(relics)

func _ready():
	_set_lives(base_lives)

func initiate_level(relics: int):
	'''
	Called from _ready function of level_info script.
	This function is called everytime a level is loaded (reload or new level)
	'''
	_set_relics(0)
	level_relics = relics
	GlobalSignals.level_ready.emit()

func add_relic():
	_set_relics(relics+1)
	
	#go to next level
	if relics == level_relics:
		#GlobalSignals.load_next_level.emit()
		await SceneManager.load_next_scene()

func add_score():
	_set_score(score+1)
	
func decrement_life():
	_set_lives(max(0, lives-1))
	#If no lives remaining then emit gameover. Otherwise reload scene
	if lives == 0:
		GlobalSignals.game_over.emit()
	else:
		#Restart level
		#GlobalSignals.reload_level.emit()
		await SceneManager.reload_current_scene()
