extends PlayerState

@export var roll_velocity: Vector2 = Vector2.ZERO

func enter(previous_state_path: String, data := {}) -> void:
	player.animation_player.play('roll')
		
func physics_update(delta: float) -> void:
	var input_direction_x := Input.get_axis('move_left', 'move_right')
	player.velocity.x = player.stats.speed * input_direction_x
	player.velocity.y += player.stats.gravity * delta
	player.move_and_slide()
	
	if not player.is_on_floor():
		finished.emit(FALL)
	elif Input.is_action_just_pressed("jump"):
		finished.emit(JUMP)
	elif is_equal_approx(input_direction_x, 0.0):
		finished.emit(IDLE)
	else:
		finished.emit(RUN)
