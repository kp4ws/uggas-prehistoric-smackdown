extends PlayerState

@export var hurt_time = 0.5

func enter(previous_state_path: String, data := {}) -> void:
	#TODO Fly away from enemy who damaged player
	player.animation_player.play('hurt')
	await get_tree().create_timer(hurt_time).timeout
	_on_hurt_timer_timeout()

func physics_update(delta: float) -> void:
	pass

func _knockback() -> void:
	var knockback_strength: float = 11500.0
	var knockback_velocity = player.position.normalized() * knockback_strength
	player.velocity = Vector2(knockback_velocity)

func _on_hurt_timer_timeout():
	var input_direction_x := Input.get_axis("move_left", "move_right")
	
	if player.stats.health == 0:
		finished.emit(DEATH)
	elif not player.is_on_floor():
		finished.emit(FALL)
	elif is_equal_approx(input_direction_x, 0.0):
		finished.emit(IDLE)
	else:
		finished.emit(RUN)
