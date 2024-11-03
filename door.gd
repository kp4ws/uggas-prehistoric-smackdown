extends Area2D

@export var new_scene_index: int
var showLabel: bool = false

func _ready():
	%EnterLabel.hide()
	showLabel = false
	body_entered.connect(_on_body_entered)
	body_exited.connect(_on_body_exited)

func _process(delta):
	if Input.is_action_just_pressed("enter") and showLabel:
		SceneManager.load_main_menu()
		queue_free() #Removes door to ensure we just collide once
	
func _on_body_entered(body: Node2D):
	%EnterLabel.show()
	showLabel = true

func _on_body_exited(body: Node2D):
	%EnterLabel.hide()
	showLabel = false
