extends CanvasLayer

const Ep01 = ("res://Scene/EP01.tscn")
const Ep02 = ("res://Scene/EP02.tscn")
const Ep03 = ("res://Scene/EP03.tscn")
const Ep04 = ("res://Scene/EP04.tscn")
const Ep05 = ("res://Scene/EP05.tscn")
const Ep06 = ("res://Scene/EP06.tscn")
const Ep07 = ("res://Scene/EP07.tscn")
const Ep08 = ("res://Scene/EP08.tscn")

func change_scene(scene_path):
	%AnimationPlayer.play("fade_in")
	await %AnimationPlayer.animation_finished 
	get_tree().change_scene_to_file(scene_path)
	
	%AnimationPlayer.play_backwards("fade_in")
	
