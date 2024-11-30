extends Control

func _ready():
	get_window().content_scale_factor = 1
	MusicManager.play_menu_music()

func _on_play_pressed():
	GlobalSignals.start_game.emit()

func _on_options_pressed():
	#TODO options menu
	print('Options Menu')

func _on_quit_pressed():
	get_tree().quit()
