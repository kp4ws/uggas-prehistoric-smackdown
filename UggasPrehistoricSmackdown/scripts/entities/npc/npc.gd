extends Node2D

@onready var interaction_area = $InteractionArea
@export var dialogue: Dialogue
@export var speech_sfx: Array[AudioStream] 

func _ready():
	interaction_area.interact = Callable(self, '_on_interact')
	interaction_area.end_interact = Callable(self, '_on_end_interact')

func _on_interact():
	DialogueManager.start_dialogue(global_position, dialogue.lines, false, speech_sfx)
	await DialogueManager.dialog_finished

func _on_end_interact():
	if DialogueManager.is_dialog_active:
		DialogueManager.end_dialogue()
	
