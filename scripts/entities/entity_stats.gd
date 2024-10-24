extends Resource
class_name EntityStats

#Modifiers
@export var speed: float = 130.0

#Stats
@export var max_health: int = 100
@export var health: int = 100 #Should this be export ?

#If true, the entity stat variables should be reset to defaults for loaded scene
#Player should have this set to false
#Enemy entities typically should have this set to true
@export var reset_on_ready: bool = false

signal health_changed #TODO Will need to separate this into whether health was added or decreased
signal entity_died
