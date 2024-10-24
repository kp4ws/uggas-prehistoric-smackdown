#This node is the host of the state machine
class_name Player extends CharacterBody2D

#In Godot, we can access the root node of the scene the state is part of using the owner property.

#Player modifiers
@export var stats : PlayerStats
@onready var animation_player = $AnimatedSprite2D
@onready var collision_shape = $CollisionShape2D
#@onready var respawn_timer = %RespawnTimer

#State
#var is_dead = false
#

func _ready():
	stats.health_changed.connect(func():
		print('health changed'))

func _physics_process(delta):
	_flip_sprite()

func _flip_sprite():
	#-1, 0, 1
	var input_direction_x := Input.get_axis("move_left", "move_right")
	#Flip the sprite
	if input_direction_x > 0:
		animation_player.flip_h = false
	elif input_direction_x < 0:
		animation_player.flip_h = true

#TODO I think these connections should now be in the state machine class ?
#func _ready():
	#stats.entity_died.connect(_on_die)
	#stats.health_changed.connect(_on_hurt)
#
#func _on_hurt():
	##TODO other animation overriding so this one doesn't play
	#animation.play('hurt')
#
#func _on_die():
	#is_dead = true
	#animation.play('death')	
	#collision_shape.queue_free()
