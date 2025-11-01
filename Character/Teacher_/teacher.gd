extends Area2D

var is_active: bool = true

# ตัวแปรเช็คผู้เล่น: true = ผู้เล่นอยู่ในระยะ
var player_is_near: bool = false
var showInteractionLabel = false  # เพิ่มบรรทัดนี้

# เชื่อมต่อ Signal ตอนเริ่ม
func _ready():
	#body_entered.connect(_on_body_entered)
	#body_exited.connect(_on_body_exited)
	
	# เชื่อมต่อ Dialogic signal เท่านั้น
	Dialogic.timeline_ended.connect(_on_dialogue_ended)

func _process(_delta):
	$Label.visible = showInteractionLabel
	if showInteractionLabel && Input.is_action_just_pressed("interact"):
		# เช็คเงื่อนไขก่อนเริ่มบทสนทนา
		if Global.can_talk_to_teacher():
			Dialogic.start("res://Dialog/Timeline/EP01/Teacher.dtl")
		else:
			# แสดงข้อความเตือนว่าต้องคุยกับ Kai และ Mira ก่อน
			var missing = []
			if not Global.has_talked_to_kai:
				missing.append("Kai")
			if not Global.has_talked_to_mira:
				missing.append("Mira")
			print("ลองไปคุยกับ " + ", ".join(missing) + " ก่อน!")
			# หรือใช้ Dialogic แสดงข้อความแทน
			# Dialogic.start("res://Dialog/Timeline/EP01/TeacherLocked.dtl")
	
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
		Dialogic.start("res://Dialog/Timeline/EP01/Teacher.dtl")
		# "ใช้สิทธิ์" ทันที (ตั้งเป็น false)
		is_active = false
		
		# [เพิ่ม] ซ่อน Label ทันที
		showInteractionLabel = false

func _on_dialogue_ended():
	# ทำให้ไม่สามารถโต้ตอบได้อีก (ถ้าต้องการ)
	is_active = false
	print("จบการสนทนากับ Teacher แล้ว")
