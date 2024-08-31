extends Area2D

@onready var timer = $Timer

func _on_body_entered(body):
	'''
	Killzone is setup to only collide with player, so body parameter is always player
	'''
	GameManager.take_life()
	print('You Died!')
	Engine.time_scale = 0.5
	timer.start()

func _on_timer_timeout():
	Engine.time_scale = 1.0
	GameManager.reset_score()
	#SceneManager.reload_current_scene()
	SceneManager.goto_scene("res://scenes/levels/level1.tscn")
