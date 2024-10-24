extends EntityStats
class_name PlayerStats

@export var jump_impulse = 300.0
# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

@export var score: int = 0
signal score_changed
