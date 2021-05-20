extends Control

func _input(event):
	if event.is_action_pressed("pause"):
		var new_pause_state = not get_tree().paused
		get_tree().paused = new_pause_state
		self.visible = new_pause_state
		
	if event.is_action_pressed("ui_accept"):
		get_tree().quit()
