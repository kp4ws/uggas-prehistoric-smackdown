extends Node2D

@onready var player = get_tree().get_first_node_in_group('player')
@onready var label: Label = %Label

const base_text = '[Up] to '
const vertical_height = 60
#Hold all interaction areas that can be interacted with
var active_areas = []
var can_interact = true

func register_area(area: InteractionArea):
	active_areas.push_back(area)
	
func unregister_area(area: InteractionArea):
	var index = active_areas.find(area)
	if index == -1:
		return
	await active_areas[0].end_interact.call()
	active_areas.remove_at(index)

func _process(delta):
	if active_areas.size() > 0 && can_interact:
		# The first active area is the one closest to the player
		active_areas.sort_custom(_sort_by_distance_to_player)
		label.text = base_text + active_areas[0].action_name
		label.global_position = active_areas[0].global_position
		label.global_position.y -= vertical_height
		label.global_position.x -= label.size.x / 2 #Center horizontally
		label.show()
	else:
		label.hide()

func _sort_by_distance_to_player(area1, area2):
	var area1_to_player = player.global_position.distance_to(area1.global_position)
	var area2_to_player = player.global_position.distance_to(area2.global_position)	
	return area1_to_player < area2_to_player


func _input(event):
	if event.is_action_pressed("interact") && can_interact:
		if active_areas.size() > 0:
			can_interact = false
			label.hide()
			
			#Since interact is a callable we cannot call it with just parenthesis
			#We expect this function to be asynchronous
			await active_areas[0].interact.call()
			
			can_interact = true
