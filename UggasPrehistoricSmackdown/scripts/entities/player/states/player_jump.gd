extends PlayerState

var jump_velocity: float = 0.0
var jump_timer: float = 0.0
const HIGH_JUMP: float = 0.1

func enter(previous_state_path: String, data := {}) -> void:
	jump_timer = 0.0
	jump_velocity = -player.modifiers.jump_impulse
	player.animated_sprite.play('jump')
	
func physics_update(_delta: float) -> void:
	var input_direction_x := Input.get_axis("move_left", "move_right")
	player.velocity.x = player.modifiers.air_speed * input_direction_x

	if Input.is_action_pressed("jump") && jump_timer < HIGH_JUMP:
		player.velocity.y = jump_velocity
		jump_timer += _delta
	
	player.velocity.y += player.modifiers.gravity * _delta
	player.move_and_slide()

	if Input.is_action_just_pressed("attack"):
		finished.emit(ATTACK) 
	elif player.velocity.y >= 0:
		finished.emit(FALL)

func exit() -> void:
	jump_timer = 0.0
	jump_velocity = 0.0