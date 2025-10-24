extends Area2D

# ตัวแปรสำหรับเช็คว่าผู้เล่นอยู่ในระยะหรือไม่
var player_is_near = false

# ซ่อนปุ่ม "E" ตอนเริ่ม
func _ready():
	$Label.hide()

# ฟังก์ชันนี้จะทำงานอัตโนมัติเมื่อ "Body" (เช่น Player) เข้ามาในพื้นที่
func _on_body_entered(body):
	# เช็คว่า Body ที่เข้ามา อยู่ในกลุ่ม "Player" หรือไม่
	if body.is_in_group("Player"):
		player_is_near = true
		$Label.show() # แสดงปุ่ม "E"

# ฟังก์ชันนี้จะทำงานอัตโนมัติเมื่อ "Body" ออกจากพื้นที่
func _on_body_exited(body):
	if body.is_in_group("Player"):
		player_is_near = false
		$Label.hide() # ซ่อนปุ่ม "E"

# Godot จะคอยดักจับ Input ที่ยังไม่มีใครใช้
func _unhandled_input(event):
	# ถ้าผู้เล่นอยู่ในระยะ และ กดปุ่ม "interact"
	if player_is_near and event.is_action_pressed("interact"):
		# สั่งให้ Input นี้ "จบ" ที่นี่ (ป้องกันไม่ให้วัตถุอื่นทำงานซ้ำซ้อน)
		get_viewport().set_input_as_handled()
		
		# เรียกฟังก์ชันหลักของเรา
		interact()

# ฟังก์ชันการโต้ตอบหลัก (จะทำอะไรก็ใส่ตรงนี้)
func interact():
	
	# คุณสามารถเริ่มระบบ Dialog จากตรงนี้ได้เลย
	Dialogic.start_dialogue("res://Dialog/Timeline/timeline.dtl")
