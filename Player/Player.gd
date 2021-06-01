extends KinematicBody2D

const PlayerHurtSound = preload("res://Music and Sounds/PlayerHurtSound.tscn")
const Poop = preload("res://Player/Poop/Poop.tscn")

export var MAX_SPEED = 80
export var ACCELERATION = 500
export var FRICTION = 500
export var ROLL_SPEED = 120

enum {
	MOVE,
	ROLL,
	ATTACK
}

var sequence = [
	KEY_UP,
	KEY_UP
]
var sequence_index = 0

signal BatCantSeePlayer
signal BatCanSeePlayer
signal player_died

var state = MOVE 
var velocity = Vector2.ZERO
var roll_vector = Vector2.LEFT
var stats = PlayerStats

onready var animationPlayer = $AnimationPlayer
onready var animationTree = $AnimationTree
onready var animationState = animationTree.get("parameters/playback")
onready var swordHitbox = $HitboxPivot/SwordHitbox
onready var hurtbox = $Hurtboxes
onready var blinkAnimationPlayer = $BlinkAnimationPlayer
onready var cheatCodeTimer = $CheatCodeTimer
onready var light = $Light2D

func _ready():
	randomize()
	stats.connect("no_health", self, "queue_free")
	animationTree.active = true
	swordHitbox.knockback_vector = roll_vector

func _physics_process(delta):
	match state: 
		MOVE:
			move_state(delta)
		
		ROLL:
			roll_state(delta)
			
		ATTACK:
			attack_state(delta)
			
	if Input.is_key_pressed(KEY_UP):
		cheatCodeTimer.start()

func move_state(delta):
	var input_vector = Vector2.ZERO
	input_vector.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	input_vector.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	input_vector = input_vector.normalized()
	
	if input_vector != Vector2.ZERO:
		roll_vector = input_vector
		swordHitbox.knockback_vector = input_vector
		animationTree.set("parameters/Idle/blend_position", input_vector)
		animationTree.set("parameters/Run/blend_position", input_vector)
		animationTree.set("parameters/Attack/blend_position", input_vector)
		animationTree.set("parameters/Roll/blend_position", input_vector)
		animationState.travel("Run")
		velocity = velocity.move_toward(input_vector * MAX_SPEED, ACCELERATION * delta)
	else:
		animationState.travel("Idle")
		velocity = velocity.move_toward(Vector2.ZERO, FRICTION * delta)
	
	move()
	
	if Input.is_action_just_pressed("roll"):
		state = ROLL

	if Input.is_action_just_pressed("attack"):
		state = ATTACK

# warning-ignore:unused_argument
func roll_state(delta):
	velocity = roll_vector * ROLL_SPEED
	animationState.travel("Roll")
	move()
	
# warning-ignore:unused_argument
func attack_state(delta):
	velocity = Vector2.ZERO
	animationState.travel("Attack")
	
func move():
	velocity = move_and_slide(velocity)	
	
func roll_animation_finished():
	velocity = velocity / 2
	state = MOVE
	
func attack_animation_finished():
	state = MOVE

func _on_Hurtboxes_area_entered(area):
	stats.health -= area.damage
	hurtbox.start_invincibility(0.6)
	hurtbox.create_hit_effect()
	var playerHurtSound = PlayerHurtSound.instance()
	get_tree().current_scene.add_child(playerHurtSound)
	if stats.health <= 0:
		emit_signal("player_died")

func _on_Hurtboxes_invincibility_started():
	blinkAnimationPlayer.play("Start")

func _on_Hurtboxes_invincibility_ended():
	blinkAnimationPlayer.play("Stop")
	
func has_bush_ability_on():
	MAX_SPEED = 50
	ACCELERATION = 250
	get_tree().call_group("Bats", "bat_cant_see_player")
	emit_signal("BatCantSeePlayer")
	
func doesnt_have_bush_ability_on():
	MAX_SPEED = 80
	ACCELERATION = 500
	print("doesnt have bush")
	get_tree().call_group("Bats", "bat_can_see_player")
	emit_signal("BatCanSeePlayer")

func _on_Button_pressed():
	stats.health = stats.health + 1

func _on_CheatCode_done():
	var poop = Poop.instance()
	get_parent().add_child(poop)
	poop.global_position = global_position

func _on_BossFightTrigger_body_entered(body):
	light.scale.x += 5
	light.scale.y += 5
