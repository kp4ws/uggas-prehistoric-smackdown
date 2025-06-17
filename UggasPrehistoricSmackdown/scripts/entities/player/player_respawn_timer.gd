extends Node2D

@onready var timer = $Timer
signal finished()

func begin():
	Engine.time_scale = 0.5
	timer.start()

func _on_timer_timeout():
		Engine.time_scale = 1.0
		finished.emit()
