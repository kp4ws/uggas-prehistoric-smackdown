extends Camera2D

@export var randomStrength: float = 30.0
@export var shakeFade: float = 5.0
@export var player_data : PlayerData

var rng = RandomNumberGenerator.new()
var shake_strength: float = 0.0

func _ready():
	player_data.health_changed.connect(apply_shake)
	
	#This code ensures the camera immediately snaps to place when level is loaded
	reset_smoothing()
	position_smoothing_enabled = false
	await get_tree().create_timer(0.3).timeout
	position_smoothing_enabled = true

func _process(delta):
	if shake_strength > 0:
		shake_strength = lerpf(shake_strength, 0, shakeFade * delta)
	
	offset = _randomOffset()

func apply_shake():
	shake_strength = randomStrength

func _randomOffset() -> Vector2:
	return Vector2(rng.randf_range(-shake_strength, shake_strength), rng.randf_range(-shake_strength, shake_strength))
