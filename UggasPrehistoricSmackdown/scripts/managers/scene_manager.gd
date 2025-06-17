extends Node

@export var main_menu_scene: String = ''
@export var game_over_scene: String = ''
@export var level_scenes: Array[String] = []

@onready var animation_player: AnimationPlayer = $CanvasLayer/BoneTransitionScreen/AnimationPlayer

var current_scene: String = ''
var spawn_positions: Dictionary
var last_scene_index: int 

func _ready():
	GlobalSignals.start_game.connect(load_first_level)
	GlobalSignals.game_over.connect(load_game_over)
	GlobalSignals.reload_level.connect(reload_last_scene)
	GlobalSignals.load_next_level.connect(load_next_scene)
	
	#Always force alpha to 0 in case player restarts game in the middle of transition.
	#$CanvasLayer/TextureRect.modulate.a = 0

func _process(delta):
	if ResourceLoader.load_threaded_get_status(current_scene) == ResourceLoader.THREAD_LOAD_LOADED:
		if not animation_player.is_playing():
			_update_level()

func _perform_load(scene):
	'''
	Private method for loading scenes
	'''
	animation_player.play('fade_in')
	current_scene = scene
	ResourceLoader.load_threaded_request(current_scene)

func _update_level():
	'''
	Private method for updating to the next level once the ResourceLoader has finished
	'''
	print('updating level')
	
	get_tree().current_scene.queue_free()
	
	var level_scene = ResourceLoader.load_threaded_get(current_scene)
	var level = level_scene.instantiate()
	print(level, level_scene)
	get_tree().root.add_child(level)
	get_tree().current_scene = level #Without this line, then when trying to queue_free current scene it will have null reference
	
	animation_player.play('fade_out')

func load_first_level():
	load_scene(0)

func load_scene(scene_index: int):
	last_scene_index = scene_index
	_perform_load(level_scenes[scene_index])

func load_next_scene():
	var current_scene_index = level_scenes.find(current_scene)
	if current_scene_index == -1:
		printerr('current scene not in level scenes')
		return
	
	load_scene(current_scene_index + 1)

func get_current_scene():
	return get_tree().current_scene

func reload_last_scene():
	_perform_load(level_scenes[last_scene_index])

func load_main_menu():
	spawn_positions.clear()
	_perform_load(main_menu_scene)

func load_game_over():
	spawn_positions.clear()
	_perform_load(game_over_scene)
	
func load_pause_menu():
	pass
