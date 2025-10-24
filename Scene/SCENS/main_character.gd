extends CharacterBody2D


# ตัวแปรสำหรับเก็บวัตถุที่อยู่ในระยะ (เราจะโต้ตอบกับตัวที่ใกล้ที่สุด)
var interactable_in_range: Node2D = null

func _ready():
	# ตรวจสอบว่า Node ลูกมีอยู่จริง
	if $Area2D == null:
		print("ERROR: ไม่พบ Node 'InteractionArea' ใน Player!")
		return

	# เชื่อมต่อ Signal จาก Area2D (ต้องทำใน Editor หรือผ่านโค้ด)
	$Area2D.area_entered.connect(_on_area_2d_area_entered)
	$Area2D.area_exited.connect(_on_area_2d_area_exited)

# ฟังก์ชันนี้จะทำงานเมื่อมี "พื้นที่" (Area2D) เข้ามาในระยะ
func _on_area_2d_area_entered(area: Area2D):
	# ตรวจสอบว่าวัตถุนั้น "สามารถโต้ตอบได้" หรือไม่
	# เราใช้วิธีเช็คว่ามันมีฟังก์ชันชื่อ "interact" อยู่ในสคริปต์หรือไม่
	if area.has_method("ui_select"):
		interactable_in_range = area
		print("เข้าใกล้: ", area.name)

# ฟังก์ชันนี้จะทำงานเมื่อ "พื้นที่" (Area2D) ออกจากระยะ
func _on_area_2d_area_exited(area: Area2D):
	# ถ้าวัตถุที่ออกจากระยะ คือวัตถุที่เราเก็บไว้ ก็เคลียร์ค่า
	if area == interactable_in_range:
		interactable_in_range = area
		print("ออกห่าง: ", area.name)

func _unhandled_input(event):
	# เมื่อผู้เล่นกดปุ่ม "interact"
	if event.is_action_pressed("ui_select"):
		# และมีวัตถุอยู่ในระยะ
		if interactable_in_range != null :
			# สั่งให้วัตถุนั้นทำงาน!
			interactable_in_range.interact()
const SPEED = 150.0
const JUMP_VELOCITY = -400.0
@onready var sprite_2d: AnimatedSprite2D = $Sprite2D

# เราต้องดึงค่า gravity ของโปรเจกต์มาใช้
var gravity: float = ProjectSettings.get_setting("physics/2d/default_gravity")


func _physics_process(delta: float) -> void:
	# เพิ่มแรงโน้มถ่วงเมื่อตัวละครไม่ได้อยู่บนพื้น
	if not is_on_floor():
		velocity.y += gravity * delta

	# รับค่าการกดปุ่ม ซ้าย-ขวา
	var direction := Input.get_axis("ui_left", "ui_right")

	# อัปเดต Animation และการหันซ้าย-ขวา
	if is_on_floor():
		if direction == 0:
			# ถ้าไม่ขยับ ให้เล่นท่า "idle"
			sprite_2d.play("default_right")
		elif direction > 0 :
			# ถ้าขยับ ให้เล่นท่า "running"
			sprite_2d.play("walk")
		else:
			sprite_2d.play("walk")
	else:
		# ถ้าลอยอยู่ ให้เล่นท่า "jumping"
		sprite_2d.play("jumping")
		
	# การหันตัวละคร (flip sprite)
	if direction > 0: # > 0 คือไปทางขวา
		sprite_2d.flip_h = false
	elif direction < 0: # < 0 คือไปทางซ้าย
		sprite_2d.flip_h = true


	# จัดการการเคลื่อนที่
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		
	# จัดการการกระโดด
	if Input.is_action_just_pressed("ui_up") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# สั่งให้ตัวละครเคลื่อนที่
	move_and_slide()
	
	
