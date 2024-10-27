extends Node2D
class_name Health

@export var entity_stats : EntityStats

func _ready():
	if not entity_stats:
		printerr('Health has no entity stats')
	GlobalSignals.start_game.connect(_reset_health)
	if entity_stats.reset_on_ready:
		_reset_health()
	
func _reset_health():
	entity_stats.health = entity_stats.max_health

func get_health():
	return entity_stats.health

func take_damage(attacker, damage):
	#If entity is already dead, don't do anything
	if entity_stats.health == 0:
		return
	
	entity_stats.health = max(0, entity_stats.health - damage)
	entity_stats.health_changed.emit(attacker)
	
	if entity_stats.health == 0:
		entity_stats.entity_died.emit()

func add_health(value):
	entity_stats.health += value
	entity_stats.health_changed.emit()
