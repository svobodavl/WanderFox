extends RichTextLabel

var dialog = [
	"[center]You found the Bush ability[/center]",
]
var page = 0

onready var bushAbilityExplanation = $BushAbilityExplanation

func _ready():
	set_bbcode(dialog[page])
	set_visible_characters(0)
	set_process_input(true)
	bbcode_enabled = true
	
func _input(event):
	if Input.is_mouse_button_pressed(1):
		if get_visible_characters() > get_total_character_count():
			if page < dialog.size()-1:
				page += 1
				set_bbcode(dialog[page])
				set_visible_characters(0)

func _on_Timer_timeout():
	set_visible_characters(get_visible_characters() + 1)
