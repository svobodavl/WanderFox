extends Node2D

const InvisibleWall = preload("res://Overlap/InvisibleWall.tscn")

func _ready():
	$AudioStreamPlayer.play()

func _on_BossFightTrigger_body_entered(body):
	var invisibleWall = InvisibleWall.instance()
	get_parent().add_child(invisibleWall)
	$AudioStreamPlayer.stop()
	$AudioStreamPlayer2.play()
