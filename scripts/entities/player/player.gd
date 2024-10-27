#This node is the host of the state machine
class_name Player extends CharacterBody2D

#In Godot, we can access the root node of the scene the state is part of using the owner property.

#Player modifiers
@export var stats : PlayerStats
@onready var animation_player = $AnimatedSprite2D
@onready var collision_shape = $CollisionShape2D
@onready var invincibility_timer = $Timers/InvincibilityTimer

func _ready():
	modulate.a = 1.0
	stats.invincible = false
	stats.entity_died.connect(_on_die)
	#stats.health_changed.connect(_on_hurt)

func _physics_process(_delta):
	if stats.health == 0:
		#TODO is there a better way to disable input ?
		#TODO in death state, if health == 0 then just state and don't allow player to move?
		velocity.x = 0.0
		return

	_flip_sprite()
	
	if stats.invincible:
		modulate.a = 0.5 if Engine.get_frames_drawn() % 2 == 0 else 1.0

func _flip_sprite():
	#-1, 0, 1
	var input_direction_x := Input.get_axis("move_left", "move_right")
	#Flip the sprite
	if input_direction_x > 0:
		animation_player.flip_h = false
	elif input_direction_x < 0:
		animation_player.flip_h = true

func trigger_invincible():
	stats.invincible = true
	invincibility_timer.start()
	await invincibility_timer.timeout
	stats.invincible = false
	modulate.a = 1.0

func _on_die():
	print('should die')
	await get_tree().create_timer(1).timeout #TODO Error between this and killzone where it doesn't actually reload the level
	#TODO Call gameover scene
	SceneManager.load_main_menu()
