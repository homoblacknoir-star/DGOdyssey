extends Node2D

pass # Replace with function body.
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float):
	Input.is_action_just_pressed("interact")
	SceneTransition.change_scene(SceneTransition.Scene1)
	
	
