extends Node2D
class_name GameBus

## SIGNALS
signal game_state_changed(new_state: GameState)

## ENUMS
# สถานะของเกม
enum GameState {
	PLAY,    # สถานะปกติที่ผู้เล่นขยับได้
	DIALOG   # สถานะที่กำลังแสดง Dialog (ผู้เล่นขยับไม่ได้)
}

## STATE
var current_state: GameState = GameState.PLAY

## PUBLIC API
# เรียกฟังก์ชันนี้เมื่อเริ่มแสดง Dialog
func start_dialog() -> void:
	if current_state == GameState.PLAY:
		current_state = GameState.DIALOG
		game_state_changed.emit(current_state)

# เรียกฟังก์ชันนี้เมื่อ Dialog จบลง
func end_dialog() -> void:
	if current_state == GameState.DIALOG:
		current_state = GameState.PLAY
		game_state_changed.emit(current_state)
