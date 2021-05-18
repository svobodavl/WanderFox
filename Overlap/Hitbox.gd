extends Area2D

var damage = 1

var percent = randf()

func _process(delta):
	if (percent > 0.8):
		damage = 3
