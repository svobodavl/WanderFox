extends Control

var PlayerDied = false

onready var stats = $"/root/PlayerStats"

func _process(delta):
	if PlayerDied && Input.is_action_pressed("ui_accept"):
		get_tree().reload_current_scene()
		stats.health += 4

func _on_Player_player_died():
	var death_state = not get_tree().paused
	self.visible = death_state
	PlayerDied = true
