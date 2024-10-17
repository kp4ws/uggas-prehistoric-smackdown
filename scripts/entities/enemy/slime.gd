extends Node2D

@export var Modifiers : EnemyModifiers
var direction = 1

@onready var ray_cast_right = $RayCastRight
@onready var ray_cast_left = $RayCastLeft
@onready var animated_sprite = $AnimatedSprite2D

func _physics_process(delta):
	#TODO Is it okay to flip sprite in this function?
	if ray_cast_right.is_colliding():
		direction = -1
		animated_sprite.flip_h = true
	elif ray_cast_left.is_colliding():
		direction = 1
		animated_sprite.flip_h = false

func _process(delta):
	position.x += direction * Modifiers.speed * delta
