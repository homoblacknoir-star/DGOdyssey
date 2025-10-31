extends CharacterBody2D
class_name Player

@export var move_speed: float = 180.0
var is_player_locked: bool = false

func set_player_locked(v: bool) -> void:
	is_player_locked = v
	# ตัวเลือก: หยุดความเร็ว / รีเซ็ตอินพุต
	if v:
		velocity = Vector2.ZERO
		
const SPEED = 200.0
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
			sprite_2d.play("running")
		else:
			sprite_2d.play("running")
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
	


	
	
