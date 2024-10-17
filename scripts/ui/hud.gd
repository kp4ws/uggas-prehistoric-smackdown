extends CanvasLayer
@onready var lives_label = $LivesLabel
@onready var score_label = $ScoreLabel
@onready var relics_label = $RelicsLabel

func _ready():
	GlobalSignals.level_ready.connect(_initiate_hud)
	
	GameManager.lives_updated.connect(_update_lives)
	GameManager.score_updated.connect(_update_score)
	GameManager.relics_updated.connect(_update_relics)	

func _initiate_hud():
	lives_label.text = "Lives: " + str(GameManager.lives) + "/" + str(GameManager.base_lives)
	score_label.text = "Score: " + str(GameManager.score)
	relics_label.text = "Relics: " + str(GameManager.relics) + "/" + str(GameManager.level_relics)
	
func _update_lives(lives):
	lives_label.text = "Lives: " + str(lives) + "/" + str(GameManager.base_lives)

func _update_score(score):
	score_label.text = "Score: " + str(score)

func _update_relics(relics):
	relics_label.text = "Relics: " + str(relics) + "/" + str(GameManager.level_relics)
