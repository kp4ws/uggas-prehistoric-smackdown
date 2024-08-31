extends CanvasLayer
@onready var score_label = $ScoreLabel
@onready var lives_label = $LivesLabel

func _ready():
	GameManager.score_updated.connect(_on_score_updated)
	GameManager.lives_updated.connect(_on_lives_updated)

func _on_score_updated(score):
	score_label.text = "Coins: " + str(score) + "/5"

func _on_lives_updated(lives):
	lives_label.text = "Lives: " + str(lives) + "/3"
