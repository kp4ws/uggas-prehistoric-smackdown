extends Area2D
class_name InteractionArea

@export var action_name: String = 'Interact'

func _ready():
	#TODO How can I connect all interaction areas via gui connection?
	body_entered.connect(_on_body_entered)
	body_exited.connect(_on_body_exited)

var interact: Callable = func():
	pass

var end_interact: Callable = func():
	pass

func _on_body_entered(body):
	InteractionManager.register_area(self)

func _on_body_exited(body):
	InteractionManager.unregister_area(self)
