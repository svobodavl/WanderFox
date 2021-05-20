extends RichTextLabel

var health_potion_counter = 0

func _on_Inventory_add_health_counter():
	health_potion_counter = health_potion_counter + 1
	var health_potion_counterText = String(health_potion_counter)
	print(health_potion_counter)
	self.clear()
	append_bbcode(health_potion_counterText)
