extends Node2D

@export var dialogue: Dialogue
@onready var interaction_area = $InteractionArea

func _ready():
	interaction_area.interact = Callable(self, '_on_interact')
	interaction_area.end_interact = Callable(self, '_on_end_interact')

func _on_interact():
	DialogueManager.start_dialogue(global_position, dialogue.lines)
	await DialogueManager.dialog_finished

func _on_end_interact():
	if DialogueManager.is_dialog_active:
		DialogueManager.end_dialogue()
	
