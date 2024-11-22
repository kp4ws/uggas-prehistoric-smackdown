extends Camera2D

@export var randomStrength: float = 30.0
@export var shakeFade: float = 5.0
@export var player_data : PlayerData

var rng = RandomNumberGenerator.new()
var shake_strength: float = 0.0

func _ready():
	player_data.health_changed.connect(apply_shake)

func _process(delta):
	if shake_strength > 0:
		shake_strength = lerpf(shake_strength, 0, shakeFade * delta)
	
	offset = _randomOffset()

func apply_shake():
	print('test')
	shake_strength = randomStrength

func _randomOffset() -> Vector2:
	return Vector2(rng.randf_range(-shake_strength, shake_strength), rng.randf_range(-shake_strength, shake_strength))
