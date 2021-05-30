extends Sprite

signal doesnt_have_bush_on
signal has_bush_on

func _process(delta):
	if Input.is_action_just_pressed("attack") or Input.is_action_just_pressed("roll"):
		reset_player_speed()
		queue_free()

func _ready():
	emit_signal("has_bush_on")
	get_tree().call_group("Player", "has_bush_ability_on")

func reset_player_speed():
	emit_signal("doesnt_have_bush_on")
	get_tree().call_group("Player", "doesnt_have_bush_ability_on")
