extends Node2D

@export var max_health = 100
var current_health : int = 100
signal take_life()

#TODO Need to send global signal for when health changes, in order to update HUD

func _ready():
	current_health = max_health

func take_damage(damageAmount):
	if current_health == 0:
		return
	
	current_health = max(0, current_health - damageAmount)
	print('Health remaining: ', current_health)
	
	#Since we clamped health, we can just check equal to
	if current_health == 0:
			take_life.emit()
