extends CanvasLayer
@onready var lives_label = $LivesLabel
@onready var score_label = $ScoreLabel

@export var player_stats: PlayerStats

func _ready():
	#GlobalSignals.level_ready.connect(_initiate_hud)
	_initiate_hud()
	player_stats.health_changed.connect(_update_lives)
	player_stats.score_changed.connect(_update_score)

func _initiate_hud():
	_update_lives(0)
	_update_score()

#TODO health_changed emits the attacker who did the damage. This isn't needed in this function
func _update_lives(attacker): 
	#TODO Will probably have hearts instead of health bar for my game
	lives_label.text = "Health: " + str(player_stats.health)

func _update_score():
	score_label.text = "Score: " + str(player_stats.score)
