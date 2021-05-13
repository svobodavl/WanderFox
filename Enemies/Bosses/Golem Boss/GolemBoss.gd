extends KinematicBody2D


onready var actionCooldown = $ActionCooldown
onready var animatedSprite = $AnimatedSprite
onready var stats = $Stats
onready var hurtbox = $Hurtboxes
onready var animationPlayer = $AnimationPlayer

const EnemyDeathEffect = preload("res://Effects/Effect Scenes/EnemyDeathEffect.tscn")
const Golem = preload("res://Enemies/Golem/Golem.tscn")

var state = IDLE
var BossFightTriggered = false
var Idle = false
var Defend = false
var Spawn_Enemy = false
var Throw = false
var GolemSpawned = false

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
				GolemSpawned = false
					
			DEFEND:
				print("Defend state")
				animatedSprite.play("Protect")
				Defend = true
				Idle = false
				Spawn_Enemy = false
				Throw = false
				GolemSpawned = false
				hurtbox.start_invincibility(0.1)
				
			SPAWN_ENEMY:
				print("Spawn_Enemy state")
				animatedSprite.play("Spawn Enemy Attack")
				Spawn_Enemy = true
				Defend = false
				Idle = false
				Throw = false
				if GolemSpawned == false:
					var golem = Golem.instance()
					get_parent().add_child(golem)
					golem.global_position = global_position
					GolemSpawned = true
				
			THROW:
				print("Throw state")
				animatedSprite.play("Throw Attack")
				Throw = true
				Defend = false
				Spawn_Enemy = false
				Idle = false
				GolemSpawned = false

func pick_random_state(state_list):
	state_list.shuffle()
	return state_list.pop_front()

func _on_AnimatedSprite_animation_finished():
	if Idle == true:
		state = pick_random_state([DEFEND, SPAWN_ENEMY, THROW])
		
	if Defend == true:
		state = pick_random_state([SPAWN_ENEMY, THROW, IDLE])
		
	if Spawn_Enemy == true:
		state = pick_random_state([DEFEND, THROW, IDLE])
		
	if Throw == true:
		state = pick_random_state([DEFEND, SPAWN_ENEMY, IDLE])


func _on_Hurtboxes_area_entered(area):
	stats.health -= 1
	hurtbox.create_hit_effect()
	hurtbox.start_invincibility(0.4)
	
func _on_Stats_no_health():
	queue_free()
	var enemyDeathEffect = EnemyDeathEffect.instance()
	get_parent().add_child(enemyDeathEffect)
	enemyDeathEffect.global_position = global_position


func _on_Hurtboxes_invincibility_started():
	animationPlayer.play("Start")

func _on_Hurtboxes_invincibility_ended():
	animationPlayer.play("Stop")

func _on_BossFightTrigger_body_entered(body):
	print("Boss Fight trigger")
	BossFightTriggered = true
	state = pick_random_state([DEFEND, SPAWN_ENEMY, THROW, IDLE])
	actionCooldown.start()
