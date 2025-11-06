extends Node

@onready var Backgrondmusic = $AudioStreamPlayer

func play_Backgrondmusic():
	if not Backgrondmusic.playing:
		Backgrondmusic.play()
		print("BGM Started!")

func stop_Backgrondmusic():
	if Backgrondmusic.playing:
		Backgrondmusic.stop()
		print("BGM Stopped!")
