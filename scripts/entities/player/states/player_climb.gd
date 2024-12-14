extends PlayerState

var flip_state: bool

func _update_flip_state(direction):
	#-1, 0, 1
	#Flip the sprite
	if direction > 0:
		flip_state = false
	elif direction < 0:
		flip_state = true

func enter(_previous_state_path: String, _data := {}) -> void:
	flip_state = player.animated_sprite.flip_h
	player.velocity.x = 0
	
	if player.climb_down_ray_cast.is_colliding():
		player.position.y += 1
	else:
		player.position.y -= 1
		
	player.animated_sprite.play('climb')

func physics_update(_delta: float) -> void:
	player.animated_sprite.flip_h = false
	
	var input_direction_x := Input.get_axis('move_left', 'move_right')
	_update_flip_state(input_direction_x)
	var input_direction_y := Input.get_axis('climb_up', 'climb_down')
	
	player.velocity.x = player.modifiers.climb_speed * input_direction_x
	player.velocity.y = player.modifiers.climb_speed * input_direction_y
	player.move_and_slide()
	
	#print('Climb up:', int(Input.is_action_pressed('climb_up')))
	#print('Move left:', int(Input.is_action_pressed('move_left')))
	#print('Move Right:', int(Input.is_action_pressed('move_right')))
	#print(0^(1^1))
	
	if int(Input.is_action_pressed('climb_up')) or int(Input.is_action_pressed('move_left')) ^ int(Input.is_action_pressed('move_right')):
		player.animated_sprite.play()
	elif int(Input.is_action_pressed('climb_down')) ^ int(Input.is_action_pressed('move_left')) or int(Input.is_action_pressed('move_right')):
		player.animated_sprite.play_backwards()
	else:
		player.animated_sprite.pause()
	
	if Input.is_action_just_pressed("jump"):
		player.animated_sprite.flip_h = flip_state
		finished.emit(JUMP)
	
	elif (!player.climb_up_ray_cast.is_colliding()):
		player.animated_sprite.flip_h = flip_state
		finished.emit(JUMP)
		
	elif (!player.climb_down_ray_cast.is_colliding()):
		player.animated_sprite.flip_h = flip_state
		finished.emit(IDLE)
