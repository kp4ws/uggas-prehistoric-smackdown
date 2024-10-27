extends PlayerState

@export var hurt_time = 0.5
var sprite_flip: bool = false
var direction: Vector2 = Vector2.ZERO

func _ready():
	super()
	await owner.ready
	player.stats.health_changed.connect(_connect_damage_transition)

func _connect_damage_transition(attacker):
	if %StateMachine.state.name == HURT:
		#Hurt is already active state so return
		return
	
	direction = player.global_position.direction_to(attacker.global_position)
	#in this case, the hurt state is transitioning to itself from other active state
	finished.emit(HURT)

func enter(previous_state_path: String, data := {}) -> void:
	player.velocity = Vector2(-120 * direction.x, -200)
	player.animation_player.play('hurt')
	sprite_flip = player.animation_player.flip_h
	await get_tree().create_timer(hurt_time).timeout
	_on_hurt_timer_timeout()
	
func physics_update(delta: float) -> void:
	var input_direction_x := Input.get_axis("move_left", "move_right")
	player.velocity.x = lerp(player.velocity.x, 0.0, 0.08)
	player.velocity.y += player.stats.gravity * delta
	player.move_and_slide()
	
	#Damage flash
	player.modulate.a = 0.5 if Engine.get_frames_drawn() % 2 == 0 else 1.0
	
	# ALTERNATIVE WAY OF RETURNING TO OTHER STATES
	#Based on x velocity instead of hurt timer
	#if not is_equal_approx(player.velocity.x, 0.0):
		#return
	#
	#if player.stats.health == 0:
		#finished.emit(DEATH)
	#elif not player.is_on_floor():
		#finished.emit(FALL)
	#elif Input.is_action_just_pressed("jump"):
		#finished.emit(JUMP)
	#elif is_equal_approx(player.velocity.x, 0.0):
		#finished.emit(IDLE)
	#else:
		#finished.emit(RUN)
	
func _on_hurt_timer_timeout():
	#return damage flash back to normal
	player.modulate.a = 1.0
	
	if player.stats.health == 0:
		finished.emit(DEATH)
	elif not player.is_on_floor():
		finished.emit(FALL)
	elif Input.is_action_just_pressed("jump"):
		finished.emit(JUMP)
	elif is_equal_approx(player.velocity.x, 0.0):
		finished.emit(IDLE)
	else:
		finished.emit(RUN)
