extends AnimatedSprite

onready var tween = $Tween
onready var starting_pos = global_position
onready var trail = $"../Trail"
onready var collision = $Interactable/CollisionShape2D

export(int) var max_jump_height = 48
export(float) var jump_decrease = 0.5
export(int) var max_jumps = 3
export(float) var jump_time = 0.5
export (Vector2) var marker 
var end_pos
var i

func _ready():
	self.visible = false
	collision.disabled = true

func drop(e):
	global_position = starting_pos
	show()
	end_pos = e
	i = 0
	_bounce()

func _bounce():
	var cur_jump_height = max_jump_height * pow(jump_decrease, i)
	var start_y = global_position.y
	var jump_time_up = jump_time*cur_jump_height/(end_pos.y-start_y+cur_jump_height*2)
	var jump_time_down = jump_time - jump_time_up
	
	tween.interpolate_property(self, "global_position:x", global_position.x, \
		end_pos.x, jump_time)
	tween.interpolate_property(self, "global_position:y", start_y, \
		end_pos.y-cur_jump_height, jump_time_up, Tween.TRANS_QUAD, Tween.EASE_OUT)
	tween.interpolate_property(self, "global_position:y", \
		end_pos.y-cur_jump_height, end_pos.y, jump_time_down, \
		Tween.TRANS_QUAD, Tween.EASE_IN, jump_time_up)
	tween.start()
	
	i += 1

func _on_Tween_tween_all_completed():
	if i < max_jumps:
		_bounce()

func _on_Chest4_chest_opened():
	self.drop(marker)
	self.visible = true
	collision.disabled = false

func _on_Interactable_area_entered(area):
	print("Health potion picked up")
