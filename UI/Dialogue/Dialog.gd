extends Node2D

onready var textBoxOpacity = $TextBoxOpacity

signal BushAbilityUnlocked

func _ready():
	textBoxOpacity.play("Opacity")
	emit_signal("BushAbilityUnlocked")
	
	get_tree().call_group("Bushes", "CanHaveAbility")

func _on_TextBoxOpacity_animation_finished(anim_name):
	queue_free()
