extends Control

func _on_play_pressed():
	GlobalSignals.start_game.emit()
	MusicManager.play_game_music()

func _on_quit_pressed():
	get_tree().quit()
