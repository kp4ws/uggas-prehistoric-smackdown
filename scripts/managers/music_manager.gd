extends Node

@onready var audio_player = $AudioStreamPlayer

@export var menu_music: AudioStreamMP3 = null
@export var game_music: AudioStreamMP3 = null

func _ready():
	GlobalSignals.start_game.connect(play_game_music)
	#play_menu_music()

func play_menu_music():
	audio_player.stop()
	audio_player.set_stream(menu_music)
	audio_player.play()

func play_game_music():
	audio_player.stop()
	audio_player.set_stream(game_music)
	audio_player.play()
