extends PlayerState

func enter(_previous_state_path: String, _data := {}) -> void:
	player.velocity.x = 0.0
	player.animated_sprite.play('idle')
		
func physics_update(delta: float) -> void:
	player.velocity.y += player.stats.gravity * delta
	player.move_and_slide()
	
	if not player.is_on_floor():
		finished.emit(FALL)
	elif Input.is_action_just_pressed("jump"):
		finished.emit(JUMP)
	elif Input.is_action_just_pressed("attack"):
		finished.emit(ATTACK)
	elif Input.is_action_just_pressed("roll"):
		finished.emit(ROLL)
	#XOR operation left XOR right key pressed
	elif int(Input.is_action_pressed("move_left")) ^ int(Input.is_action_pressed("move_right")):
		#await timeout period so if quickly moving left and right, sprite doesn't jitter
		#await get_tree().create_timer(0.03).timeout 
		finished.emit(RUN)
