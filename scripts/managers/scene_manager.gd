extends Node

@export var main_menu_scene:String = ''
@export var game_over_scene:String = ''
#@export var animation_player: AnimationPlayer
@onready var animation_player = $CanvasLayer/BoneTransitionScreen/AnimationPlayer

@export var level_scenes: Array[String] = []
var current_scene: String = ''
var spawn_positions: Dictionary

func _ready():
	GlobalSignals.start_game.connect(load_first_level)
	GlobalSignals.game_over.connect(load_game_over)
	GlobalSignals.reload_level.connect(reload_current_scene)
	GlobalSignals.load_next_level.connect(load_next_scene)
	
	#Always force alpha to 0 in case player restarts game in the middle of transition.
	#$CanvasLayer/TextureRect.modulate.a = 0
	
	animation_player.animation_finished.connect(_on_animation_player_animation_finished)

#func _process(delta):
	#if ResourceLoader.load_threaded_get_status(level_scenes[current_scene_index % len(level_scenes)]) == ResourceLoader.THREAD_LOAD_IN_PROGRESS:
		#pass

func load_first_level():
	load_scene(0)

func _perform_load(scene: String):
	'''
	Private method for loading scenes
	'''
	animation_player.play('fade_in')
	#Prepare new level asynchronously
	ResourceLoader.load_threaded_request(scene)

#TODO Can I just call this from animation player?
func _on_animation_player_animation_finished(anim_name):
	if anim_name == 'fade_in':
		get_tree().current_scene.queue_free()
		
		#Block further code from running until resource is fully loaded
		while (ResourceLoader.load_threaded_get_status(current_scene) == ResourceLoader.THREAD_LOAD_IN_PROGRESS):
			pass
		
		animation_player.play('fade_out')
			
		if ResourceLoader.load_threaded_get_status(current_scene) == ResourceLoader.THREAD_LOAD_LOADED:
			# Obtain the resource now that we need it.
			var level_scene = ResourceLoader.load_threaded_get(current_scene)
			var level = level_scene.instantiate()
			get_tree().root.add_child(level)
			get_tree().current_scene = level #Without this line, then when trying to queue_free current scene it will have null reference
		else:
			printerr('ResourceLoader ran into error while loading scene')

func load_scene(scene_index: int):
	current_scene = level_scenes[scene_index % len(level_scenes)]
	_perform_load(current_scene)

func load_next_scene():
	var current_scene_index = level_scenes.find(current_scene)
	if current_scene_index == -1:
		printerr('current scene not in level scenes')
		return
		
	load_scene(current_scene_index + 1)

func get_current_scene():
	return get_tree().current_scene

#TODO May need to refactor later
func reload_current_scene():
	_perform_load(current_scene)
	
	#get_tree().reload_current_scene()
	
	#load_scene(current_scene_index)

func load_main_menu():
	_perform_load(main_menu_scene)

func load_game_over():
	_perform_load(game_over_scene)
	
func load_pause_menu():
	pass
