#Base class for all Player States
class_name PlayerState extends State

const IDLE = 'Idle'
const RUN = 'Run'
const JUMP = 'Jump'
const FALL = 'Fall'
const HURT = 'Hurt'
const DEATH = 'Death'

var player: Player

func _ready():
	await owner.ready
	player = owner as Player
	assert(player != null, "The PlayerState state type must be used only in the player scene. It needs the owner to be a Player node.")
	
	#Transition functions for all states
	player.stats.health_changed.connect(_connect_damage_transition)

func _connect_damage_transition() -> void:
	if %StateMachine.state.name == HURT:
		#Hurt is already active state so return
		return
	finished.emit(HURT)
