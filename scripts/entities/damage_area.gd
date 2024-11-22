extends Area2D
class_name DamageArea

@export var damage_amount = 25
@export var is_killzone: bool = false
var target_health: Health = null 

func _ready():
	body_entered.connect(_on_body_entered)
	body_exited.connect(_on_body_exited)

func _process(delta):
	#If still touching target then keep dealing damage
	if target_health:
		target_health.take_damage(self, damage_amount)

func _on_body_entered(body: Node2D):
	#NOTE The mask property in CollisionObject2D should be set to the layer to damage
	
	#NOTE class_name must be Health
	target_health = body.get_node('Health')
	
	if not target_health:
		printerr('Entity: ', body.name, 'is missing Health node')
		return
	
	target_health.take_damage(self, damage_amount)
	
	if is_killzone:
		_handle_killzone(target_health)

func _on_body_exited(body: Node2D):
	if not target_health:
		return
	
	if body == target_health.owner:
		target_health = null

func _handle_killzone(target_health: Health):
	if not $KillzoneTimer:
		print('Killzone Timer is not attached to DamageArea2D')
		return
	
	if target_health.health == 0:
		print('health is 0')
		#If player is dead, don't respawn
		return

	#Start reload timer and damage player
	Engine.time_scale = 0.3
	print('health is not 0')
	$KillzoneTimer.start()

func _on_killzone_timer_timeout():
	#On timeout, send signal to reload level
	Engine.time_scale = 1.0
	GlobalSignals.reload_level.emit()
