extends Node2D

@onready var health = $Health
@onready var sprite = $Sprite
@onready var collision_shape = $HitboxArea/CollisionShape2D

func _ready():
	health.entity_damaged.connect(_on_entity_damaged)
	health.entity_died.connect(_on_entity_died)
	
func _on_entity_damaged(attacker):
	print('Damaged: ', name, '. Health remaining: ', health.health)
	sprite.play("hurt")
	await get_tree().create_timer(0.4).timeout
	sprite.play('idle')
	
func _on_entity_died():
	sprite.play('death')
	collision_shape.disabled = true
