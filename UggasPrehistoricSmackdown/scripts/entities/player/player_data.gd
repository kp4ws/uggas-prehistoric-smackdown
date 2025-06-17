extends Resource
class_name PlayerData

@export var health: int = 3
@export var score: int = 0

signal health_changed
signal score_changed

func set_health(value):
	health = value
	health_changed.emit()

func add_to_score(value):
	score += value
	score_changed.emit()
