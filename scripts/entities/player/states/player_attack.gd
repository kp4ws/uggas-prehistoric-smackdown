extends PlayerState

func enter(_previous_state_path: String, _data := {}) -> void:
	# player.velocity.x = 0.0
	player.animated_sprite.play('attack')
	await get_tree().create_timer(0.3).timeout
	_on_attack_timeout()

func physics_update(_delta: float) -> void:
	var input_direction_x := Input.get_axis('move_left', 'move_right')
	player.velocity.x = player.stats.attack_speed * input_direction_x
	player.velocity.y += player.stats.gravity * _delta
	player.move_and_slide()
	
func _on_attack_timeout():
	# if player.stats.health == 0:
	# 	finished.emit(DEATH)
	if not player.is_on_floor():
		finished.emit(FALL)
	# elif Input.is_action_just_pressed("jump"):
	# 	finished.emit(JUMP)
	elif is_equal_approx(player.velocity.x, 0.0):
		finished.emit(IDLE)
	else:
		finished.emit(RUN)