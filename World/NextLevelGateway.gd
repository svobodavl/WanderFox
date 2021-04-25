extends Node2D


func _on_NextLevelGateway_area_entered(area):
	print("Can enter Next level")
	get_tree().change_scene_to(load("res://Cave/Cave.tscn"))
