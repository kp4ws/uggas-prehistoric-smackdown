extends CanvasLayer

@onready var margin_container = $TextBoxMarginContainer
@onready var label = %Label
@onready var timer = %LetterDisplayTimer
@onready var audio_player: AudioStreamPlayer2D = $AudioStreamPlayer2D

const MAX_WIDTH = 256
var text = ""
var letter_index = 0
var letter_time = 0.03
var space_time = 0.06
var punctuation_time = 0.2

signal finished_displaying()

var sfx: Array[AudioStream]

func display_full_text(text_to_display: String):
	label.text = text_to_display
	
	await margin_container.resized
	margin_container.custom_minimum_size.x = min(margin_container.size.x, MAX_WIDTH)
	
	if margin_container.size.x > MAX_WIDTH:
		label.autowrap_mode = TextServer.AUTOWRAP_WORD
		await margin_container.resized #wait for x resize
		await margin_container.resized #wait for y resize
		margin_container.custom_minimum_size.y = margin_container.size.y

	margin_container.global_position.x -= (margin_container.size.x / 2) * margin_container.scale.x
	margin_container.global_position.y -= (margin_container.size.y + 24) * margin_container.scale.y
	
	finished_displaying.emit()

func display_text(text_to_display: String, speech_sfx: Array[AudioStream]):
	text = text_to_display
	label.text = text_to_display
	#audio_player.stream = speech_sfx
	sfx = speech_sfx
	
	await margin_container.resized
	margin_container.custom_minimum_size.x = min(margin_container.size.x, MAX_WIDTH)
	
	if margin_container.size.x > MAX_WIDTH:
		label.autowrap_mode = TextServer.AUTOWRAP_WORD
		await margin_container.resized #wait for x resize
		await margin_container.resized #wait for y resize
		margin_container.custom_minimum_size.y = margin_container.size.y

	margin_container.global_position.x -= (margin_container.size.x / 2) * margin_container.scale.x
	margin_container.global_position.y -= (margin_container.size.y + 24) * margin_container.scale.y
	
	label.text = ''
	_display_letter()
	
func _display_letter():
	label.text += text[letter_index]
	
	letter_index += 1
	if letter_index >= text.length():
		finished_displaying.emit()
		return
	
	var sfxFlag = false
	match text[letter_index]:
		'!', '.', ',', '?':
			timer.start(punctuation_time)
			sfxFlag = true
		' ':
			timer.start(space_time)
			sfxFlag = true
		_:
			timer.start(letter_time)
			sfxFlag = false
	
	if sfxFlag:	
		var new_audio_player: AudioStreamPlayer2D = audio_player.duplicate()
		new_audio_player.pitch_scale += randf_range(-0.1, 0.15)
		if text[letter_index] in ['a', 'e', 'i', 'o', 'u']:
			new_audio_player.pitch_scale += 0.25
		get_tree().root.add_child(new_audio_player)
		var sfx_selection = randi_range(0, len(sfx)-1)
		new_audio_player.stream = sfx[sfx_selection]
		new_audio_player.play()
		await new_audio_player.finished
		new_audio_player.queue_free()
		
func _on_letter_display_timer_timeout():
	_display_letter()
