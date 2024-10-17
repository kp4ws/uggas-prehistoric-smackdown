extends Area2D

@export var damageAmount = 100

func _on_body_entered(body):
	'''
	Killzone is setup to only collide with player, so body parameter is always player
	'''
	var player_health = body.get_node("Health")
	if player_health == null:
		printerr("Player has no health")
		return
		
	player_health.take_damage(damageAmount)
