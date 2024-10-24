extends PlayerState

func enter(previous_state_path: String, data := {}) -> void:
	player.velocity.x = 0.0
	player.animation_player.play('idle')
		
func physics_update(_delta: float) -> void:
	player.velocity.y += player.stats.gravity * _delta
	player.move_and_slide()
	
	if not player.is_on_floor():
		finished.emit(FALL)
	elif Input.is_action_just_pressed("jump"):
		finished.emit(JUMP)
		
		#XOR operation left XOR right key pressed
	elif int(Input.is_action_pressed("move_left")) ^ int(Input.is_action_pressed("move_right")):
		#await timeout period so if quickly moving left and right, sprite doesn't jitter
		#await get_tree().create_timer(0.03).timeout 
		finished.emit(RUN)
