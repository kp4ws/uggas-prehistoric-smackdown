extends Control

func _ready():
	get_window().content_scale_factor = 1
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	MusicManager.play_menu_music()

func _on_continue_pressed():
	SceneManager.reload_last_scene()

func _on_quit_pressed():
	SceneManager.load_main_menu()
