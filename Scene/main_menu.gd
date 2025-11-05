extends CanvasLayer

pass # Replace with function body.
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
#------------------------
	#เล่นเสียง Sound เมื่อเปิดเกม
	MusicManager.play_Backgrondmusic()
#------------------------
	
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float):
	Input.is_action_just_pressed("interact")
	SceneTransition.change_scene(SceneTransition.Scene1)
	
	
func _on_start_pressed() -> void:
	MusicManager.stop_Backgrondmusic()
	print("ไปซีนถัดไป")
	get_tree().change_scene_to_file("res://Scene/Scene1.tscn")

func _on_credit_pressed() -> void:
	print("ไปซีนถัดไป สมาชิกในทีม")
	get_tree().change_scene_to_file("res://UI/credit_scene.tscn")

func _on_quit_pressed() -> void:
	get_tree().quit()
