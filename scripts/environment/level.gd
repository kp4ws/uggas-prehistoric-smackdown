extends Node2D

func _ready():
	var Relics = %Relics
	if not Relics:
		printerr('Relics container not in level')
		return
		
	#GameManager.initiate_level(Relics.get_child_count())

func _on_interaction_area_body_entered(body):
	pass # Replace with function body.
