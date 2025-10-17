extends Control


func _on_start_pressed() :
	get_tree().change_scene_to_file("res://Scene/Scene1.tscn")

func _on_option_pressed() -> void:
	print("option pressed")


func _on_exit_pressed() -> void:
	get_tree().quit()
