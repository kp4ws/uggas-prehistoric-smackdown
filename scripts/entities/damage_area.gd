extends Area2D
class_name DamageArea

@export var damage_amount = 25
@export var is_killzone: bool = false

func _ready():
	body_entered.connect(_on_body_entered)

func _on_body_entered(body):
	#NOTE The mask property in CollisionObject2D should be set to the layer to damage
	
	#NOTE class_name must be Health
	var health_node = body.get_node('Health')
	
	if not health_node:
		printerr('Entity: ', body.name, 'is missing Health node')
		return
	
	health_node.take_damage(self, damage_amount)
	
	if is_killzone:
		_handle_killzone(health_node)

func _handle_killzone(health_node):
	if not $KillzoneTimer:
		print('Killzone Timer is not attached to DamageArea2D')
		return
	
	#Start reload timer and damage player
	Engine.time_scale = 0.3
	
	if health_node.get_health() == 0:
		#If player is dead, don't respawn
		return
	
	$KillzoneTimer.start()

func _on_killzone_timer_timeout():
	#On timeout, send signal to reload level
	Engine.time_scale = 1.0
	GlobalSignals.reload_level.emit()
