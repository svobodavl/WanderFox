extends StaticBody2D

var CanOpen = false
var DialogBox = load("res://UI/Dialogue/Dialog.tscn")
var damage = 0

export var path : NodePath

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
	
	var dialogBox = DialogBox.instance()
	get_node("../../../CanvasLayer").add_child(dialogBox)
	dialogBox.position = Vector2(160, 170)

	


func _on_Interactable2_area_entered(area):
	CanOpen = true
	print("can interact")


func _on_Interactable2_area_exited(area):
	CanOpen = false
