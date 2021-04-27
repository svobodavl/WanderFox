extends Area2D

var player = null
var active
var DetectionCollision = load(".")


func can_see_player():
	return player != null

func _on_PlayerDetectionZone_body_entered(body):
	player = body

func _on_PlayerDetectionZone_body_exited(body):
	player = null


func _on_Bat_disable_playerdetectionzone():
	queue_free()

func _on_Bat_enable_playerdetectionzone():
	pass

