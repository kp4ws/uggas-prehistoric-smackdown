extends CharacterBody2D

#Player modifiers
@export var Modifiers : PlayerModifiers

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

@onready var animated_sprite = $AnimatedSprite2D
@onready var collision_shape = $CollisionShape2D
@onready var player_respawn_timer = $PlayerRespawnTimer
@onready var player_health = $Health

#State
var is_dead = false

func _ready():
	player_health.take_life.connect(_on_take_life)
	player_respawn_timer.finished.connect(_on_respawn_finished)

func _on_take_life():
	is_dead = true
	collision_shape.queue_free()
	player_respawn_timer.begin()

func _on_respawn_finished():
	GameManager.decrement_life()

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta
#
	#Ignore player movement if not alive (gravity still applies)
	if is_dead:
		move_and_slide()
		return
	
	
	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = Modifiers.jump_velocity

	#Get input directions: -1, 0, 1
	var direction = Input.get_axis("move_left", "move_right")
	
	#Flip the sprite
	if direction > 0:
		animated_sprite.flip_h = false
	elif direction < 0:
		animated_sprite.flip_h = true
	
	#Play animations
	if is_on_floor():
		if direction == 0:
			animated_sprite.play("idle")
		else:
			animated_sprite.play("run")
	else:
		animated_sprite.play("jump")
		
	#Apply movement
	if direction:
		velocity.x = direction * Modifiers.speed
	else:
		velocity.x = move_toward(velocity.x, 0, Modifiers.speed)

	move_and_slide()
