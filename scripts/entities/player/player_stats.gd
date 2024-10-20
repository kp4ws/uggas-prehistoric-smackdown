extends EntityStats
class_name PlayerStats

#TODO should I just have speed and everything in here, and make completely separate from entity modifiers ?
	
@export var jump_velocity = -300.0
# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

@export var score: int = 0
signal score_changed
