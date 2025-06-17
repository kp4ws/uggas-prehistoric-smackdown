extends Node2D

@onready var top_collision: CollisionShape2D = $StaticBody2D/LadderTopCollision2D
@onready var area2D: Area2D = $Area2D

func _ready():
	area2D.body_entered.connect(_on_body_entered)
	area2D.body_exited.connect(_on_body_exited)

func _on_body_entered(body):
	if body.has_method('enable_climb'):
		body.enable_climb(self)
	else:
		printerr('Player missing enable climb function')

func _on_body_exited(body):
	if body.has_method('disable_climb'):
		body.disable_climb()
	else:
		printerr('Player missing disable climb function')
