extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# Reset ตัวแปร Global สำหรับ EP01
	Global.has_talked_to_kai = false
	Global.has_talked_to_mira = false
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass
