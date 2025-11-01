extends Node

# ตัวแปรติดตามสถานะการสนทนา
var has_talked_to_kai: bool = false
var has_talked_to_mira: bool = false

# ฟังก์ชันเช็คว่าคุยครบทั้ง 2 คนแล้วหรือยัง
func can_talk_to_teacher() -> bool:
	return has_talked_to_kai and has_talked_to_mira
