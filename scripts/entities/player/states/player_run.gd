extends PlayerState

func enter(_previous_state_path: String, _data := {}) -> void:
	player.animated_sprite.play('run')
		
func physics_update(_delta: float) -> void:
	var input_direction_x := Input.get_axis('move_left', 'move_right')
	player.velocity.x = player.modifiers.base_speed * input_direction_x
	player.velocity.y += player.modifiers.gravity * _delta
	player.move_and_slide()
	
	if not player.is_on_floor():
		finished.emit(FALL)
	elif Input.is_action_just_pressed("jump"):
		finished.emit(JUMP)
	elif Input.is_action_just_pressed("attack"):
		finished.emit(ATTACK)
	elif Input.is_action_just_pressed("roll"):
		finished.emit(ROLL)
	elif Input.is_action_pressed("climb_up") and player.climb_up_ray_cast.is_colliding():
		finished.emit(CLIMB)
	elif Input.is_action_pressed("climb_down") and player.climb_down_ray_cast.is_colliding():
		finished.emit(CLIMB)
	elif is_equal_approx(input_direction_x, 0.0):
		finished.emit(IDLE)
