extends ParallaxBackground

@export var scrolling_speed: int = 40
@export var parallax_layers: Array[ParallaxLayer]

#TODO Handle screen sizes accordingly
#TODO This function should be registered as a callback that is triggered when screen resolution changes
func _on_resolution_changed():
	for layer in parallax_layers:
		layer.motion_offset.y = -200 #-200 works well on my laptop screen and 0 works good on my monitor screen

func _process(delta):
	scroll_offset.x -= scrolling_speed*delta
