extends Node2D

onready var textBoxOpacity = $TextBoxOpacity


func _ready():
	textBoxOpacity.play("Opacity")


func _on_TextBoxOpacity_animation_finished(anim_name):
	queue_free()
