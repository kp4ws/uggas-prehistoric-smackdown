extends EntityModifiers
class_name PlayerModifiers 

@export var jump_impulse: float = 200.0

#Horizontal movement speed. EntityModifiers has base speed variable
@export var air_speed: float = 130.0
@export var attack_speed: float = 80.0

@export var knockback_strength: Vector2 = Vector2(200, 200) 
@export var roll_impulse: float = 200.0

@export var attack_distance: float = 200.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
@export var gravity: float = ProjectSettings.get_setting("physics/2d/default_gravity")
