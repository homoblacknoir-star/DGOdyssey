extends Area2D

var showInteractionLabel = false

func _ready():
	pass
	
func _process(_delta):
	$Label.visible = showInteractionLabel
	if showInteractionLabel && Input.is_action_just_pressed("interact"):
		Dialogic.start("res://Dialog/Timeline/AtWindow.dtl")
	
func _on_body_entered(body):
	if body is Player:showInteractionLabel = true


func _on_body_exited(body):
	if body is Player:showInteractionLabel = false
