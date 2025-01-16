extends PlayerState

var sprite_flip: bool = false

func _ready():
	super()
	await owner.ready
	player.health_component.entity_died.connect(_connect_death_transition)

func _connect_death_transition():
	if %StateMachine.state.name == DEATH:
		#DEATH is already active state so return
		return
	
	#in this case, the hurt state is transitioning to itself from other active state
	finished.emit(DEATH)

func enter(previous_state_path: String, data := {}) -> void:
	player.animated_sprite.play('death')
	sprite_flip = player.animated_sprite.flip_h
	
func physics_update(delta: float) -> void:
	player.animated_sprite.flip_h = sprite_flip
	player.velocity.y += player.modifiers.gravity * delta
	player.move_and_slide()
