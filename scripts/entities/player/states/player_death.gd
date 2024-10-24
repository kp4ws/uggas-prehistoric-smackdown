extends PlayerState

var sprite_flip: bool = false

func enter(previous_state_path: String, data := {}) -> void:
	player.animation_player.play('death')
	sprite_flip = player.animation_player.flip_h
	
func physics_update(delta: float) -> void:
	player.animation_player.flip_h = sprite_flip
