extends KinematicBody2D


onready var actionCooldown = $ActionCooldown
onready var animatedSprite = $AnimatedSprite

var state = IDLE
var BossFightTriggered = false
var Idle = false
var Defend = false
var Spawn_Enemy = false
var Throw = false

enum {
	IDLE
	DEFEND
	SPAWN_ENEMY
	THROW
}

func _ready():
	pass

func _physics_process(delta):
	if BossFightTriggered:
		match state:
			IDLE:
				print("Idle state")
				animatedSprite.play("Idle")
				Idle = true
				Defend = false
				Spawn_Enemy = false
				Throw = false
					
			DEFEND:
				print("Defend state")
				animatedSprite.play("Protect")
				Defend = true
				Idle = false
				Spawn_Enemy = false
				Throw = false
					
			SPAWN_ENEMY:
				print("Spawn_Enemy state")
				animatedSprite.play("Spawn Enemy Attack")
				Spawn_Enemy = true
				Defend = false
				Idle = false
				Throw = false
					
			THROW:
				print("Throw state")
				animatedSprite.play("Throw Attack")
				Throw = true
				Defend = false
				Spawn_Enemy = false
				Idle = false

func pick_random_state(state_list):
	state_list.shuffle()
	return state_list.pop_front()

func _on_BossFightTrigger_body_entered(body):
	print("Boss Fight trigger")
	BossFightTriggered = true
	state = pick_random_state([DEFEND, SPAWN_ENEMY, THROW, IDLE])
	actionCooldown.start()
	
func _on_AnimatedSprite_animation_finished():
	if Idle == true:
		state = pick_random_state([DEFEND, SPAWN_ENEMY, THROW])
		
	if Defend == true:
		state = pick_random_state([SPAWN_ENEMY, THROW, IDLE])
		
	if Spawn_Enemy == true:
		state = pick_random_state([DEFEND, THROW, IDLE])
		
	if Throw == true:
		state = pick_random_state([DEFEND, SPAWN_ENEMY, IDLE])
