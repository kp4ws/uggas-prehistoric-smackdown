extends Control

func _on_play_pressed():
	GlobalSignals.start_game.emit()

func _on_quit_pressed():
	get_tree().quit()
