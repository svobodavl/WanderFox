extends RichTextLabel

var health_potion_counter = 0

func _ready():
	var health_potion_counterText = String(health_potion_counter)
	self.clear()
	append_bbcode(health_potion_counterText)

func _on_Inventory_add_health_counter():
	health_potion_counter = health_potion_counter + 1
	var health_potion_counterText = String(health_potion_counter)
	print(health_potion_counter)
	self.clear()
	append_bbcode(health_potion_counterText)

func _on_Button_pressed():
	health_potion_counter = health_potion_counter - 1
	if health_potion_counter < 0:
		health_potion_counter = 0
	var health_potion_counterText = String(health_potion_counter)
	self.clear()
	append_bbcode(health_potion_counterText)

