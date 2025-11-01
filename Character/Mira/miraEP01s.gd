extends Area2D

var is_active: bool = true

# ตัวแปรเช็คผู้เล่น: true = ผู้เล่นอยู่ในระยะ
var player_is_near: bool = false
var showInteractionLabel = false  # เพิ่มบรรทัดนี้
var started_dialogue: bool = false  # ตัวแปรเช็คว่าเริ่ม dialogue แล้วหรือยัง

# เชื่อมต่อ Signal ตอนเริ่ม
func _ready():
	# เชื่อมต่อ body entered/exited signals
	if not body_entered.is_connected(_on_body_entered):
		body_entered.connect(_on_body_entered)

	if not body_exited.is_connected(_on_body_exited):
		body_exited.connect(_on_body_exited)

	# เชื่อมต่อ Dialogic signal
	if not Dialogic.timeline_ended.is_connected(_on_dialogue_ended):
		Dialogic.timeline_ended.connect(_on_dialogue_ended)

func _process(_delta):
	$Label.visible = showInteractionLabel

func _on_body_entered(body):
	# [แก้ไข] ตรวจสอบว่าเป็น Player และ Object ยังใช้ได้
	if body is Player and is_active:
		player_is_near = true
		showInteractionLabel = true

# Player ออกไป
func _on_body_exited(body):
	if body is Player:
		player_is_near = false
		showInteractionLabel = false

func _unhandled_input(event: InputEvent):

	# ถ้า 1.ผู้เล่นอยู่ใกล้ 2.ยังไม่เคยใช้ 3.กดปุ่ม "interact"
	if player_is_near and is_active and event.is_action_pressed("interact"):
		started_dialogue = true  # ตั้งค่าว่าเริ่ม dialogue แล้ว
		Dialogic.start("res://Dialog/Timeline/EP01/Mira.dtl")
		showInteractionLabel = false
		# ไม่ต้อง disable ที่นี่ เพราะจะ disable ใน _on_dialogue_ended() แทน
func _on_dialogue_ended():
	# ตรวจสอบว่า Mira เป็นคนเริ่ม dialogue หรือไม่
	print("=== Mira _on_dialogue_ended ===")
	print("started_dialogue: ", started_dialogue)

	if started_dialogue:
		print("Setting has_talked_to_mira = true")
		Global.has_talked_to_mira = true
		is_active = false
		showInteractionLabel = false
		started_dialogue = false  # reset flag
		# Only disconnect if still connected to avoid runtime errors
		if Dialogic.timeline_ended.is_connected(_on_dialogue_ended):
			Dialogic.timeline_ended.disconnect(_on_dialogue_ended)
	
