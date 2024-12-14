extends CanvasLayer
@onready var heart_0 = %Heart0
@onready var heart_1 = %Heart1
@onready var heart_2 = %Heart2
@onready var relic_label = %RelicLabel

@export var full_heart: Texture2D
@export var empty_heart: Texture2D

@export var player_data : PlayerData

func _ready():
	if not player_data:
		printerr('HUD is missing Player Data')
		return
		
	player_data.health_changed.connect(_update_lives)
	player_data.score_changed.connect(_update_score)
	_update_lives()
	_update_score()

func _update_lives(): 
	#Full hearts
	if player_data.health == 100:
		heart_0.texture = full_heart
		heart_1.texture = full_heart
		heart_2.texture = full_heart
		
	#2 hearts
	elif player_data.health > 33:
		heart_0.texture = full_heart
		heart_1.texture = full_heart
		heart_2.texture = empty_heart
		
	#1 heart
	elif player_data.health > 0:
		heart_0.texture = full_heart
		heart_1.texture = empty_heart
		heart_2.texture = empty_heart
	
	#0 hearts
	else:
		heart_0.texture = empty_heart
		heart_1.texture = empty_heart
		heart_2.texture = empty_heart

func _update_score():
	relic_label.text = "Relics: " + str(player_data.score)
