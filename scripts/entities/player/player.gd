#This node is the host of the state machine
class_name Player extends CharacterBody2D

#In Godot, we can access the root node of the scene the state is part of using the owner property.

#Player modifiers
@export var stats : PlayerStats
@onready var animation_player = $AnimatedSprite2D
@onready var collision_shape = $CollisionShape2D

func _ready():
	pass
	#stats.entity_died.connect(_on_die)
	#stats.health_changed.connect(_on_hurt)

func _physics_process(delta):
	if stats.health == 0:
		#TODO is there a better way to disable input ?
		#TODO in death state, if health == 0 then just state and don't allow player to move?
		velocity.x = 0.0
		return
		
	_flip_sprite()

func _flip_sprite():
	#-1, 0, 1
	var input_direction_x := Input.get_axis("move_left", "move_right")
	#Flip the sprite
	if input_direction_x > 0:
		animation_player.flip_h = false
	elif input_direction_x < 0:
		animation_player.flip_h = true
