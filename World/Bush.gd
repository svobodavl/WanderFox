extends StaticBody2D

export var path : NodePath

var Bush = load("res://World/BushAbility.tscn")
var CanInteract = false
var HasBush = false
var DoesntHaveBush = true
var CantHaveBushAbility = true

signal HasBushOn
signal DoesntHaveBushOn

func _ready():
	add_to_group("Bushes")

func _process(delta):
	if CanInteract:
		if CantHaveBushAbility == false:
			if Input.is_action_just_pressed("bush_ability"):
				var bush = Bush.instance()
				get_node("../../Player/Sprite").add_child(bush)
				bush.position = Vector2(get_parent().global_position)
				emit_signal("HasBushOn")
				get_tree().call_group("BushAbility", "has_bush_on")
				queue_free()

func _on_Interactable_area_entered(area):
	if CantHaveBushAbility == false:
		CanInteract = true
		print("can interact")

func _on_Interactable_area_exited(area):
	CanInteract = false

func CanHaveAbility():
	CantHaveBushAbility = false
