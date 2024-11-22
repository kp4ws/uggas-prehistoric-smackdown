extends Resource
class_name PlayerData

@export var health: int = 100
@export var score: int = 0

func set_health(value):
	health = value
	health_changed.emit()

func add_to_score(value):
	score += value
	score_changed.emit()
	
signal health_changed
signal score_changed
