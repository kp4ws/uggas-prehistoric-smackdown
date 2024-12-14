extends PlayerState

func enter(_previous_state_path: String, _data := {}) -> void:
	player.animated_sprite.play('fall')
	
func physics_update(_delta: float) -> void:
	var input_direction_x := Input.get_axis("move_left", "move_right")
	player.velocity.x = player.modifiers.air_speed * input_direction_x
	player.velocity.y += player.modifiers.gravity * _delta
	player.move_and_slide()
	
	if Input.is_action_just_pressed("attack"):
		finished.emit(ATTACK)
	elif player.is_on_floor():
		if is_equal_approx(input_direction_x, 0.0):
			finished.emit(IDLE)
		else:
			finished.emit(RUN)
