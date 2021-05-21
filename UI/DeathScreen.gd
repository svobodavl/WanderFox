extends Control

func _on_Player_player_died():
	var death_state = not get_tree().paused
	get_tree().paused = death_state
	self.visible = death_state
	if Input.is_action_pressed("ui_accept"):
		get_tree().reload_current_scene()
		print("scene reloaded")
