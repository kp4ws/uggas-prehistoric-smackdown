extends AnimatedSprite2D
@onready var flip_timer = $FlipTimer

@export var min_flip_time: float = 5.0
@export var max_flip_time: float = 8.0
var rng = RandomNumberGenerator.new()

func _get_random_time() -> float:
	return rng.randf_range(min_flip_time, max_flip_time)

func _ready():
	flip_timer.timeout.connect(_on_time_out)
	flip_timer.start(_get_random_time())

func _on_time_out():
	flip_h = !flip_h
	flip_timer.start(_get_random_time())
