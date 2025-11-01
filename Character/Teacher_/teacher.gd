extends Area2D

var is_active: bool = true

# ตัวแปรเช็คผู้เล่น: true = ผู้เล่นอยู่ในระยะ
var player_is_near: bool = false
var showInteractionLabel = false  # เพิ่มบรรทัดนี้

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
		print("=== Teacher Debug ===")
		print("has_talked_to_kai: ", Global.has_talked_to_kai)
		print("has_talked_to_mira: ", Global.has_talked_to_mira)
		print("can_talk_to_teacher: ", Global.can_talk_to_teacher())

		if Global.can_talk_to_teacher():
			print("Starting Teacher.dtl")
			Dialogic.start("res://Dialog/Timeline/EP01/Teacher.dtl")
			showInteractionLabel = false
			is_active = false  # ปิดการใช้งานหลังจากคุยสำเร็จ
		else:
			print("Starting TeacherLocked.dtl")
			Dialogic.start("res://Dialog/Timeline/EP01/TeacherLocked.dtl")
			showInteractionLabel = false
			# ไม่ต้อง disable is_active เพื่อให้สามารถคุยได้อีก

func _on_dialogue_ended():
	# ตรวจสอบว่า timeline ที่จบคือของ Teacher หรือไม่
	var timeline_path = Dialogic.current_timeline
	if timeline_path and "Teacher" in timeline_path:
		# ปิดการโต้ตอบหลังจากสนทนาจบเฉพาะเมื่อคุยสำเร็จแล้ว
		if Global.can_talk_to_teacher():
			is_active = false
		print("จบการสนทนากับ Teacher แล้ว")
