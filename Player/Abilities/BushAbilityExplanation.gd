extends Sprite

onready var animationPlayer = $AnimationPlayer

func _ready():
	animationPlayer.play("Opacity")
