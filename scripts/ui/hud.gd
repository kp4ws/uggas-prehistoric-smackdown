extends CanvasLayer
@onready var lives_label = $LivesLabel
@onready var score_label = %ScoreLabel

@export var player_data : PlayerData

func _ready():
	if not player_data:
		printerr('HUD is missing Player Data')
		return
		
	player_data.health_changed.connect(_update_lives)
	_update_lives()
	_update_score()

func _update_lives(): 
	#TODO Will probably have hearts instead of health bar for my game
	lives_label.text = "Health: " + str(player_data.health)

func _update_score():
	score_label.text = "Score: " + str(player_data.score)
