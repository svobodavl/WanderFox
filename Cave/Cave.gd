extends Node2D

const InvisibleWall = preload("res://Overlap/InvisibleWall.tscn")

func _on_BossFightTrigger_body_entered(body):
	var invisibleWall = InvisibleWall.instance()
	get_parent().add_child(invisibleWall)
