extends StaticBody2D

var CanOpen = false
var DialogBox = load("res://UI/Dialogue/Dialog.tscn")
var damage = 0

export var path : NodePath
export (PackedScene) var Item
export (Vector2) var ItemPosition

signal chest_opened

onready var animationPlayer = $AnimationPlayer
onready var animatedSprite = $AnimatedSprite
onready var interactable = $Interactable
onready var interactableDisable = $Interactable/Disable

var IsOpen = false

func _ready():
	animationPlayer.stop()
	animatedSprite.stop()

	
func _process(delta):
	if CanOpen:
		if Input.is_action_just_pressed("interact"):
			if IsOpen == false:
				animationPlayer.play("Open")

func _on_AnimatedSprite_animation_finished():
	animatedSprite.stop()
	animatedSprite.frame = 1
	
	emit_signal("chest_opened")
	get_tree().call_group("Bushes", "CanHaveAbility")
	
	var item = Item.instance()
	get_node(path).add_child(item)
	item.position = ItemPosition

func _on_Interactable2_area_entered(area):
	CanOpen = true


func _on_Interactable2_area_exited(area):
	CanOpen = false
