extends CanvasLayer

func _process(delta):
	InputEvent 		
	if Input.is_action_just_pressed("pause"):
		_toggle_visibility()
	
func _toggle_visibility():
	self.visible = !self.visible
	get_tree().paused = self.visible

func _on_continue_pressed():
	_toggle_visibility()

func _on_quit_pressed():
	SceneManager.load_main_menu()
