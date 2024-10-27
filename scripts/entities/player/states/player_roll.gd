extends PlayerState

var roll_velocity: float = 0.0

func enter(_previous_state_path: String, _data := {}) -> void:
	roll_velocity = player.stats.roll_impulse
	player.animation_player.play('roll')
		
func physics_update(_delta: float) -> void:
	var input_direction_x := Input.get_axis('move_left', 'move_right')
	player.velocity.x = -roll_velocity * input_direction_x
	player.velocity.y += player.stats.gravity * _delta
	player.move_and_slide()

	# print(roll_velocity)

	if roll_velocity > 0:
		roll_velocity = lerpf(roll_velocity, 0, 0.1)

	elif not player.is_on_floor():
		finished.emit(FALL)
	# elif Input.is_action_just_pressed("jump"):
	# 	finished.emit(JUMP)
	elif is_equal_approx(player.velocity.x, 0.0):
		finished.emit(IDLE)
	# else:
	# 	finished.emit(RUN)
