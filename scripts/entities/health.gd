extends Node2D
class_name Health

@export var reset_health_on_ready: bool = true
@export var invincible: bool = false
@export var max_health: int = 3
var health: int

signal entity_damaged(attacker)
signal entity_died
signal entity_healed

func _ready():
	if reset_health_on_ready:
		health = max_health

func take_damage(attacker, damage):
	#If invincibility flag set or already dead, then don't take damage
	if invincible or health == 0:
		return
		
	health = max(0, health - damage)
	
	if health == 0:
		entity_died.emit()
	else:
		entity_damaged.emit(attacker)

func add_health(value):
	health = min(max_health, health + value)
	entity_healed.emit()
