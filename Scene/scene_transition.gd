extends CanvasLayer

const Ep01 = ("res://Scene/EP01.tscn")

func change_scene(scene_path):
	%AnimationPlayer.play("fade_in")
	await %AnimationPlayer.animation_finished 
	get_tree().change_scene_to_file(scene_path)
	
	%AnimationPlayer.play_backwards("fade_in")
	
