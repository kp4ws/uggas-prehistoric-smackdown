extends Node2D

@export var enemy_stats : EnemyStats
var direction = 1

@onready var ray_cast_right = $RayCastRight
@onready var ray_cast_left = $RayCastLeft
@onready var sprite = $Sprite
@onready var hitbox_area = $HitboxArea

func _physics_process(delta):
	#TODO Is it okay to flip sprite in this function?
	if ray_cast_right.is_colliding():
		direction = -1
		sprite.flip_h = true
	elif ray_cast_left.is_colliding():
		direction = 1
		sprite.flip_h = false

func _process(delta):
	position.x += direction * enemy_stats.base_speed * delta
