extends Node2D

func _ready():
	get_window().content_scale_factor = 3
	#Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)

func _on_interaction_area_body_entered(body):
	pass # Replace with function body.
