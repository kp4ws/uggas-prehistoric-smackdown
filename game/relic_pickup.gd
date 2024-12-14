extends Node2D

@export var player_data: PlayerData
@export var min_flip_time: float = 1.5
@export var max_flip_time: float = 4.0

@onready var area_2d = $Area2D
@onready var sprite = $Sprite
@onready var flash_timer = $FlashTimer

var rng = RandomNumberGenerator.new()

func _ready():
	area_2d.body_entered.connect(_on_area_2d_body_entered)
	flash_timer.timeout.connect(_on_time_out)
	flash_timer.start(_get_random_time())
	
func _on_area_2d_body_entered(body):
	player_data.add_to_score(1)
	queue_free()

func _get_random_time() -> float:
	return rng.randf_range(min_flip_time, max_flip_time)

func _on_time_out():
	sprite.play("flash")
	flash_timer.start(_get_random_time())
