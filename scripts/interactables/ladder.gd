extends Node2D

@onready var interaction_area = $InteractionArea

func _ready():
	interaction_area.interact = Callable(self, '_on_interact')
	interaction_area.end_interact = Callable(self, '_on_end_interact')

func _on_interact():
	#TODO disable player input, play climbing animation and make player auto climb to top of ladder
	pass

func _on_end_interact():
	#TODO enable player input (and anything else needed)
	pass
