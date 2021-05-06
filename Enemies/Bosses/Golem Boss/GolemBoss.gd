extends KinematicBody2D

var state = IDLE

onready var actionCooldown = $ActionCooldown
onready var animatedSprite = $AnimatedSprite

enum {
	IDLE
	DEFEND
	SPAWN_ENEMY
	THROW
}

func _ready():
	state = IDLE

func _physics_process(delta):
	match state:
		IDLE:
			animatedSprite.play("Idle")
			
		DEFEND:
			animatedSprite.play("Protect")
			
		SPAWN_ENEMY:
			animatedSprite.play("Spawn Enemy Attack")
			
		THROW:
			animatedSprite.play("Throw Attack")

func pick_random_state(state_list):
	state_list.shuffle()
	return state_list.pop_front()

func _on_BossFightTrigger_body_entered(body):
	actionCooldown.start()
