extends CharacterBody2D
## player.gd — patched to self‑register into DialogHooks and support locking

@export var move_speed: float = 180.0
var is_player_locked: bool = false

func _ready() -> void:
	add_to_group("Player")
	if Engine.has_singleton("DialogHooks") or ("DialogHooks" in ProjectSettings.get_setting("autoloads")): # generic guard
		DialogHooks.set_player(self)

func set_player_locked(v: bool) -> void:
	is_player_locked = v
	if v:
		velocity = Vector2.ZERO

func _physics_process(delta: float) -> void:
	var input_vec := Vector2.ZERO
	if not is_player_locked:
		input_vec.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
		input_vec.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
		input_vec = input_vec.normalized()
	velocity = input_vec * move_speed
	if not is_on_floor():
		velocity.y += gravity * delta

	# รับค่าการกดปุ่ม ซ้าย-ขวา
	var direction := Input.get_axis("ui_left", "ui_right")

	# อัปเดต Animation และการหันซ้าย-ขวา
	if is_on_floor():
		if direction == 0:
			# ถ้าไม่ขยับ ให้เล่นท่า "idle"
			sprite_2d.play("idle")
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
		
	move_and_slide()

func _unhandled_input(event: InputEvent) -> void:
	if is_player_locked:
		return
