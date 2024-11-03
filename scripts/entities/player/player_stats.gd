extends EntityStats
class_name PlayerStats

@export var jump_impulse: float = 200.0

#Horizontal movement speed. EntityStats has base speed variable
@export var air_speed: float = 100.0
@export var attack_speed: float = 80.0

@export var knockback_strength: Vector2 = Vector2(200, 200) 
@export var roll_impulse: float = 500.0
# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

@export var score: int = 0
signal score_changed
