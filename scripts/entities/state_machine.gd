class_name StateMachine extends Node

# The initial state of the state machine. If not set, the first child node is used.
@export var initial_state: State = null

# The current state of the state machine.
@onready var state: State = (func get_initdial_state() -> State:
	if initial_state != null:
		return initial_state
	elif get_child_count() > 0:
		return get_child(0)
	else:
		#print('Entity', name, 'has no StateMachine')
		return null
).call()

func _ready() -> void:
	#Give every state a reference to the state machine.
	for state_node: State in find_children("*", "State"):
		state_node.finished.connect(_transition_to_next_state)
	
	# State machines usually access data from the root node of the scene they're part of: the owner.
	# We wait for the owner to be ready to guarantee all the data and nodes the states may need are available.
	await owner.ready
	if not state:
		return
		
	state.enter('')

func _transition_to_next_state(target_state_path: String, data: Dictionary = {}) -> void:
	#print('transition to state: ', target_state_path)
	if not has_node(target_state_path):
		printerr(owner.name + ": Trying to transition to state " + target_state_path + " but it does not exist.")
		return
	
	if not state:
		return
	
	var previous_state_path := state.name
	state.exit()
	state = get_node(target_state_path)
	state.enter(previous_state_path, data)

func _unhandled_input(event: InputEvent) -> void:
	if not state:
		return
		
	state.handle_input(event)

func _process(delta) -> void:
	if not state:
		return
	state.update(delta)
	
func _physics_process(delta) -> void:
	if not state:
		return
	state.physics_update(delta)
