extends Node

@export var main_menu_scene:String = ''
@export var game_over_scene:String = ''

@export var level_scenes = [
	"res://scenes/environment/levels/level1.tscn",
	"res://scenes/environment/levels/level2.tscn"
]
var current_scene_index: int = 0

func _ready():
	GlobalSignals.start_game.connect(load_first_level)
	GlobalSignals.game_over.connect(load_game_over)
	GlobalSignals.reload_level.connect(reload_current_scene)
	GlobalSignals.load_next_level.connect(load_next_scene)

func load_first_level():
	load_scene(0)

func _load_scene_by_name(scene: String):
	get_tree().change_scene_to_file(scene)
	await get_tree().create_timer(0.1).timeout

func _perform_load(scene_index: int):
	'''
	Private method for loading scenes
	'''
	#if scene_index < 0 or scene_index >= len(level_scenes):
		#printerr('Invalid scene index', scene_index)
		#return
	
	get_tree().change_scene_to_file(level_scenes[scene_index % len(level_scenes)])
	
	#Time to fully load the scene
	#TODO On heavier scenes, make need to increase timer ?
	await get_tree().create_timer(0.1).timeout
	#await get_tree().process_frame #This method doesn't await until scene is fully loaded
	
	current_scene_index = scene_index

func load_scene(scene_index: int):
	await _perform_load(scene_index)

func load_next_scene():
	await load_scene(current_scene_index + 1)

func get_current_scene():
	return get_tree().current_scene

func reload_current_scene():
	await load_scene(current_scene_index)

func load_main_menu():
	_load_scene_by_name(main_menu_scene)

func load_game_over():
	_load_scene_by_name(game_over_scene)
	
func load_pause_menu():
	pass
