extends CanvasLayer

@export var level_title: String
@export var label: Label
@export var animation_player: AnimationPlayer

#Ensures the title is only displayed once in a level
var displayedFlag: bool = false

func _ready():
	label.text = level_title
	#label.modulate.a = 100

func _unhandled_input(event):
	if displayedFlag:
		return
		
	if event.is_action_pressed('move_left') or event.is_action_pressed('move_right'):
		await get_tree().create_timer(0.2).timeout
		animation_player.play('fade_out')
		displayedFlag = true
