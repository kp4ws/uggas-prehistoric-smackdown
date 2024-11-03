extends PlayerState

var sprite_flip: bool = false

func enter(previous_state_path: String, data := {}) -> void:
	player.animated_sprite.play('death')
	sprite_flip = player.animated_sprite.flip_h
	
func physics_update(delta: float) -> void:
	player.animated_sprite.flip_h = sprite_flip
	player.velocity.y += player.stats.gravity * delta
	player.move_and_slide()
