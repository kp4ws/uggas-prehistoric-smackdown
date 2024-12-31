extends PlayerState

var can_deal_damage: bool = true

func enter(_previous_state_path: String, _data := {}) -> void:
	# player.velocity.x = 0.0
	can_deal_damage = true
	player.animated_sprite.play('attack')
	player.punch_fx.play('punch')
	get_tree().create_timer(0.3).timeout.connect(_on_attack_timeout)

func physics_update(_delta: float) -> void:
	var input_direction_x := Input.get_axis('move_left', 'move_right')
	
	#Enable this to allow movement during attack
	#player.velocity.x = player.modifiers.attack_speed * input_direction_x
	player.velocity.x = 0
	player.velocity.y += player.modifiers.gravity * _delta
	player.move_and_slide()
	
	var target = player.attack_ray_cast.get_collider()
	if not target:
		print('No target')
		return
	
	var target_health = target.owner.get_node('Health')
		
	if not target_health:
		print('No target health: ', target.owner.name, target.owner.get_children())
		return
	
	print('Target damage')
	if can_deal_damage:
		target_health.take_damage(self, player.modifiers.attack_damage)
		#TODO Refactor. This allows player to only deal damage once per attack
		can_deal_damage = false
	
func _on_attack_timeout():
	player.punch_fx.play('default')
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
