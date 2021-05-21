extends Control


func _process(delta):
	if Input.is_action_pressed("pause"):
		var new_pause_state = not get_tree().paused
		get_tree().paused = new_pause_state
		self.visible = new_pause_state
		if Input.is_action_pressed("ui_accept"):
			get_tree().quit()


func _on_GolemBoss_boss_died():
	var new_pause_state = not get_tree().paused
	get_tree().paused = new_pause_state
	self.visible = new_pause_state
	if Input.is_action_pressed("ui_accept"):
		get_tree().quit()
