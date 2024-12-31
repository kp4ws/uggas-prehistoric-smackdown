extends Node

@export var main_menu_scene:String = ''
@export var game_over_scene:String = ''
#@export var animation_player: AnimationPlayer
@onready var animation_player = $CanvasLayer/BoneTransitionScreen/AnimationPlayer

@export var level_scenes: Array[String] = []
var current_scene_index: int = 0



func _ready():
	GlobalSignals.start_game.connect(load_first_level)
	GlobalSignals.game_over.connect(load_game_over)
	GlobalSignals.reload_level.connect(reload_current_scene)
	GlobalSignals.load_next_level.connect(load_next_scene)
	
	#Always force alpha to 0 in case player restarts game in the middle of transition.
	#$CanvasLayer/TextureRect.modulate.a = 0
	
	animation_player.animation_finished.connect(_on_animation_player_animation_finished)

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
	#get_tree().paused = true
	animation_player.play('fade_in')
	current_scene_index = scene_index

func _on_animation_player_animation_finished(anim_name):
	if anim_name == 'fade_in':
		get_tree().change_scene_to_file(level_scenes[current_scene_index % len(level_scenes)])
		animation_player.play('fade_out')
	else:
		print('test2')
		#get_tree().paused = false
		#Time to fully load the scene
		#TODO On heavier scenes, make need to increase timer ?
		await get_tree().create_timer(0.1).timeout
		#await get_tree().process_frame #This method doesn't await until scene is fully loaded

func load_scene(scene_index: int):
	await _perform_load(scene_index)

func load_next_scene():
	await load_scene(current_scene_index + 1)

func get_current_scene():
	return get_tree().current_scene

func reload_current_scene():
	get_tree().reload_current_scene()
	#load_scene(current_scene_index)

func load_main_menu():
	_load_scene_by_name(main_menu_scene)

func load_game_over():
	_load_scene_by_name(game_over_scene)
	
func load_pause_menu():
	pass
