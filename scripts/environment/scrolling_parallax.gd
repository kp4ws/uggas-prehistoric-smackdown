extends ParallaxBackground

@export var scrolling_speed: int = 40
func _process(delta):
	scroll_offset.x -= scrolling_speed*delta
