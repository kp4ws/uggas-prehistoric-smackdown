extends Node2D

@onready var interaction_area = $InteractionArea
@export var new_scene_index: int

func _ready():
	interaction_area.interact = Callable(self, '_on_interact')

func _on_interact():
	#Save door position to respawn player at this point when re-entering the level
	#NOTE This should overwrite previous position as there should be only one spawn position saved for each level
	SceneManager.spawn_positions[SceneManager.current_scene] = position
	SceneManager.load_scene(new_scene_index)
	queue_free() #Removes door to ensure we just collide once
