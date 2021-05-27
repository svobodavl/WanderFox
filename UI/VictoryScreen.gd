extends Control

var BossDied = false

func _process(delta):
	if BossDied && Input.is_action_pressed("ui_accept"):
		get_tree().quit()

func _on_GolemBoss_boss_died():
	var new_pause_state = not get_tree().paused
	get_tree().paused = new_pause_state
	self.visible = new_pause_state
	BossDied = true
