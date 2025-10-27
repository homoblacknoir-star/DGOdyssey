extends Area2D

var showInteractionLabel = false
@export var next_scene: PackedScene

func _ready():
	$Label.hide()
	
func _process(_delta):
	$Label.visible = showInteractionLabel
	
	if showInteractionLabel && Input.is_action_just_pressed("interact"):
		
		## [แก้ไข] นี่คือส่วนที่เปลี่ยนจาก Dialogic
		# "res://EP01.tscn" คือ Path ของฉาก (ลากไฟล์มาวางในวงเล็บได้เลย)
		var error = get_tree().change_scene_to_file("res://EP01.tscn")
		
		if error != OK:
			printerr("ERROR: ไม่สามารถโหลดฉาก 'res://EP01.tscn' ได้, ตรวจสอบ Path")
		## ------------------------------------------
	
	
func _on_body_entered(body: Node2D) -> void:
		if body is Player:
			showInteractionLabel = true
	
func _on_body_exited(body: Node2D) -> void:
		if body is Player:
			showInteractionLabel = false
