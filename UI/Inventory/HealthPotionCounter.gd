extends RichTextLabel

var health_potion_counter = 0
signal heal


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
	if health_potion_counter < 0:
		health_potion_counter = 0
	if health_potion_counter > 0:
		health_potion_counter = health_potion_counter - 1
		signals_suck()
	var health_potion_counterText = String(health_potion_counter)
	self.clear()
	append_bbcode(health_potion_counterText)
	
func signals_suck():
	emit_signal("heal")
