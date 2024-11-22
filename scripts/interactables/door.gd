extends Node2D

@onready var interaction_area = $InteractionArea
@export var new_scene_index: int

func _ready():
	interaction_area.interact = Callable(self, '_on_interact')

func _on_interact():
	SceneManager.load_next_scene()
	queue_free() #Removes door to ensure we just collide once
