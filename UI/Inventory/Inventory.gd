extends Control

var is_visible = false

onready var bushSprite = $BushSprite

signal add_health_counter

func _ready():
	self.visible = false
	bushSprite.visible = false

func _physics_process(delta):
	if Input.is_action_just_pressed("open_inventory"):
		if visible == false:
			print("inventory open")
			self.visible = true
		else:
			self.visible = false
			print("inventory closed")

func _on_Chest3_chest_opened():
	bushSprite.visible = true

func health_potion_picked_up():
	print("+1 health")
	emit_signal("add_health_counter")
