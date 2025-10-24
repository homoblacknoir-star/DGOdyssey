extends Node2D
@onready var interact_label: Label = $interactlabel
var current_interact :=[]
var can_interact := true

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("interact") and can_interact:
		if current_interact:
			can_interact = false 
			interact_label.hide()
		
		await current_interact[0].interact.call()
		
		can_interact = true

func _process(_delta: float) -> void:
	if current_interact and can_interact:
		current_interact.sort_custom(_sort_by_nearest)
		if current_interact[0].is_interactable:
			interact_label.text = current_interact[0].interact_name
			interact_label.show()
	else:
		interact_label.hide()

func _sort_by_nearest(area1, area2):
	var area1_dist = global_position.distance_to(area1.global_postion)
	var area2_dist = global_position.distance_to(area2.global_postion)
	return area1_dist < area2_dist

func _on_interact_range_area_entered(area: Area2D) -> void:
	current_interact.push_back(area)


func _on_interact_range_area_exited(area: Area2D) -> void:
	current_interact.erase(area)
