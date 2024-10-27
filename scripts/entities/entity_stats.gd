extends Resource
class_name EntityStats

#States
@export var invincible: bool = false

#Modifiers
@export var speed: float = 130.0

#Stats
@export var max_health: int = 100
@export var health: int = 100 #Should this be export ?

#If true, the entity stat variables should be reset to defaults for loaded scene
#Player should have this set to false
#Enemy entities typically should have this set to true
@export var reset_on_ready: bool = false

#TODO is this needed in EntityStats base class or should it just be in PlayerStats?
#TODO this should be split into 2 signals: damage_taken and entity_healed (only for player?)
#TODO for methods that don't need to know about the attacker, is there a way we can refactor code so we don't include in function params ?
signal health_changed(attacker)

signal entity_died
