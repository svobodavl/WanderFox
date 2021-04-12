extends Node2D

const GrassEffect = preload("res://Effects/GrassEffect.tscn")

func create_grass_effect():
	var grassEffect = GrassEffect.instance()
	get_parent().add_child(grassEffect)
	grassEffect.global_position = global_position
	queue_free()

func _on_Hurtboxes_area_entered(area):
	create_grass_effect()
	queue_free()
